import 'package:flutter/material.dart';

import '../domain/Compra.dart';

class DialogDadosCompra extends StatelessWidget {
  DialogDadosCompra(this.compra, {super.key});

  Compra compra;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Detalhes da compra"),
      content: Column(

      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
