import 'dart:async';

import 'package:app_soma_conta/domain/FormaPagamento.dart';
import 'package:app_soma_conta/domain/TipoCompra.dart';
import 'package:app_soma_conta/utils/Navegacao.dart';
import 'package:app_soma_conta/views/TelaCadastroCompra.dart';
import 'package:flutter/material.dart';

import '../../domain/Compra.dart';

class ControllerListagemCompras {
  final streamController = StreamController<List<Compra>>();
  List<Compra>? compras;

  ControllerListagemCompras();

  Future<List<Compra>?> buscarCompras() async {
    compras = [
      Compra.mock(
          valorTotal: 129.87,
          tipoPagamento: TipoPagamento.Credito,
          tipoCompra: TipoCompra.Supermercado,
          dataCompra: DateTime.now(),
          descricao: "Mercado semana 3"),
      Compra.mock(
          valorTotal: 60.50,
          tipoPagamento: TipoPagamento.Pix,
          tipoCompra: TipoCompra.Lazer,
          dataCompra: DateTime.now(),
          descricao: "Lanche"),
      Compra.mock(
          valorTotal: 80.00,
          tipoPagamento: TipoPagamento.Dinheiro,
          tipoCompra: TipoCompra.Servicos,
          dataCompra: DateTime.now(),
          descricao: "Limpeza carro"),
      Compra.mock(
          valorTotal: 99.99,
          tipoPagamento: TipoPagamento.Credito,
          tipoCompra: TipoCompra.Outros,
          dataCompra: DateTime.now(),
          descricao: "Coisas")
    ];
    streamController.add(compras!);
    return compras;
  }

  void irTelaEdicaoCompra(BuildContext context) async {
    String s = await push(context, TelaCadastroCompra());
    if (s == "Salvou") {
      //chamar controle de Compra e inserir
      streamController.add(compras!);
    }
  }

  void removerCompra(int index) {
    Compra compra = compras![index];
    compras!.removeAt(index);
    //FabricaControladora.obterCompraControl().removerCompra(compra);
    streamController.add(compras!);
  }
}
