import 'package:flutter/cupertino.dart';

class ControllerFormCadastro {

  // Controlador de formulário (para fazer validações)
  final formkey = GlobalKey<FormState>();
  final controleUsuario = TextEditingController();
  final controleSenha1 = TextEditingController();
  final controleSenha2 = TextEditingController();

  bool validateForm(BuildContext context) {
    if (!formkey.currentState!.validate()) {
      print("Preencha os campos obrigatórios");
      return false;
    }
    if (controleSenha1 != controleSenha2) {
      print("As senhas não são iguais");
      return false;
    }
    return true;
  }

}
