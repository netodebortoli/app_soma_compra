import 'dart:async';

import 'package:app_soma_conta/domain/dto/dto_numerico.dart';
import 'package:app_soma_conta/domain/dto/dto_ordinal.dart';
import 'package:d_chart/commons/axis.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/commons/decorator.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/commons/style.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:d_chart/ordinal/combo.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../customs_widget/Toast.dart';
import '../../services/CompraService.dart';
import '../../utils/Formatacao.dart';

enum TipoGrafico { DATA, TIPO_COMPRA, TIPO_PAGAMENTO, UNKNOWN }

class ControllerGrafico {
  ControllerGrafico();

  CompraService compraService = CompraService();
  final formkey = GlobalKey<FormState>();
  final controlador_ano = TextEditingController();

  void setarAnoAtual() {
    controlador_ano.text = DateTime.now().year.toString();
  }

  Widget gerarGrafico(TipoGrafico tipo, BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formkey.currentState!.validate() && tipo != TipoGrafico.UNKNOWN) {
      return gerarGraficoPorTipo(tipo);
    } else if (formkey.currentState!.validate() && tipo == TipoGrafico.UNKNOWN) {
      ToastAlerta("É necessário selecionar um filtro.", context);
      return const SizedBox();
    }
    return const SizedBox();
  }

  List<OrdinalData> _filtrarPorTipoCompra() {
    List<OrdinalData> ordinalList = [];

    Future<List<DtoOrdinal>> dados =
        compraService.getValorTotalPorTipoCompra(controlador_ano.text);
    dados.then((value) => {
          for (DtoOrdinal dto in value)
            {
              ordinalList
                  .add(OrdinalData(domain: dto.chave, measure: dto.valor))
            }
        });

    return ordinalList;
  }

  List<OrdinalData> _filtrarPorTipoPagamento() {
    List<OrdinalData> ordinalList = [];

    Future<List<DtoOrdinal>> dados =
        compraService.getValorTotalPorTipoPagamento(controlador_ano.text);
    dados.then((value) => {
          for (DtoOrdinal dto in value)
            {
              ordinalList
                  .add(OrdinalData(domain: dto.chave, measure: dto.valor))
            }
        });

    return ordinalList;
  }

  List<OrdinalData> _filtrarPorDataOrdinal() {
    List<OrdinalData> ordinalList = [];

    Future<List<DtoNumerico>> dados =
        compraService.getValorTotalPorMes(controlador_ano.text);
    dados.then((value) => {
          for (DtoNumerico dto in value)
            {
              ordinalList.add(OrdinalData(
                  domain: getMonthByNumber(dto.chave), measure: dto.valor))
            }
        });

    return ordinalList;
  }

  Widget gerarGraficoPorTipo(TipoGrafico tipoGrafico) {
    List<OrdinalData> ordinalList = [];
    initializeDateFormatting("pt_BR", null);
    switch (tipoGrafico) {
      case TipoGrafico.DATA:
        ordinalList = _filtrarPorDataOrdinal();
      case TipoGrafico.TIPO_COMPRA:
        ordinalList = _filtrarPorTipoCompra();
      case TipoGrafico.TIPO_PAGAMENTO:
        ordinalList = _filtrarPorTipoPagamento();
      default:
    }

    if (tipoGrafico == TipoGrafico.TIPO_COMPRA ||
        tipoGrafico == TipoGrafico.TIPO_PAGAMENTO) {
      List<OrdinalGroup> ordinalGroup = [
        OrdinalGroup(
          id: '1',
          data: ordinalList,
        ),
      ];

      return DChartBarO(
          barLabelDecorator: BarLabelDecorator(
            barLabelPosition: BarLabelPosition.auto,
            labelAnchor: BarLabelAnchor.end,
            labelPadding: 5,
          ),
          barLabelValue: (group, ordinalData, index) {
            return 'R\$ ${ordinalData.measure}';
          },
          insideBarLabelStyle: (group, ordinalData, index) =>
              const LabelStyle(color: Colors.white),
          fillColor: (group, ordinalData, index) => Colors.blue.shade800,
          groupList: ordinalGroup);

    } else {

      List<OrdinalGroup> timeGroup = [
        OrdinalGroup(
          id: '1',
          chartType: ChartType.bar,
          data: ordinalList,
        ),
        OrdinalGroup(
          id: '2',
          chartType: ChartType.line,
          color: Colors.red,
          data: ordinalList,
        ),
        OrdinalGroup(
          id: '3',
          chartType: ChartType.scatterPlot,
          data: ordinalList,
        ),
      ];

      return DChartComboO(
        barLabelDecorator: BarLabelDecorator(
          barLabelPosition: BarLabelPosition.auto,
          labelAnchor: BarLabelAnchor.end,
          labelPadding: 5,
        ),
        barLabelValue: (group, timeData, index) {
          return 'R\$ ${timeData.measure}';
        },
        insideBarLabelStyle: (group, ordinalData, index) =>
            const LabelStyle(color: Colors.white),
        fillColor: (group, ordinalData, index) => Colors.blue.shade800,
        groupList: timeGroup,
        domainAxis: const DomainAxis(labelAnchor: LabelAnchor.centered),
      );
    }
  }
}
