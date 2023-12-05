import 'package:app_soma_conta/domain/Compra.dart';
import 'package:app_soma_conta/domain/Grupo.dart';
import 'package:app_soma_conta/domain/dto/dto_numerico.dart';
import 'package:app_soma_conta/domain/dto/dto_ordinal.dart';
import 'package:app_soma_conta/persistencia/dao/BaseDao.dart';
import 'package:app_soma_conta/persistencia/dao/GrupoDao.dart';
import 'package:app_soma_conta/utils/Formatacao.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/ItemCompra.dart';

class CompraDAO extends BaseDAO<Compra> {
  @override
  String get nomeTabela => "compra";

  final GrupoDAO _grupoDAO = GrupoDAO();

  @override
  Compra fromMapToEntity(Map<String, dynamic> map) {
    return Compra.fromMapToEntity(map);
  }

  DtoNumerico fromMapToDtoNumerico(Map<String, dynamic> map) {
    return DtoNumerico.fromMapToDtoNumerico(map);
  }

  DtoOrdinal fromMapToDtoOrdinal(Map<String, dynamic> map) {
    return DtoOrdinal.fromMapToDtoOrdinal(map);
  }

  atualizarValorTotalGrupo(Grupo grupo, Transaction txn) async {
    await txn.rawUpdate("UPDATE grupo SET valor_total = ? WHERE id = ?",
        [grupo.valor_total, grupo.id]);
  }

  _criarGrupoCompra(Compra model, int idCompra, Transaction txn) async {
    if (model.grupos!.isNotEmpty) {
      for (Grupo grupo in model.grupos!) {
        await txn.rawInsert(
            "INSERT INTO grupo_compra(id_grupo, id_compra) VALUES (?, ?)",
            [grupo.id, idCompra]);
        atualizarValorTotalGrupo(grupo, txn);
      }
    }
  }

  _criarItemCompra(Compra model, int idCompra, Transaction txn) async {
    if (model.itens!.isNotEmpty) {
      for (ItemCompra i in model.itens!) {
        await txn.rawInsert(
            "INSERT INTO item_compra(valor, descricao, quantidade, id_compra) VALUES (?,?,?,?)",
            [i.valor, i.descricao, i.quantidade, idCompra]);
      }
    }
  }

  void atualizar(Compra model) async {
    final dbClient = await db;
    dbClient?.transaction((txn) async {
      await txn.rawUpdate(
          "UPDATE compra SET descricao=?, tipo_pagamento=?, tipo_compra=?, valor_total=?, data_compra=? WHERE id = ?",
          [
            model.descricao,
            model.tipo_pagamento,
            model.tipo_compra,
            model.valor_total,
            formatarDateTimeToISOString(model.data_compra),
            model.id
          ]);
      await txn.rawDelete(
          "DELETE FROM grupo_compra WHERE id_compra = ?", [model.id]);
      await txn
          .rawDelete("DELETE FROM item_compra WHERE id_compra = ?", [model.id]);
      _criarGrupoCompra(model, model.id, txn);
      _criarItemCompra(model, model.id, txn);
    });
  }

  Future<int?> criar(Compra model) async {
    final dbClient = await db;
    dbClient?.transaction((txn) async {
      int idCompra = await txn.rawInsert(
          "INSERT INTO compra(descricao, tipo_pagamento, tipo_compra, valor_total, data_compra) VALUES (?,?,?,?,?)",
          [
            model.descricao,
            model.tipo_pagamento,
            model.tipo_compra,
            model.valor_total,
            formatarDateTimeToISOString(model.data_compra)
          ]);
      _criarGrupoCompra(model, idCompra, txn);
      _criarItemCompra(model, idCompra, txn);
      return idCompra;
    });
  }

  Future<int?> excluir(Compra model) async {
    final dbClient = await db;
    dbClient?.transaction((txn) async {
      Future<List<Grupo>?> gruposFromDB =
          _grupoDAO.listarTodosGruposPorCompra(model.id);
      List<Grupo>? grupos = [];
      gruposFromDB.then((value) {
        grupos = value;
        if (grupos != null && grupos!.isNotEmpty) {
          for (Grupo grupo in grupos!) {
            grupo.valor_total = grupo.valor_total! - model.valor_total!;
            atualizarValorTotalGrupo(grupo, txn);
          }
        }
      });
      return await txn.rawDelete("DELETE FROM compra WHERE id = ?", [model.id]);
    });
  }

  Future<List<Compra>> listarTodos() async {
    return await obterListaBase();
  }

  Future<List<Compra>?> listarTodasComprasGrupo(int idGrupo) async {
    final dbClient = await db;

    List<Map<String, dynamic>>? list = await dbClient?.rawQuery(
        'SELECT * FROM $nomeTabela c JOIN grupo_compra g ON '
        ' c.id = g.id_compra WHERE g.id_grupo = ?',
        [idGrupo]);

    return list?.map((map) => fromMapToEntity(map)).toList();
  }

  Future<List<DtoNumerico>?> getValorTotalPorMes(String ano) async {
    final dbClient = await db;

    List<Map<String, dynamic>>? list = await dbClient?.rawQuery(
        "SELECT strftime('%m',c.data_compra) as chave, SUM(c.valor_total) AS valor FROM $nomeTabela as c WHERE strftime('%Y',c.data_compra) = ? group by strftime('%m',c.data_compra)",
        [ano]);

    return list?.map((map) => fromMapToDtoNumerico(map)).toList();
  }

  Future<List<DtoOrdinal>?> getValorTotalPorTipoCompra(String ano) async {
    final dbClient = await db;

    List<Map<String, dynamic>>? list = await dbClient?.rawQuery(
        "SELECT tipo_compra as chave, SUM(valor_total) AS valor FROM $nomeTabela "
        " WHERE strftime('%Y',data_compra) = ? group by chave",
        [ano]);

    return list?.map((map) => fromMapToDtoOrdinal(map)).toList();
  }

  Future<List<DtoOrdinal>?> getValorTotalPorTipoPagamento(String ano) async {
    final dbClient = await db;

    List<Map<String, dynamic>>? list = await dbClient?.rawQuery(
        "SELECT tipo_pagamento as chave, SUM(valor_total) AS valor FROM $nomeTabela "
        " WHERE strftime('%Y',data_compra) = ? group by chave",
        [ano]);

    return list?.map((map) => fromMapToDtoOrdinal(map)).toList();
  }
}
