import 'package:app_soma_conta/domain/Grupo.dart';
import 'package:app_soma_conta/persistencia/dao/BaseDado.dart';
import 'package:app_soma_conta/persistencia/dao/BaseDaoImpl.dart';

class GrupoDAO extends BaseDAO<Grupo> implements BaseDaoImpl<Grupo> {
  @override
  Grupo fromMapToEntity(Map<String, dynamic> map) {
    return Grupo.fromMapToEntity(map);
  }

  @override
  String get nomeTabela => "grupos";

  @override
  Future<List<Grupo>?> listarTodos() async {
    return await obterListaBase();
  }

  @override
  Future<int?> excluir(Grupo model) async {
    return await excluirBase(nomesFiltros: ["id"], valores: [model.id]);
  }

  @override
  Future<int?> criar(Grupo model) async {
    return inserirBase(
        colunas: ["valorTotal", "descricao"],
        valores: [model.valorTotal, model.descricao]
    );
  }

  @override
  void atualizar(Grupo model) async {
    atualizarBase(
        colunas: ["valorTotal", "descricao"],
        nomesFiltros: ["id"],
        valores: [model.valorTotal, model.descricao, model.id]
    );
  }


}
