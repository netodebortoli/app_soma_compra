import 'package:app_soma_conta/utils/Navegacao.dart';
import 'package:app_soma_conta/views/TelaCadastroCompra.dart';
import 'package:flutter/material.dart';

class ControllerHomePage {
  void cadastrarCompras(BuildContext context) {
    push(context, TelaCadastroCompra());
  }
}
