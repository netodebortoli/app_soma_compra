import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../customs_widget/Toast.dart';

class ControllerFormCadastro {
  final formkey = GlobalKey<FormState>();
  final controleLogin = TextEditingController();
  final controleSenha1 = TextEditingController();
  final controleSenha2 = TextEditingController();

  void signUp(BuildContext context) {
    if (formkey.currentState!.validate()) {
      if (controleSenha1.value != controleSenha2.value) {
        ToastErro("As senhas não são iguais.", context);
      } else {
        ToastSucesso("Cadastro realizado com sucesso.", context);
        //TODO: INSERIR POSTERIOMENTE NO BANCO DE DADOS
        //TODO: REDIRECIONAR PARA A TELA DE LOGIN
      }
    }
  }
}
