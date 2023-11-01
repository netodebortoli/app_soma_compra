import 'package:app_soma_conta/customs_widget/CardCompra.dart';
import 'package:app_soma_conta/views/interaction_controller/ControllerListagemCompras.dart';
import 'package:flutter/material.dart';

import '../domain/Compra.dart';

class ListagemDeCompras extends StatefulWidget {
  const ListagemDeCompras({super.key});

  @override
  State<ListagemDeCompras> createState() => _ListagemDeComprasState();
}

class _ListagemDeComprasState extends State<ListagemDeCompras> {
  late ControllerListagemCompras _controllerListagemCompras;

  @override
  void initState() {
    super.initState();
    _controllerListagemCompras = ControllerListagemCompras();
    _controllerListagemCompras.buscarCompras();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerListagemCompras.streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: RefreshIndicator(
                onRefresh: () {
                  return _controllerListagemCompras.buscarCompras();
                },
                child: _streamBuilder(),
              ),
            ),
          ],
        ),
    );
  }

  Container _streamBuilder() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: StreamBuilder<List<Compra>>(
          stream: _controllerListagemCompras.streamController.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            _controllerListagemCompras.compras = snapshot.data;
            return _listView();
          }),
    );
  }

  ListView _listView(){
    return ListView.builder(
      itemCount: _controllerListagemCompras.compras != null ? _controllerListagemCompras.compras!.length : 0,
      itemBuilder: (context, index) {
        Compra compra = _controllerListagemCompras.compras![index];
        return CardCompra(compra, _controllerListagemCompras, index);
      },
    );
  }
}
