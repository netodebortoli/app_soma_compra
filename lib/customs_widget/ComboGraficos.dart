import 'package:app_soma_conta/customs_widget/AvisoGrafico.dart';
import 'package:d_chart/commons/axis.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/commons/decorator.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/commons/style.dart';
import 'package:d_chart/ordinal/combo.dart';
import 'package:flutter/material.dart';

import '../views/interaction_controller/ControllerGrafico.dart';

class ComboGraficos extends StatefulWidget {
  ComboGraficos(this.futureDados, this._controller, {super.key});

  ControllerGrafico _controller;
  Future futureDados;

  @override
  State<ComboGraficos> createState() => _ComboGraficosState();
}

class _ComboGraficosState extends State<ComboGraficos> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.futureDados,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(child: Text('Erro ao carregar dados.'));
            }
            return _comboDeGraficos();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  _comboDeGraficos() {
    List<OrdinalData> dados = widget._controller.valores;

    if (dados.isEmpty) {
      return const AvisoGrafico();
    } else {
      List<OrdinalGroup> timeGroup = [
        OrdinalGroup(
          id: '1',
          chartType: ChartType.bar,
          data: dados,
        ),
        OrdinalGroup(
          id: '2',
          chartType: ChartType.line,
          color: Colors.red,
          data: dados,
        ),
        OrdinalGroup(
          id: '3',
          chartType: ChartType.scatterPlot,
          data: dados,
        ),
      ];

      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.30,
        width: MediaQuery.of(context).size.width * 0.95,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.40,
              width: 500,
              child: DChartComboO(
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
              )),
        ),
      );
    }
  }
}
