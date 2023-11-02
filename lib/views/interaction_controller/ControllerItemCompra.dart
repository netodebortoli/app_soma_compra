import 'package:flutter/material.dart';

class ControllerItemCompra {
  final formKey = GlobalKey<FormState>();
  final List<TextEditingController> itens = [];
  final List<TextEditingController> quantidade = [];
  final List<TextEditingController> preco = [];

  bool validarFormItem(BuildContext context) {
    return formKey.currentState!.validate() ? true : false;
  }
}
