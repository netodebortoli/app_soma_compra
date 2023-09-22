import 'package:flutter/material.dart';

class ControllerLogin {
  final formKey = GlobalKey<FormState>();
  final controleUsuario = TextEditingController();
  final controleSenha = TextEditingController();

  bool validateForm(BuildContext context) {
    if (!formKey.currentState!.validate()) {
      print("Preencha os campos obrigatórios");
      return false;
    }
    return true;
  }
}
