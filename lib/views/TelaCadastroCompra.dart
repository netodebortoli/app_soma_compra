import 'package:app_soma_conta/views/TabCadastroItemCompra.dart';
import 'package:app_soma_conta/views/TabFormCompra.dart';
import 'package:flutter/material.dart';

class TelaCadastroCompra extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TelaCadastroCompra();
}

class _TelaCadastroCompra extends State<TelaCadastroCompra> {
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
                children: <Widget>[
                  //_formCompras(),
                  TabFormCompra(context),
                  TabCadastroItemCompra(context)
                ],
              );
            })),
      ),
    );
  }
}
