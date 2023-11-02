import 'package:app_soma_conta/domain/Grupo.dart';
import 'package:app_soma_conta/persistencia/dao/BaseDado.dart';

class GrupoDAO extends BaseDAO<Grupo> {

  @override
  String get nomeTabela => "grupo";

  @override
  Grupo fromMapToEntity(Map<String, dynamic> map) {
    return Grupo.fromMapToEntity(map);
  }

  Future<List<Grupo>?> listarTodos() async {
    return await obterListaBase();
  }

  Future<int?> excluir(Grupo model) async {
    return await excluirBase(
        nomesFiltros: ["id"],
        valores: [model.id]);
  }

  Future<int?> criar(Grupo model) async {
    return await inserirBase(
        colunas: ["valor_total", "descricao"],
        valores: [model.valorTotal, model.descricao]
    );
  }

  void atualizar(Grupo model) async {
     atualizarBase (
        colunas: ["valor_total", "descricao"],
        nomesFiltros: ["id"],
        valores: [model.valorTotal, model.descricao, model.id]
    );
  }

}
