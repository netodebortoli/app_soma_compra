import 'package:app_soma_conta/customs_widget/CardGrupo.dart';
import 'package:app_soma_conta/views/interaction_controller/ControllerListagemGrupos.dart';
import 'package:flutter/material.dart';

import '../domain/Grupo.dart';

class ListagemDeGrupos extends StatefulWidget {
  const ListagemDeGrupos({super.key});

  @override
  State<ListagemDeGrupos> createState() => _ListagemDeGruposState();
}

class _ListagemDeGruposState extends State<ListagemDeGrupos> {
  late ControllerListagemGrupos _controllerListagemGrupos;

  @override
  void initState() {
    super.initState();
    _controllerListagemGrupos = ControllerListagemGrupos();
    _controllerListagemGrupos.buscarGrupos();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerListagemGrupos.streamController.close();
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
                  return _controllerListagemGrupos.buscarGrupos();
                },
                child: _streamBuilder(),
              ))
        ],
      ),
    );
  }

  Container _streamBuilder() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: StreamBuilder<List<Grupo>>(
          stream: _controllerListagemGrupos.streamController.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            _controllerListagemGrupos.grupos = snapshot.data;
            return _listView();
          }),
    );
  }

  ListView _listView() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 70),
      itemCount: _controllerListagemGrupos.grupos != null
          ? _controllerListagemGrupos.grupos!.length
          : 0,
      itemBuilder: (context, index) {
        Grupo grupo = _controllerListagemGrupos.grupos![index];
        return CardGrupo(grupo, _controllerListagemGrupos, index);
      },
    );
  }
}
