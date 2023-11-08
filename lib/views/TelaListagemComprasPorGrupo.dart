import 'package:flutter/material.dart';

import '../customs_widget/CardCompra.dart';
import '../domain/Compra.dart';
import '../domain/Grupo.dart';
import 'interaction_controller/ControllerListagemCompras.dart';

class ComprasPorGrupo extends StatefulWidget {
  Grupo grupo;

  ComprasPorGrupo(this.grupo, {super.key});

  @override
  State<ComprasPorGrupo> createState() => _ComprasPorGrupoState();
}

class _ComprasPorGrupoState extends State<ComprasPorGrupo> {
  late ControllerListagemCompras _controllerListagemCompras;

  @override
  void initState() {
    super.initState();
    _controllerListagemCompras = ControllerListagemCompras();
    _controllerListagemCompras.buscarComprasPorGrupo(widget.grupo.id);
  }

  @override
  void dispose() {
    super.dispose();
    _controllerListagemCompras.streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: Text("Compras de ${widget.grupo.descricao}"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Nova compra neste grupo"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () {
          _controllerListagemCompras.cadastrarComprasEmGrupoEspecifico(
              context, widget.grupo);
        },
        tooltip: 'Cadastrar nova compra',
        icon: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: RefreshIndicator(
              onRefresh: () {
                return _controllerListagemCompras
                    .buscarComprasPorGrupo(widget.grupo.id);
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

  ListView _listView() {
    if (_controllerListagemCompras.compras == null ||
        _controllerListagemCompras.compras!.isEmpty) {
      return ListView(
        children: [
          Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 0),
            child: const Text("Grupo vazio."),
          ))
        ],
      );
    }
    return ListView.builder(
      itemCount: _controllerListagemCompras.compras != null
          ? _controllerListagemCompras.compras!.length
          : 0,
      itemBuilder: (context, index) {
        Compra compra = _controllerListagemCompras.compras![index];
        return CardCompra(compra, _controllerListagemCompras, index);
      },
    );
  }
}
