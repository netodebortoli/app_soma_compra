import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../domain/Compra.dart';
import 'MenuAcoes.dart';

String formatarData(DateTime data) {
  return DateFormat('dd/MM/yyyy').format(data);
}

class CardCompra extends StatelessWidget {
  const CardCompra({super.key, required this.compra});

  final Compra compra;

  @override
  Widget build(BuildContext context) {
    final mediaQ = MediaQuery.of(context);
    String dataFormatada = formatarData(compra.dataCompra);
    return Center(
      child: Card(
        color: Colors.blue.shade50,
        shadowColor: Colors.blueAccent,
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
                            Text(dataFormatada),
                          ],
                        ),
                      )),
                  SizedBox(
                    width: mediaQ.size.width * 0.20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "R\$ ${compra.valorTotal}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.blue.shade800),
                        ),
                      ],
                    ),
                  ),
                  MenuAcoes(
                    onEdit: () {},
                    onDelete: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
