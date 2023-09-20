import 'package:app_soma_conta/controller/ControllerFormCadastro.dart';
import 'package:app_soma_conta/customs_widget/Botao.dart';
import 'package:flutter/material.dart';

import '../customs_widget/CampoForm.dart';

class TelaCadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: const Text("Cadastro de Usuário"),
      ),
      body: _body(),
    );
  }

  final formKey = GlobalKey<FormState>();
  final controleUsuario = TextEditingController();
  final controleSenha1 = TextEditingController();
  final controleSenha2 = TextEditingController();

  _body() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            CampoForm("E-mail", controleUsuario,
                hint: "Digite seu email de login",
                typeInput: TextInputType.emailAddress),
            const SizedBox(height: 17),
            CampoForm("Senha", controleSenha1,
                hint: "Sua senha deve ter no mínimo 6 dígitos", password: true),
            const SizedBox(height: 17),
            CampoForm("Repita a Senha", controleSenha2, password: true),
            const SizedBox(height: 50),
            Botao("Cadastrar", validateForm: () {
              if (!formKey.currentState!.validate()) {
                print("Preencha os campos obrigatórios");
              }
              if (controleSenha1 != controleSenha2) {
                print("As senhas não são iguais");
              }
            })
          ],
        ),
      ),
    );
  }
}
