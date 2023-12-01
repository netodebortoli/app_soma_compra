import 'package:app_soma_conta/persistencia/dao/GrupoDao.dart';

import '../domain/Grupo.dart';

class GrupoService {

  final GrupoDAO _dao = GrupoDAO();

  Future<List<Grupo>> listarTodos() async {
    return await _dao.listarTodos();
  }

  void inserirGrupo(Grupo grupo) {
    _dao.criar(grupo);
  }

  void excluirGrupo(Grupo grupo){
    _dao.excluir(grupo);
  }

  void atualizarGrupo(Grupo grupo){
    _dao.atualizar(grupo);
  }

  Future<List<Grupo>> listarGrupoPorCompra(int idCompra) async {
    List<Grupo>? dados = await _dao.listarTodosGruposPorCompra(idCompra);
    List<Grupo> grupos = [];
    if (dados != null) {
      grupos.addAll(dados);
    }
    return grupos;
  }
}
