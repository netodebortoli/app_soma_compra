import 'package:flutter/material.dart';

import '../domain/Grupo.dart';
import '../utils/Navegacao.dart';
import '../views/interaction_controller/ControllerCadastroGrupo.dart';
import 'Botao.dart';
import 'CampoForm.dart';

class DialogFormGrupo extends StatefulWidget {
  Grupo? grupo;

  DialogFormGrupo(this.grupo);

  @override
  _DialogFormGrupo createState() => _DialogFormGrupo();
}

class _DialogFormGrupo extends State<DialogFormGrupo> {
  late ControllerCadastroGrupo controllerCadastroGrupo;

  @override
  void initState() {
    super.initState();
    controllerCadastroGrupo = ControllerCadastroGrupo(widget.grupo);
    controllerCadastroGrupo.inicializarCampos();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        pop(context, mensagem: "");
        return Future.value(false);
      },
      child: AlertDialog(
        title: const Text("Cadastro de novo grupo"),
        content: Form(
          key: controllerCadastroGrupo.formkey,
          child: CampoForm("Nome", controllerCadastroGrupo.controleDescricao,
              typeInput: TextInputType.text),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              controllerCadastroGrupo.cancelar(context);
            },
            child: const Text('Cancelar'),
          ),
          Botao(
            "Salvar",
            onClick: () {
              controllerCadastroGrupo.salvar(context);
            },
          ),
        ],
      ),
    );
  }
}
