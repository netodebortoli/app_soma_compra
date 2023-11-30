import 'dart:async';

import 'package:app_soma_conta/domain/dto/dto_numerico.dart';
import 'package:app_soma_conta/domain/dto/dto_ordinal.dart';
import 'package:d_chart/commons/axis.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/commons/decorator.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:d_chart/ordinal/combo.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../controllers/CompraController.dart';
import '../../domain/Compra.dart';
import '../../utils/Formatacao.dart';

enum TipoGrafico { DATA, TIPO_COMPRA, TIPO_PAGAMENTO }

class ControllerGrafico {
  ControllerGrafico();

  CompraController controller = CompraController();
  final controlador_ano = TextEditingController();

  void setarAnoAtual() {
    controlador_ano.text = DateTime.now().year.toString();
  }

  List<OrdinalData> _filtrarPorTipoCompra() {
    List<OrdinalData> ordinalList = [];

    Future<List<DtoOrdinal>> dados = controller.getValorTotalPorTipoCompra(controlador_ano.text);
    dados.then((value) => {
          for (DtoOrdinal dto in value){
              ordinalList.add(OrdinalData(domain: dto.chave, measure: dto.valor))
            }
        });

    return ordinalList;
  }

  List<OrdinalData> _filtrarPorTipoPagamento() {
    List<OrdinalData> ordinalList = [];

    Future<List<DtoOrdinal>> dados = controller.getValorTotalPorTipoPagamento(controlador_ano.text);
    dados.then((value) => {
      for (DtoOrdinal dto in value){
        ordinalList.add(OrdinalData(domain: dto.chave, measure: dto.valor))
      }
    });

    return ordinalList;
  }

  List<OrdinalData> _filtrarPorDataOrdinal() {
    List<OrdinalData> ordinalList = [];

    Future<List<DtoNumerico>> dados =
        controller.getValorTotalPorMes(controlador_ano.text);
    dados.then((value) => {
          for (DtoNumerico dto in value){
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
          ),
          barLabelValue: (group, ordinalData, index) {
            return 'R\$ ${ordinalData.measure}';
          },
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
          labelAnchor: BarLabelAnchor.start,
        ),
        barLabelValue: (group, timeData, index) {
          return 'R\$ ${timeData.measure}';
        },
        groupList: timeGroup,
        domainAxis: const DomainAxis(labelAnchor: LabelAnchor.centered),
      );
    }
  }
}
