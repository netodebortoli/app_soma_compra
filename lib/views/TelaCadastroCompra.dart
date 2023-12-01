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

  late TabController tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controladora = ControllerCadastroCompra(widget.compra, widget.grupo);
    controladora.inicializarCampos();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {
        _selectedIndex = tabController.index;
      });
      if (_selectedIndex == 0) {
        controladora.calcularTotal();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(tabs: [
                Tab(icon: Icon(Icons.shopping_cart_rounded)),
                Tab(icon: Icon(Icons.add_shopping_cart))
              ]),
              title: const Text("Gerenciar Compras"),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            body: Builder(builder: (contextTab) {
              return TabBarView(
                controller: tabController,
                children: <Widget>[
                  TabFormCompra(context, controladora),
                  TabCadastroItemCompra(context, controladora)
                ],
              );
            })),
      ),
    );
  }
}
