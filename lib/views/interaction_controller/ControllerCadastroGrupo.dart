import 'package:flutter/material.dart';

import '../../customs_widget/ToastErro.dart';
import '../../customs_widget/ToastSucesso.dart';

class ControllerCadastroGrupo {
  final formkey = GlobalKey<FormState>();
  final controleDescricao = TextEditingController();

  void cancelar(BuildContext context){
    controleDescricao.clear();
    Navigator.pop(context);
  }

  void cadastrarGrupo(BuildContext context) {
    if (formkey.currentState!.validate()) {
      ToastSucesso("Cadastro realizado com sucesso.");
      // INSERIR POSTERIOMENTE NO BANCO DE DADOS
      controleDescricao.clear();
      Navigator.pop(context);
    }
  }
}
