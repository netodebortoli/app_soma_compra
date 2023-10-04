import 'package:app_soma_conta/customs_widget/ToastErro.dart';
import 'package:app_soma_conta/views/TelaCadastro.dart';
import 'package:flutter/material.dart';

import '../HomePage.dart';

class ControllerLogin {
  final formKey = GlobalKey<FormState>();
  final controleUsuario = TextEditingController();
  final controleSenha = TextEditingController();

  void signIn(BuildContext context) {
    if (formKey.currentState!.validate()) {
      // VERIFICAR SE FOI POSSÍVEL REALIZAR A AUTENTICAÇÃO
      //   if ( autenticado ) {
      //     redirecionaTelaInicial
      //   } else {
      //     ToastErro("Os dados informados são inválidos.");
      //     }
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    }
  }

  void signUp(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => TelaCadastro()),
    );
  }
}
