import 'package:app_soma_conta/views/TabCadastroItemCompra.dart';
import 'package:app_soma_conta/views/TabFormCompra.dart';
import 'package:app_soma_conta/views/interaction_controller/ControllerCadastroCompra.dart';
import 'package:flutter/material.dart';

import '../domain/Compra.dart';
import '../domain/Grupo.dart';

class TelaCadastroCompra extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TelaCadastroCompra();

  Compra? compra;
  Grupo? grupo;

  TelaCadastroCompra({super.key, this.compra, this.grupo});
}

class _TelaCadastroCompra extends State<TelaCadastroCompra>
    with SingleTickerProviderStateMixin {
  late ControllerCadastroCompra controladora;
  late Future futureDados;
  late TabController _tabController;

  static const List<Tab> tabs = <Tab>[
    Tab(icon: Icon(Icons.shopping_cart_rounded), text: "Dados da compra"),
    Tab(icon: Icon(Icons.add_shopping_cart), text: "Itens da compra",)
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    controladora = ControllerCadastroCompra(widget.compra, widget.grupo);
    futureDados = controladora.inicializarCampos();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollNotification) {
          if (scrollNotification is ScrollStartNotification) {
            if (_tabController.index == 1) {
              Future.delayed(const Duration(milliseconds: 300), () {
                controladora.calcularTotal();
              });
            }
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            title: const Text("Gerenciar Compras"),
            bottom: TabBar(controller: _tabController, tabs: tabs),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: <Widget>[
              TabFormCompra(context, controladora, futureDados),
              TabCadastroItemCompra(context, controladora)
            ],
          ),
        ),
      )
    );
  }
}
