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
    // _tabController.addListener(() {
    //   setState(() {
    //     _selectedIndex = _tabController.index;
    //   });
    //   if (_selectedIndex == 0) {
    //     controladora.calcularTotal();
    //   }
    // });
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
        child: Scaffold(
            body: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollNotification) {
                if (scrollNotification is ScrollEndNotification) _onTabChange();
                return false;
              },
              child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
                  return <Widget>[
                    const SliverAppBar(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      title: Text("Gerenciar Compras"),
                      pinned: true,
                      floating: true,
                      bottom: TabBar(tabs: [
                        Tab(icon: Icon(Icons.shopping_cart_rounded)),
                        Tab(icon: Icon(Icons.add_shopping_cart))
                      ]),
                    ),
                  ];
                },
                body: TabBarView(

                    children: <Widget>[
                      TabFormCompra(context, controladora),
                      TabCadastroItemCompra(context, controladora)
                    ],
                  ),
              ),
            )),
      ),
    );
  }

  void _onTabChange() {
    controladora.calcularTotal();
    // switch (_tabController.index) {
    //   case 0:
    //     controladora.calcularTotal();
    //     break;
    //   default:
    //     break;
    // }
  }
}
