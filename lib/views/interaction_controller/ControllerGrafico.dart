import 'dart:async';

import 'package:app_soma_conta/customs_widget/GraficoDeBarra.dart';
import 'package:app_soma_conta/domain/dto/dto_numerico.dart';
import 'package:app_soma_conta/domain/dto/dto_ordinal.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../customs_widget/ComboGraficos.dart';
import '../../customs_widget/Toast.dart';
import '../../services/CompraService.dart';
import '../../utils/Formatacao.dart';

enum TipoGrafico { DATA, TIPO_COMPRA, TIPO_PAGAMENTO, UNKNOWN }

class ControllerGrafico {
  ControllerGrafico();

  CompraService compraService = CompraService();
  final formkey = GlobalKey<FormState>();
  final controlador_ano = TextEditingController();

  List<OrdinalData> valores = [];

  // Focus
  final focusAno = FocusNode();
  final focusTipoFiltro = FocusNode();
  final focusBotao = FocusNode();

  void setarAnoAtual() {
    controlador_ano.text = DateTime.now().year.toString();
  }

  Widget gerarGrafico(TipoGrafico tipo, BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formkey.currentState!.validate() && tipo != TipoGrafico.UNKNOWN) {
      return gerarGraficoPorTipo(tipo);
    } else if (formkey.currentState!.validate() &&
        tipo == TipoGrafico.UNKNOWN) {
      ToastAlerta("É necessário selecionar um filtro.", context);
      return const SizedBox();
    }
    return const SizedBox();
  }

  Future<List<OrdinalData>> _filtrarPorTipoCompra() async {
    List<OrdinalData> ordinalList = [];

    List<DtoOrdinal> dados =
        await compraService.getValorTotalPorTipoCompra(controlador_ano.text);
    for (DtoOrdinal dto in dados) {
      ordinalList.add(OrdinalData(domain: dto.chave, measure: dto.valor));
    }

    return ordinalList;
  }

  Future<List<OrdinalData>> _filtrarPorTipoPagamento() async {
    List<OrdinalData> ordinalList = [];

    List<DtoOrdinal> dados =
        await compraService.getValorTotalPorTipoPagamento(controlador_ano.text);
    for (DtoOrdinal dto in dados) {
      ordinalList.add(OrdinalData(domain: dto.chave, measure: dto.valor));
    }

    return ordinalList;
  }

  Future<List<OrdinalData>> _filtrarPorDataOrdinal() async {
    List<OrdinalData> ordinalList = [];

    List<DtoNumerico> dados =
        await compraService.getValorTotalPorMes(controlador_ano.text);
    for (DtoNumerico dto in dados) {
      ordinalList.add(
          OrdinalData(domain: getMonthByNumber(dto.chave), measure: dto.valor));
    }

    return ordinalList;
  }

  Future<List<OrdinalData>> carregarDadosDasCompras(
      TipoGrafico tipoGrafico) async {
    List<OrdinalData> ordinalList = [];
    switch (tipoGrafico) {
      case TipoGrafico.DATA:
        ordinalList = await _filtrarPorDataOrdinal();
      case TipoGrafico.TIPO_COMPRA:
        ordinalList = await _filtrarPorTipoCompra();
      case TipoGrafico.TIPO_PAGAMENTO:
        ordinalList = await _filtrarPorTipoPagamento();
      default:
    }
    valores.clear();
    valores.addAll(ordinalList);
    return valores!;
  }

  Future<void> criarGrafico(TipoGrafico tipoGrafico) async {
    carregarDadosDasCompras(tipoGrafico);
  }

  Widget gerarGraficoPorTipo(TipoGrafico tipoGrafico) {
    Future future = criarGrafico(tipoGrafico);
    initializeDateFormatting("pt_BR", null);

    if (tipoGrafico == TipoGrafico.TIPO_COMPRA ||
        tipoGrafico == TipoGrafico.TIPO_PAGAMENTO) {
      return GraficoDeBarra(future, this);
    } else {
      return ComboGraficos(future, this);
    }
  }
}
