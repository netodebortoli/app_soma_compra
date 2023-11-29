import 'package:app_soma_conta/controllers/CompraController.dart';
import 'package:app_soma_conta/customs_widget/ToastSucesso.dart';
import 'package:app_soma_conta/domain/Grupo.dart';
import 'package:app_soma_conta/views/TabFormCompra.dart';
import 'package:flutter/material.dart';

import '../../domain/Compra.dart';
import '../../domain/ItemCompra.dart';
import '../../utils/Formatacao.dart';

class ControllerCadastroCompra {
  Compra? compra;
  List<ItemCompra>? itensCompra = [];
  List<Grupo>? grupos = [];

  CompraController controller = CompraController();

  // Controladora da compra
  final formkey = GlobalKey<FormState>();
  final controleData = TextEditingController();
  late TextEditingController controleValorTotal = TextEditingController();
  final controleDescricao = TextEditingController();
  final List<TextEditingController> controleGrupos = [];

  // Controlador dos item de compra
  final formkeyItem = GlobalKey<FormState>();
  late final List<Map<String, TextEditingController>> itens = [];

  void cadastrarCompra(BuildContext context) {
    if (formkey.currentState!.validate()) {
      ToastSucesso("Operação   realizada com sucesso!");
      _salvarCompra();
      _clearCamposCompra();
      // TODO: CHAMAR CRUD PARA CADASTRAR/ATUALIZAR COMPRA
    }
  }

  void _definirDados(Compra compra) {
    if (controleValorTotal.text.isNotEmpty) {
      compra.valor_total = double.parse(controleValorTotal.text);
    } else {
      compra.valor_total = 0;
    }
    compra.itens = [];
    compra.grupos = [];
    if (itensCompra != null && itensCompra!.isNotEmpty) {
      for (ItemCompra i in itensCompra!) {
        compra.itens?.add(i);
      }
    }
    // TODO: SETAR OS GRUPOS \\
  }

  void _salvarCompra() {
    // Se for inclusão
    if (compra == null) {
      compra = Compra(
          descricao: controleDescricao.text,
          tipo_pagamento: dropdownValueTipoPagamento,
          tipo_compra: dropdownValueTipoCompra,
          data_compra: gerarDateTimeFromString(controleData.text)!);
      _definirDados(compra!);
      controller.inserirCompra(compra!);
    } else {
      // atualização
      compra!.descricao = controleDescricao.text;
      compra!.data_compra = gerarDateTimeFromString(controleData.text)!;
      compra!.tipo_compra = dropdownValueTipoCompra;
      compra!.tipo_pagamento = dropdownValueTipoPagamento;
      _definirDados(compra!);
      controller.atualizarCompra(compra!);
    }
  }

  void cancelarCompra(BuildContext context) {
    _clearCamposCompra();
    Navigator.pop(context);
  }

  bool validarFormItem(BuildContext context) {
    return formkeyItem.currentState!.validate() ? true : false;
  }

  void _addItemCompra(index) {
    ItemCompra item = ItemCompra(
        valor: double.parse(itens[index]['preco']!.text.replaceAll(",", ".")),
        descricao: itens[index]['descricao']!.text,
        quantidade: int.parse(itens[index]['qtd']!.text));
    itensCompra?.add(item);
  }

  void removerItemCompra(index) {
    itensCompra?.removeAt(index);
    _calcularPrecoTotal();
  }

  void _calcularPrecoTotal() {
    double valor = 0;
    itensCompra?.forEach((element) {
      valor += element.valor * element.quantidade;
    });
    controleValorTotal.text = valor.toString();
  }

  void _clearCamposItem() {
    itens.clear();
  }

  void _clearCamposCompra() {
    controleData.clear();
    controleValorTotal.clear();
    controleDescricao.clear();
    dropdownValueTipoCompra = tiposCompras.first;
    dropdownValueTipoPagamento = tiposPagamentos.first;
    _clearCamposItem();
  }

  void calcularTotal() {
    if (formkeyItem.currentState!.validate()) {
      itensCompra?.clear();
      for (int i = 0; i < itens.length; i++) {
        _addItemCompra(i);
      }
      _calcularPrecoTotal();
    }
  }
}
