import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ControllerFormCadastro {
  // Controlador de formulário (para fazer validações)
  final formkey = GlobalKey<FormState>();
  final controleLogin = TextEditingController();
  final controleSenha1 = TextEditingController();
  final controleSenha2 = TextEditingController();

  void signUp(BuildContext context) {
    if (formkey.currentState!.validate()) {
      if (controleSenha1.value != controleSenha2.value) {
        Fluttertoast.showToast(
            msg: "As senhas não são iguais.",
            gravity: ToastGravity.CENTER_RIGHT,
            backgroundColor: Colors.red,
            textColor: Colors.red,
            fontSize: 20.0,
        );
      } else {
        // adicionar no banco de dados posteriormente
        Fluttertoast.showToast(msg: "Cadastro realizado com sucesso!");
      }
    }
  }
}
