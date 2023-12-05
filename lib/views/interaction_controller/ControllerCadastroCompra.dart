import 'package:app_soma_conta/services/CompraService.dart';
import 'package:app_soma_conta/services/GrupoService.dart';
import 'package:app_soma_conta/services/ItemService.dart';
import 'package:app_soma_conta/customs_widget/ToastSucesso.dart';
import 'package:app_soma_conta/domain/Grupo.dart';
import 'package:app_soma_conta/views/TabFormCompra.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../domain/Compra.dart';
import '../../domain/ItemCompra.dart';
import '../../utils/Formatacao.dart';
import '../../utils/Navegacao.dart';

class ControllerCadastroCompra {
  ControllerCadastroCompra(this.compra, this.grupo);

  Grupo? grupo;
  Compra? compra;

  List<ItemCompra>? itensCompra = [];

  List<ValueItem<Grupo>> opcoesGruposMultiselect = [];

  CompraService compraService = CompraService();
  ItemService itemService = ItemService();
  GrupoService grupoService = GrupoService();

  // TextEditingController da compra
  final formkey = GlobalKey<FormState>();
  final controleDescricao = TextEditingController();
  final controleData = TextEditingController();
  late TextEditingController controleValorTotal = TextEditingController();
  final MultiSelectController<Grupo> selectController = MultiSelectController();

  // TextEditingController dos item de compra
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
    for (ValueItem<Grupo> vi in selectController.selectedOptions) {
      compra.grupos?.add(vi.value!);
    }
  }

  void _salvarCompra() {
    // Se for inclusão
    if (compra == null) {
      compra = Compra(
          descricao: controleDescricao.text,
          tipo_pagamento: tipoPagamentoSelecionado,
          tipo_compra: tipoCompraSelecionado,
          data_compra: gerarDateTimeFromString(controleData.text)!);
      _definirItensGrupoValorTotal(compra!);
      compraService.inserirCompra(compra!);
    } else {
      // atualização
      compra!.descricao = controleDescricao.text;
      compra!.data_compra = gerarDateTimeFromString(controleData.text)!;
      compra!.tipo_compra = tipoCompraSelecionado;
      compra!.tipo_pagamento = tipoPagamentoSelecionado;
      _definirItensGrupoValorTotal(compra!);
      compraService.atualizarCompra(compra!);
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
        valor: double.parse(
            controleItens[index]['preco']!.text.replaceAll(",", ".")),
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

  void _clearCamposCompra() {
    controleData.clear();
    controleValorTotal.clear();
    controleDescricao.clear();
    tipoCompraSelecionado = tiposCompras.first;
    tipoPagamentoSelecionado = tiposPagamentos.first;
    controleItens.clear();
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

  Future<void> popularMultiSelectorGrupos() async {
    List<Grupo> dados = [];
    dados = await grupoService.listarGrupos();
    opcoesGruposMultiselect = fromGrupoListToValueItemList(dados);
    selectController.setOptions(opcoesGruposMultiselect);
  }

  void inicializarCampos() {
    if (compra == null) {
      controleDescricao.text = "";
      controleData.text = formatarDateTimeToString(DateTime.now());
      controleValorTotal.text = "0.0";
      tipoCompraSelecionado = tiposCompras.first;
      tipoPagamentoSelecionado = tiposPagamentos.first;
      if (grupo != null) {
        selectController.addSelectedOption(selectController.options
            .firstWhere((element) => element.value == grupo!));
      }
    } else {
      controleDescricao.text = compra!.descricao;
      controleData.text = formatarDateTimeToString(compra!.data_compra);
      controleValorTotal.text = compra!.valor_total.toString();
      tipoCompraSelecionado = compra!.tipo_compra;
      tipoPagamentoSelecionado = compra!.tipo_pagamento;
      controleValorTotal.text = compra!.valor_total.toString();
      // TODO --> buscar todos os grupos de uma compra

      Future<List<Grupo>> gruposFromDB =
          grupoService.listarGrupoPorCompra(compra!.id);
      gruposFromDB.then((value) {
        //TODO --> SETAR AS OPCOES SELECIONADAS COM BASE NOS GRUPOS
        for (Grupo gp in value) {
          selectController.addSelectedOption(selectController.options
              .firstWhere((element) => element.value == gp));
        }
      });

      Future<List<ItemCompra>> itensFromDB =
          itemService.listarItensPorCompra(compra!.id);
      itensFromDB.then((value) {
        itensCompra = value;
        for (int i = 0; i < itensCompra!.length; i++) {
          controleItens.add({
            'descricao': TextEditingController(text: itensCompra![i].descricao),
            'preco': TextEditingController(
                text: itensCompra![i].valor.toString().replaceAll(".", ",")),
            'qtd': TextEditingController(
                text: itensCompra![i].quantidade.toString())
          });
        }
      });
    }
  }

  List<ValueItem<Grupo>> fromGrupoListToValueItemList(List<Grupo> grupos) {
    List<ValueItem<Grupo>> valueItemList = [];
    valueItemList =
        grupos.map((e) => ValueItem(label: e.descricao, value: e)).toList();
    return valueItemList;
  }

  ValueItem<Grupo> compareGrupoValueItem(Grupo grupo) {
    for (ValueItem<Grupo> vi in opcoesGruposMultiselect) {
      if (vi.value == grupo) {
        return vi;
      }
    }
    return ValueItem(label: grupo.descricao, value: grupo);
  }
}
