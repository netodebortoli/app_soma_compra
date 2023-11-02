import 'package:app_soma_conta/domain/Compra.dart';
import 'package:app_soma_conta/domain/Grupo.dart';
import 'package:app_soma_conta/persistencia/dao/BaseDado.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/ItemCompra.dart';

class CompraDao extends BaseDAO<Compra> {
  @override
  String get nomeTabela => "compra";

  @override
  Compra fromMapToEntity(Map<String, dynamic> map) {
    return Compra.fromMapToEntity(map);
  }

  _criarGrupoCompra(Compra model, int idCompra, Transaction txn) async {
    if (model.grupos!.isNotEmpty) {
      for (Grupo grupo in model.grupos!) {
        await txn.rawInsert(
            "INSERT INTO grupo_compra(id_grupo, id_compra) VALUES (?, ?)",
            [grupo.id, idCompra]);
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
        [model.descricao, model.tipoPagamento, model.tipoCompra, model.valorTotal, model.dataCompra, model.id]
      );
      await txn.rawDelete(
          "DELETE FROM grupo_compra WHERE id_compra = ?",
          [model.id]
      );
      await txn.rawDelete(
        "DELETE FROM item_compra WHERE id_compra = ?",
        [model.id]
      );
      _criarGrupoCompra(model, model.id, txn);
      _criarItemCompra(model, model.id, txn);
    });
  }

  Future<int?> criar(Compra model) async {
    final dbClient = await db;
    dbClient?.transaction((txn) async {
      int idCompra = await txn.rawInsert(
          "INSERT INTO compra(descricao, tipo_pagamento, tipo_compra, valor_total, data_compra) VALUES (?,?,?,?,?)",
          [model.descricao, model.tipoPagamento, model.tipoCompra, model.valorTotal, model.dataCompra]
      );
      _criarGrupoCompra(model, idCompra, txn);
      _criarItemCompra(model, idCompra, txn);
      return idCompra;
    });
  }

  Future<int?> excluir(Compra model) async {
    final dbClient = await db;
    dbClient?.transaction((txn) async {
      return await txn.rawDelete("DELETE FROM compra WHERE id = ?", [model.id]);
    });
  }

  Future<List<Compra>?> listarTodos() async {
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
}
