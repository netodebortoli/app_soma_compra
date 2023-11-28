import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../customs_widget/CampoForm.dart';
import 'interaction_controller/ControllerItemCompra.dart';

class TabCadastroItemCompra extends StatefulWidget {
  BuildContext buildContext;

  TabCadastroItemCompra(this.buildContext, {super.key});

  @override
  State<TabCadastroItemCompra> createState() => _TabCadastroItemCompraState();
}

class _TabCadastroItemCompraState extends State<TabCadastroItemCompra> {
  @override
  Widget build(BuildContext context) {
    return _formItensCompras();
  }

  final ControllerItemCompra controllerItemCompra = ControllerItemCompra();

  _formItensCompras() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text("Adicione os itens da compra ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  )),
              InkWell(
                onTap: () {
                  _addItem();
                },
                child:
                    const Icon(Icons.add_circle, color: Colors.blue, size: 30),
              )
            ],
          ),
          Form(
            key: controllerItemCompra.formKey,
            child: Column(
              children: [
                for (int i = 0; i < controllerItemCompra.itens.length; i++)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: CampoForm(
                                  "Descrição", controllerItemCompra.itens[i],
                                  validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Obrigatório!';
                                }
                                if (value.length > 50) {
                                  return 'Tamanho inválido!';
                                }
                              }),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: CampoForm(
                                  "Qtd", controllerItemCompra.quantidade[i],
                                  typeInput: TextInputType.number,
                                  validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Obrigatório!';
                                }
                                if (num.tryParse(value) == null) {
                                  return 'Inválido!';
                                }
                                if (double.parse(value) <= 0) {
                                  return 'Qtd inválida';
                                }
                              }),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: CampoForm(
                                  "Preço", controllerItemCompra.preco[i],
                                  validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Obrigatório!';
                                }
                                if (num.tryParse(value) == null) {
                                  return 'Inválido!';
                                }
                                if (double.parse(value) <= 0) {
                                  return 'Preço inválido!';
                                }
                              }, typeInput: TextInputType.number),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {
                                    _removeItem(i);
                                  },
                                  child: const Icon(
                                      Icons.remove_circle_outlined,
                                      color: Colors.red,
                                      size: 30))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _calcularPrecoTotal() {
    double total = 0;
    for (int i = 0; i < controllerItemCompra.quantidade.length; i++) {
      if (controllerItemCompra.preco[i].value.text.isNotEmpty) {
        total += double.parse(controllerItemCompra.preco[i].text) *
            double.parse(controllerItemCompra.quantidade[i].text);
      }
    }
    setState(() {});
  }

  _addItem() {
    if (controllerItemCompra.validarFormItem(context)) {
      setState(() {
        controllerItemCompra.itens.add(TextEditingController());
        controllerItemCompra.preco.add(TextEditingController());
        controllerItemCompra.quantidade.add(TextEditingController());
      });
      _calcularPrecoTotal();
    }
  }

  _removeItem(i) {
    setState(() {
      controllerItemCompra.itens.removeAt(i);
      controllerItemCompra.preco.removeAt(i);
      controllerItemCompra.quantidade.removeAt(i);
    });
    _calcularPrecoTotal();
  }
}
