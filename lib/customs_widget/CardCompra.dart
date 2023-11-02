import 'package:app_soma_conta/customs_widget/DialogDadosCompra.dart';
import 'package:app_soma_conta/views/interaction_controller/ControllerListagemCompras.dart';
import 'package:flutter/material.dart';

import '../domain/Compra.dart';
import 'MenuAcoes.dart';

class CardCompra extends StatelessWidget {

  CardCompra(this.compra, this.controller, this.index, {super.key});

  Compra compra;
  ControllerListagemCompras controller;
  int index;

  @override
  Widget build(BuildContext context) {
    final mediaQ = MediaQuery.of(context);
    return Center(
      child: Card(
        color: Colors.blue.shade50,
        shadowColor: Colors.blueAccent,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            showDialog(context: context, builder: (BuildContext context) => DialogDadosCompra(compra));
          },
          child: SizedBox(
            width: mediaQ.size.width * 0.95,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          width: mediaQ.size.width * 0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                compra.descricao,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text("Data: ${compra.getDataFormatada()}"),
                              Text("Tipo: ${compra.tipo_compra.valor}"),
                              Text("Pagamento: ${compra.tipo_pagamento.valor}"),
                            ],
                          ),
                        )),
                    SizedBox(
                      width: mediaQ.size.width * 0.20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "R\$ ${compra.valor_total.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.blue.shade800),
                          ),
                        ],
                      ),
                    ),
                    MenuAcoes(
                      onEdit: () async {
                        controller.irTelaEdicaoCompra(context);
                      },
                      onDelete: () async {
                        controller.removerCompra(index);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
