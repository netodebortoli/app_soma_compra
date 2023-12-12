import 'package:app_soma_conta/utils/Navegacao.dart';
import 'package:app_soma_conta/views/HomePage.dart';
import 'package:flutter/material.dart';

import '../../persistencia/ConexaoBanco.dart';

class ControllerTelaDeAbertura {
  void inicializarAplicacao(BuildContext context) {

    // Inicializando o banco
    Future futureA = ConexaoBanco().db;

    // Dando um tempo para exibição da tela de abertura
    Future futureB = Future.delayed(const Duration(seconds: 4));
    Future.wait([futureA, futureB]).then((List values) {
      push(context, HomePage(), replace: true);
    });
  }
}
