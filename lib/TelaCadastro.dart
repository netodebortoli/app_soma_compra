import 'package:app_soma_conta/customWidget/CampoForm.dart';
import 'package:flutter/material.dart';

class TelaCadastro extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  final formKey = GlobalKey<FormState>();
  final controleUsuario = TextEditingController();
  final controleSenha1 = TextEditingController();
  final controleSenha2 = TextEditingController();

  _body() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(16),
      child: ListView(
        children: [
          CampoForm("Nome de Usuário", controleUsuario, hint: "Digite seu nome de login"),
          SizedBox(height: 10),
          CampoForm("Senha", controleSenha1, hint: "Sua senha deve ter no mínimo 6 dígitos", password: true),
          SizedBox(height: 10),
          CampoForm("Repita a Senha", controleSenha2, password: true),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
