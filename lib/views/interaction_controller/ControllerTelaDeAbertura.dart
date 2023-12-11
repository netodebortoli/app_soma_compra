import 'package:app_soma_conta/utils/Navegacao.dart';
import 'package:app_soma_conta/views/TelaLogin.dart';
import 'package:flutter/material.dart';

import '../../persistencia/ConexaoBanco.dart';

class ControllerTelaDeAbertura {

  void inicializarAplicacao(BuildContext context) {

    // Inicializando o banco
    Future futureA = ConexaoBanco().db;

    // Dando um tempo para exibição da tela de abertura
    Future futureB = Future.delayed(const Duration(seconds: 4));

    // Obtendo o usuário logado (se houver)
    //Future<Usuario?>  futureC = Usuario.obter();

    // Aguardando as 3 operações terminarem
    // Quando terminarem a aplicação ou vai para a tela de login ou para a tela principal
    //TODO: IMPLEMENTAR LOGIN
    Future.wait([futureA, futureB]).then((List values) {
    //   Usuario? usuario = values[2];
    //
    //   if(usuario != null){
    //     if (usuario.tipo == TipoUsuario.padrao) {
    //       push(context, TelaPrincipal(usuario), replace: true);
    //     } else {
    //       push(context, TelaAdministracaoUsuario(), replace: true);
    //     }
    //   } else {
    //     push(context, TelaLogin(), replace: true);
    //   }
    push(context, TelaLogin(), replace: true);
    });

  }


}