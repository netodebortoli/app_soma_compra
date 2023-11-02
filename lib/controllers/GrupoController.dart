import 'package:app_soma_conta/persistencia/dao/GrupoDao.dart';

import '../domain/Grupo.dart';

class GrupoController {

  final GrupoDAO _dao = GrupoDAO();

  Future<List<Grupo>> listarTodos() async {
    List<Grupo>? dados = await _dao.listarTodos();
    List<Grupo> grupos = <Grupo>[];
    if(dados == null){
      return grupos;
    }
    grupos.addAll(dados);
    return grupos;
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
}
