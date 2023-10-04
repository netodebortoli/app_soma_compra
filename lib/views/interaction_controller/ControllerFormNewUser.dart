import 'package:app_soma_conta/customs_widget/ToastErro.dart';
import 'package:app_soma_conta/customs_widget/ToastSucesso.dart';
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
        ToastErro("As senhas não são iguais.");
      } else {
        ToastSucesso("Cadastro realizado com sucesso.");
        // INSERIR POSTERIOMENTE NO BANCO DE DADOS
        // REDIRECIONAR PARA A TELA DE LOGIN
      }
    }
  }
}
