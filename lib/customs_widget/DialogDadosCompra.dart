import 'package:app_soma_conta/domain/ItemCompra.dart';
import 'package:flutter/material.dart';

import '../domain/Compra.dart';
import '../views/interaction_controller/ControllerListagemItensCompra.dart';

class DialogDadosCompra extends StatelessWidget {
  DialogDadosCompra(this.compra, {super.key}) {
    _controllerListagemItens.buscarItensCompra(compra);
  }

  Compra compra;

  final ControllerListagemItensCompra _controllerListagemItens =
      ControllerListagemItensCompra();

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text(
        "Detalhes da compra",
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(children: [
          const Text(
            "Itens da compra:",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          const SizedBox(
            width: 230,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 110, child: Text("Descrição")),
                  SizedBox(width: 80, child:Text("Preço")),
                  SizedBox(width: 40, child: Text("Qntd."),),
                  // Text("Descrição"),
                  // Text("Preço"),
                  // Text("Qntd."),
                ]),
          ),
          //_listView(),
          _streamBuilder(),
        ]),
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

  Container _streamBuilder() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: StreamBuilder<List<ItemCompra>>(
          stream: _controllerListagemItens.streamController.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            _controllerListagemItens.itens = snapshot.data;
            return _listView();
          }),
    );
  }

  SizedBox _listView() {
    return SizedBox(
      width: 230,
      height: 500,
      child: Align(
        alignment: Alignment.topLeft,
        child: ListView.builder(
          itemCount: _controllerListagemItens.itens != null
              ? _controllerListagemItens.itens!.length
              : 0,
          itemBuilder: (context, index) {
            ItemCompra item = _controllerListagemItens.itens![index];
            return Column(
              children: [
                const Divider(),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 110, child: Text(item.descricao)),
                    SizedBox(width: 80, child: Text("R\$ ${item.valor}")),
                    SizedBox(width: 40, child: Text("${item.quantidade}", textAlign: TextAlign.center,)),
                  ],
                ),
              ],
            );
            // return ListTile(
            //   title: Text(item.descricao),
            //   subtitle: Text("Preço: R\$ ${item.valor}\nQntd.: ${item.quantidade}"),
            //   isThreeLine: true,
            // );
          },
        ),
      ),
    );
  }
}
