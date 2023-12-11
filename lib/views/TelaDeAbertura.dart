import 'package:flutter/material.dart';

import 'interaction_controller/ControllerTelaDeAbertura.dart';

class TelaDeAbertura extends StatefulWidget {
  const TelaDeAbertura({super.key});

  @override
  State<TelaDeAbertura> createState() => _TelaDeAberturaState();
}

class _TelaDeAberturaState extends State<TelaDeAbertura> {

  final ControllerTelaDeAbertura _controller = ControllerTelaDeAbertura();

  @override
  void initState() {
    super.initState();
    _controller.inicializarAplicacao(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset("assets/icon/logo_soma_compra_256x256.png", fit: BoxFit.contain),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 100),
            child: const Text(
              "Soma Compra",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),

            ),
          ),
          const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
