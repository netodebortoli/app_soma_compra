import 'package:app_soma_conta/customs_widget/MenuAcoes.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:flutter/material.dart';
import '../domain/Grupo.dart';

class CardGrupo extends StatelessWidget {
  CardGrupo({super.key, required this.grupo});

  final Grupo grupo;

  @override
  Widget build(BuildContext context) {
    final mediaQ = MediaQuery.of(context);
    return Center(
      child: Card(
        color: Colors.blue.shade50,
        shadowColor: Colors.blueAccent,
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
                                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue.shade800, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      )),
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
