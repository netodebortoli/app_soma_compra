import 'package:app_soma_conta/views/TelaCadastroCompra.dart';
import 'package:flutter/material.dart';

class ControllerHomePage {
  void cadastrarCompras(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => TelaCadastroCompra()),
    );
  }
}
