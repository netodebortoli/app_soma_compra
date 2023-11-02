import 'dart:async';

import 'package:app_soma_conta/controllers/GrupoController.dart';
import 'package:app_soma_conta/customs_widget/DialogFormGrupo.dart';
import 'package:flutter/material.dart';

import '../../domain/Grupo.dart';

class ControllerListagemGrupos {
  final streamController = StreamController<List<Grupo>>();
  List<Grupo>? grupos;

  ControllerListagemGrupos();

  GrupoController controller = GrupoController();

  Future<List<Grupo>?> buscarGrupos() async {
    grupos = await controller.listarTodos();
    streamController.add(grupos!);
    return grupos;
  }

  void irTelaEdicaoGrupo(BuildContext context, int index) async {
    String s = await showDialog(
        context: context, builder: (BuildContext context) => DialogFormGrupo(grupos![index]));
    if (s == "Salvo com sucesso") {
      grupos = await controller.listarTodos();
      streamController.add(grupos!);
    }
  }

  void removerGrupo(int index) {
    Grupo grupo = grupos![index];
    grupos!.removeAt(index);
    controller.excluirGrupo(grupo);
    streamController.add(grupos!);
  }
}
