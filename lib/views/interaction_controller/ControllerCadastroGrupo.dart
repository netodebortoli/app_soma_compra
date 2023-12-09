import 'package:app_soma_conta/services/GrupoService.dart';
import 'package:app_soma_conta/utils/Navegacao.dart';
import 'package:flutter/material.dart';

import '../../customs_widget/Toast.dart';
import '../../domain/Grupo.dart';

class ControllerCadastroGrupo {

  Grupo? grupo;
  final GrupoService grupoService = GrupoService();

  ControllerCadastroGrupo(this.grupo);

  final formkey = GlobalKey<FormState>();
  final controleDescricao = TextEditingController();

  void cancelar(BuildContext context) {
    controleDescricao.clear();
    Navigator.pop(context);
  }

  void inicializarCampos(){
    if(grupo == null){
      controleDescricao.text = "";
    } else {
      controleDescricao.text = grupo!.descricao;
    }
  }

  void _criarGrupo() {
    if(grupo != null){
      grupo!.descricao = controleDescricao.text;
      grupoService.atualizarGrupo(grupo!);
    } else {
      grupo = Grupo(descricao: controleDescricao.text, valor_total: 0.0);
      grupoService.inserirGrupo(grupo!);
    }

  }

  void salvar(BuildContext context) {
    if (formkey.currentState!.validate()) {
      _criarGrupo();
      controleDescricao.clear();
      ToastSucesso("Grupo salvo com sucesso.", context);
      pop(context, mensagem: "Salvo com sucesso");
    }
  }
}
