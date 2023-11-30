import 'dart:async';

import 'package:app_soma_conta/persistencia/dao/CompraDao.dart';
import 'package:app_soma_conta/utils/Navegacao.dart';
import 'package:app_soma_conta/views/TelaCadastroCompra.dart';
import 'package:flutter/material.dart';

import '../../controllers/CompraController.dart';
import '../../domain/Compra.dart';
import '../../domain/Grupo.dart';

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

  Future<List<Compra>?> buscarComprasPorGrupo(int idGrupo) async {
    compras = await controller.listarComprasPorGrupo(idGrupo);
    streamController.add(compras!);
    return compras;
  }

  void cadastrarComprasEmGrupoEspecifico(BuildContext context, Grupo grupo) async {
    //TODO: MODIFICAR TELA CADASTRO PARA RECEBER GRUPO NA HORA DE CRIAR A COMPRA
    String s = await push(context, TelaCadastroCompra(grupo: grupo));
    if (s == "Salvo com sucesso") {
      compras = await controller.listarTodos();
      streamController.add(compras!);
    }
  }

  void irTelaEdicaoCompra(BuildContext context, Compra compra) async {
    String s = await push(context, TelaCadastroCompra(compra: compra));
    if (s ==  "Salvo com sucesso") {
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
