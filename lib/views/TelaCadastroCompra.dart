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

class _TelaCadastroCompra extends State<TelaCadastroCompra> {
  late ControllerCadastroCompra controladora;

  @override
  void initState() {
    super.initState();
    controladora = ControllerCadastroCompra(widget.compra, widget.grupo);
    controladora.inicializarCampos().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Builder(builder: (BuildContext tabContext) {
          final TabController tabController =
              DefaultTabController.of(tabContext);
          tabController.addListener(() {
            if(!tabController.indexIsChanging){
              if(tabController.index == 0){
                controladora.calcularTotal();
              }
            }
          });
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              title: const Text("Gerenciar Compras"),
              bottom: const TabBar(tabs: [
                Tab(icon: Icon(Icons.shopping_cart_rounded)),
                Tab(icon: Icon(Icons.add_shopping_cart))
              ]),
            ),
            body: TabBarView(
              children: <Widget>[
                TabFormCompra(context, controladora),
                TabCadastroItemCompra(context, controladora)
              ],
            ),
          );
        }),
      ),
    );
  }
}
