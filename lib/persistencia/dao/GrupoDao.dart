import 'package:app_soma_conta/domain/Grupo.dart';
import 'package:app_soma_conta/persistencia/dao/BaseDao.dart';

class GrupoDAO extends BaseDAO<Grupo> {
  @override
  String get nomeTabela => "grupo";

  @override
  Grupo fromMapToEntity(Map<String, dynamic> map) {
    return Grupo.fromMapToEntity(map);
  }

  Future<List<Grupo>> listarTodos() async {
    return await obterListaBase();
  }

  Future<int?> excluir(Grupo model) async {
    return await excluirBase(nomesFiltros: ["id"], valores: [model.id]);
  }

  Future<int?> criar(Grupo model) async {
    return await inserirBase(
        colunas: ["valor_total", "descricao"],
        valores: [model.valor_total, model.descricao]);
  }

  void atualizar(Grupo model) async {
    atualizarBase(
        colunas: ["valor_total", "descricao"],
        nomesFiltros: ["id"],
        valores: [model.valor_total, model.descricao, model.id]);
  }

  void atualizarGrupos(List<Grupo> grupos) async {
    final dbClient = await db;
    dbClient?.transaction((txn) async {
      for (Grupo g in grupos) {
        await txn.rawUpdate(
            "UPDATE grupo SET valor_total = ? WHERE id = ?",
            [g.valor_total, g.id]);
      }
    });
  }

  Future<List<Grupo>?> listarTodosGruposPorCompra(int idCompra) async {
    final dbClient = await db;

    List<Map<String, dynamic>>? list = await dbClient?.rawQuery(
        'SELECT DISTINCT * FROM $nomeTabela AS gp INNER JOIN grupo_compra gc ON gp.id = gc.id_grupo WHERE gc.id_compra = ?',
        [idCompra]);

    return list?.map((map) => fromMapToEntity(map)).toList();
  }
}
