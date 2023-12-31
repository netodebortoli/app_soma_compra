import 'package:app_soma_conta/views/interaction_controller/ControllerCadastroUsuario.dart';
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
      body: _body(context),
    );
  }

  final ControllerFormCadastro controllerForm = ControllerFormCadastro();

  _body(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(20),
      child: Form(
        key: controllerForm.formkey,
        child: ListView(
          children: [
            CampoForm("Login", controllerForm.controleLogin, minLength: 4,
                hint: "Insira seu login de usuário",
                typeInput: TextInputType.text),
            const SizedBox(height: 17),
            CampoForm("Senha", controllerForm.controleSenha1,
                hint: "Sua senha deve ter no mínimo 6 dígitos", password: true, minLength: 6),
            const SizedBox(height: 17),
            CampoForm("Repita a Senha", controllerForm.controleSenha2,
                password: true, minLength: 6),
            const SizedBox(height: 50),
            Botao("Cadastrar", onClick: () {
              controllerForm.signUp(context);
            })
          ],
        ),
      ),
    );
  }
}
