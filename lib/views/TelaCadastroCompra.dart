import 'package:app_soma_conta/controller/ControllerCadastroCompra.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaCadastroCompra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: const Text("Cadastro de Compras"),
      ),
      body: _body(context),
    );
  }

  final ControllerCadastroCompra controllerForm = ControllerCadastroCompra();

  _body(BuildContext context) {
    return Container();
  }
}
