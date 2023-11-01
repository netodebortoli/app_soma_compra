import 'package:app_soma_conta/customs_widget/MenuAcoes.dart';
import 'package:app_soma_conta/views/interaction_controller/ControllerListagemGrupos.dart';
import 'package:flutter/material.dart';
import '../domain/Grupo.dart';

class CardGrupo extends StatelessWidget {
  CardGrupo(this.grupo, this.controller, this.index);

  ControllerListagemGrupos controller;
  Grupo grupo;
  int index;

  @override
  Widget build(BuildContext context) {
    final mediaQ = MediaQuery.of(context);
    return Center(
      child: Card(
        color: Colors.blue.shade50,
        shadowColor: Colors.blueAccent,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            //IR PARA LISTAGEM SÓ DE COMPRAS DO GRUPO
          },
          child: SizedBox(
            width: mediaQ.size.width * 0.95,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              grupo.descricao,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Valor total: ",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  "R\$ ${grupo.valorTotal}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue.shade800,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        )),
                    MenuAcoes(
                      onEdit: () {
                        controller.irTelaEdicaoGrupo(context, index);
                      },
                      onDelete: () {
                        controller.removerGrupo(index);
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
