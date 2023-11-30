import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../customs_widget/CampoForm.dart';
import '../utils/Currency.dart';
import 'interaction_controller/ControllerCadastroCompra.dart';

class TabCadastroItemCompra extends StatefulWidget {
  BuildContext buildContext;
  ControllerCadastroCompra controllerCompra;

  TabCadastroItemCompra(this.buildContext, this.controllerCompra, {super.key});

  @override
  State<TabCadastroItemCompra> createState() => _TabCadastroItemCompraState();
}

final currencyMask = MaskTextInputFormatter(mask: ',##');

class _TabCadastroItemCompraState extends State<TabCadastroItemCompra> {
  @override
  Widget build(BuildContext context) {
    return _formItensCompras();
  }

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
            key: widget.controllerCompra.formkeyItem,
            child: Column(
              children: [
                for (int i = 0; i < widget.controllerCompra.controleItens.length; i++)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: CampoForm("Descrição",
                                  widget.controllerCompra.controleItens[i]['descricao'],
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
                              child: CampoForm("Qtd",
                                  widget.controllerCompra.controleItens[i]['qtd'],
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
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: widget.controllerCompra.controleItens[i]['preco'],
                                    validator: (value) {
                                      value = value?.replaceAll(',',".");
                                      if (value == null || value.isEmpty) {
                                        return 'Obrigatório!';
                                      }
                                      if (num.tryParse(value) == null) {
                                        return 'Inválido!';
                                      }
                                      if (double.parse(value) <= 0) {
                                        return 'Preço inválido!';
                                      }
                                    },
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black),
                                    decoration: const InputDecoration(
                                        labelText: "Preço",
                                        prefix: Text("R\$ "),
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 15),
                                        labelStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20)))),
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
                                      size: 30)),
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

  _addItem() {
    if (widget.controllerCompra.validarFormItem(context)) {
      setState(() {
        widget.controllerCompra.controleItens.add({
          'descricao': TextEditingController(),
          'qtd': TextEditingController(),
          'preco': TextEditingController(),
        });
      });
    }
  }

  _removeItem(i) {
    setState(() {
      widget.controllerCompra.controleItens.removeAt(i);
    });
  }
}
