import 'package:app_soma_conta/customs_widget/BarraDeNavegacao.dart';
import 'package:app_soma_conta/views/interaction_controller/ControllerHomePage.dart';
import 'package:flutter/material.dart';

class Destination {
  final String label;
  final Widget icon;
  final Widget selectedIcon;

  const Destination(this.label, this.icon, this.selectedIcon);
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  List<Destination> destionations = <Destination>[
    Destination(
        'contas', Icon(Icons.text_snippet_outlined), Icon(Icons.text_snippet)),
  ];

  ControllerHomePage controllerHomePage = ControllerHomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.logout_outlined))
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this.controllerHomePage.cadastrarCompras(context);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BarraDeNavegacao(),
      body: Container(),
    );
  }
}
