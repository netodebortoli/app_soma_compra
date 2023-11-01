import 'package:flutter/material.dart';

import '../views/interaction_controller/ControllerCadastroGrupo.dart';
import 'Botao.dart';
import 'CampoForm.dart';

class DialogFormGrupo extends StatelessWidget {
  DialogFormGrupo({super.key});

  final ControllerCadastroGrupo controllerCadastroGrupo =
      ControllerCadastroGrupo();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Cadastro de novo grupo"),
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
            controllerCadastroGrupo.cadastrarGrupo(context);
          },
        ),
      ],
    );
  }
}
