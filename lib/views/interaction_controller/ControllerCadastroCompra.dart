import 'package:app_soma_conta/controllers/CompraController.dart';
import 'package:app_soma_conta/controllers/GrupoController.dart';
import 'package:app_soma_conta/controllers/ItemController.dart';
import 'package:app_soma_conta/customs_widget/ToastSucesso.dart';
import 'package:app_soma_conta/domain/Grupo.dart';
import 'package:app_soma_conta/views/TabFormCompra.dart';
import 'package:flutter/material.dart';

import '../../domain/Compra.dart';
import '../../domain/ItemCompra.dart';
import '../../utils/Formatacao.dart';
import '../../utils/Navegacao.dart';

class ControllerCadastroCompra {
  ControllerCadastroCompra(this.compra);

  Compra? compra;
  List<ItemCompra>? itensCompra = [];
  List<Grupo>? gruposCompra = [];

  CompraController controller = CompraController();
  ItemController itemController = ItemController();
  GrupoController grupoController = GrupoController();

  // Controladora da compra
  final formkey = GlobalKey<FormState>();
  final controleData = TextEditingController();
  late TextEditingController controleValorTotal = TextEditingController();
  final controleDescricao = TextEditingController();
  final List<TextEditingController> controleGrupos = [];

  // Controlador dos item de compra
  final formkeyItem = GlobalKey<FormState>();
  late final List<Map<String, TextEditingController>> controleItens = [];

  void cadastrarCompra(BuildContext context) {
    if (formkey.currentState!.validate()) {
      ToastSucesso("Operação realizada com sucesso!");
      _salvarCompra();
      _clearCamposCompra();
      pop(context, mensagem: "Salvo com sucesso");
    }
  }

  void _definirItensGrupoValorTotal(Compra compra) {
    if (controleValorTotal.text.isNotEmpty) {
      compra.valor_total = double.parse(controleValorTotal.text);
    }
    compra.itens = [];
    compra.grupos = [];
    if (itensCompra != null && itensCompra!.isNotEmpty) {
      for (ItemCompra i in itensCompra!) {
        compra.itens?.add(i);
      }
    }
    // TODO: SETAR OS GRUPOS SELECIONADOS \\
  }

  void _salvarCompra() {
    // Se for inclusão
    if (compra == null) {
      compra = Compra(
          descricao: controleDescricao.text,
          tipo_pagamento: dropdownValueTipoPagamento,
          tipo_compra: dropdownValueTipoCompra,
          data_compra: gerarDateTimeFromString(controleData.text)!);
      _definirItensGrupoValorTotal(compra!);
      controller.inserirCompra(compra!);
    } else {
      // atualização
      compra!.descricao = controleDescricao.text;
      compra!.data_compra = gerarDateTimeFromString(controleData.text)!;
      compra!.tipo_compra = dropdownValueTipoCompra;
      compra!.tipo_pagamento = dropdownValueTipoPagamento;
      _definirItensGrupoValorTotal(compra!);
      controller.atualizarCompra(compra!);
    }
  }

  void cancelarCompra(BuildContext context) {
    _clearCamposCompra();
    Navigator.pop(context, "");
  }

  bool validarFormItem(BuildContext context) {
    return formkeyItem.currentState!.validate() ? true : false;
  }

  void _addItemCompra(index) {
    ItemCompra item = ItemCompra(
        valor: double.parse(controleItens[index]['preco']!.text.replaceAll(",", ".")),
        descricao: controleItens[index]['descricao']!.text,
        quantidade: int.parse(controleItens[index]['qtd']!.text));
    itensCompra?.add(item);
  }

  void removerItemCompra(index) {
    controleItens.removeAt(index);
    itensCompra!.isNotEmpty ? itensCompra?.removeAt(index) : null;
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
    controleItens.clear();
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
      for (int i = 0; i < controleItens.length; i++) {
        _addItemCompra(i);
      }
      _calcularPrecoTotal();
    }
  }

  void inicializarCampos() {
    // TODO: popular grupos
    Future<List<Grupo>> gruposFromDB = grupoController.listarTodos();
    gruposFromDB.then((value) {
      gruposCompra = value;
      for (int i = 0; i < gruposCompra!.length; i++) {
        controleGrupos.add(TextEditingController(text: gruposCompra![i].descricao));
      }
    });
    if (compra == null) {
      controleDescricao.text = "";
      controleData.text = formatarDateTimeToString(DateTime.now());
      controleValorTotal.text = "0.0";
      dropdownValueTipoCompra = tiposCompras.first;
      dropdownValueTipoPagamento = tiposPagamentos.first;
      //TODO -> PRE SELECIONAR SE GRUPO != NULL
    } else {
      controleDescricao.text = compra!.descricao;
      controleData.text = formatarDateTimeToString(compra!.data_compra);
      controleValorTotal.text = compra!.valor_total.toString();
      dropdownValueTipoCompra = compra!.tipo_compra;
      dropdownValueTipoPagamento = compra!.tipo_pagamento;
      controleValorTotal.text = compra!.valor_total.toString();
      //TODO -> selecionar o grupo se tiver
      Future<List<ItemCompra>> itensFromDB = itemController.listarItensPorCompra(compra!.id);
      itensFromDB.then((value) {
        itensCompra = value;
        for (int i = 0; i < itensCompra!.length; i++) {
          controleItens.add({
            'descricao': TextEditingController(text: itensCompra![i].descricao),
            'preco': TextEditingController(text: itensCompra![i].valor.toString().replaceAll(".", ",")),
            'qtd': TextEditingController(text: itensCompra![i].quantidade.toString())
          });
        }
      });
    }
  }
}
