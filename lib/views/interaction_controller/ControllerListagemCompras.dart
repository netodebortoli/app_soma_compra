import 'dart:async';

import 'package:app_soma_conta/persistencia/dao/CompraDao.dart';
import 'package:app_soma_conta/utils/Navegacao.dart';
import 'package:app_soma_conta/views/TelaCadastroCompra.dart';
import 'package:flutter/material.dart';

import '../../controllers/CompraController.dart';
import '../../domain/Compra.dart';

class ControllerListagemCompras {
  final streamController = StreamController<List<Compra>>();
  List<Compra>? compras;

  CompraDAO dao = CompraDAO();
  CompraController controller = CompraController();

  ControllerListagemCompras();

  Future<List<Compra>?> buscarCompras() async {
    compras = await controller.listarTodos();
    streamController.add(compras!);
    return compras;
  }

  void irTelaEdicaoCompra(BuildContext context) async {
    String s = await push(context, TelaCadastroCompra());
    if (s == "Salvou") {
      compras = await controller.listarTodos();
      streamController.add(compras!);
    }
  }

  void removerCompra(int index) {
    Compra compra = compras![index];
    compras!.removeAt(index);
    controller.excluirCompra(compra);
    streamController.add(compras!);
  }
}
