import 'package:app_soma_conta/customs_widget/CampoForm.dart';
import 'package:app_soma_conta/views/HomePage.dart';
import 'package:app_soma_conta/views/interaction_controller/ControllerLogin.dart';
import 'package:flutter/material.dart';

import '../customs_widget/Botao.dart';

class TelaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: const Text("Soma Compra"),
      ),
      body: _body(context),
    );
  }

  ControllerLogin controllerLogin = ControllerLogin();

  _body(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Center(
        child: Form(
          key: controllerLogin.formKey,
          child: ListView(
            children: [
              CampoForm('Usuário', controllerLogin.controleUsuario),
              const SizedBox(height: 17),
              CampoForm(
                'Senha',
                controllerLogin.controleSenha,
                password: true,
              ),
              const SizedBox(height: 50),
              Botao("Entrar", onClick: () {
                controllerLogin.signIn(context);
              }),
              SizedBox(height: 25),
              Container(
                child: InkWell(
                  onTap: (){
                    controllerLogin.signUp(context);
                  },
                  child: const Text(
                    "Novo usuário? Cadastre-se",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
