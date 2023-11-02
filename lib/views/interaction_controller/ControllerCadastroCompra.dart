import 'package:app_soma_conta/customs_widget/ToastErro.dart';
import 'package:app_soma_conta/customs_widget/ToastSucesso.dart';
import 'package:flutter/material.dart';

class ControllerCadastroCompra {
  final formkey = GlobalKey<FormState>();
  final controleData = TextEditingController();
  final  controleValorTotal = TextEditingController();
  final controleDescricao = TextEditingController();
  final controleTipoPagamento = TextEditingController();
  final controleTipoCompra = TextEditingController();
  final List<TextEditingController> controleItensCompra = [];

  void _clearCampos() {
    controleData.clear();
    controleValorTotal.clear();
    controleDescricao.clear();
    controleTipoPagamento.clear();
    controleTipoCompra.clear();
    controleItensCompra.clear();
  }

  void cadastrarCompra(BuildContext context) {
    if (formkey.currentState!.validate()) {
      ToastSucesso("Operação realizada com sucesso!");
      _clearCampos();
      // TODO: CHAMAR CRUD PARA CADASTRAR/ATUALIZAR COMPRA
    }
  }

  void cancelarCompra(BuildContext context) {
    _clearCampos();
    Navigator.pop(context);
  }
}
