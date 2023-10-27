import 'package:flutter/material.dart';

class TelaCadastroGrupo extends StatelessWidget {
  const TelaCadastroGrupo({super.key});

  static final String routeName = 'grupos/novo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          title: Text('Detalhes de grupo')
      ),
      body: Center(
        child: Text('Tela de cadastro de grupos'),
      ),
    );
  }
}
