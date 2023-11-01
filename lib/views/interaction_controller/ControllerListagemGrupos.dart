import 'dart:async';

import 'package:app_soma_conta/persistencia/dao/GrupoDao.dart';
import 'package:app_soma_conta/views/TelaCadastroCompra.dart';

import '../../domain/Grupo.dart';

class ControllerListagemGrupos {
  final streamController = StreamController<List<Grupo>>();
  List<Grupo>? grupos;

  ControllerListagemGrupos();
  GrupoDAO dao = GrupoDAO();

  Future<List<Grupo>?> buscarGrupos() async {
    grupos = await dao.listarTodos();
    streamController.add(grupos!);
    return grupos;
  }

  void removerGrupo(int index){
    Grupo grupo = grupos![index];
    grupos!.removeAt(index);
    //FabricaControladora.obterGrupoControl().removerGrupo(grupo);
    streamController.add(grupos!);
  }
}