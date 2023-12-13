import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/commons/decorator.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/commons/style.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:flutter/material.dart';

import '../views/interaction_controller/ControllerGrafico.dart';
import 'AvisoGrafico.dart';

class GraficoDeBarra extends StatefulWidget {
  GraficoDeBarra(this.futureDados, this._controller, {super.key});

  ControllerGrafico _controller;
  Future futureDados;

  @override
  State<GraficoDeBarra> createState() => _GraficoState();
}

class _GraficoState extends State<GraficoDeBarra> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.futureDados,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(child: Text('Erro ao carregar dados.'));
            }
            if (snapshot.hasData) {
              return const SizedBox(
                  child: Center(child: Text('Não há dados a exibir.')));
            }
            return _graficoDeBarra();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  _graficoDeBarra() {
    List<OrdinalData> dados = widget._controller.valores;

    if (dados.isEmpty) {
      return const AvisoGrafico();
    } else {
      List<OrdinalGroup> ordinalGroup = [
        OrdinalGroup(
          id: '1',
          data: dados,
        )
      ];

      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.30,
        width: MediaQuery.of(context).size.width * 0.95,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.40,
              width: 500,
              child: DChartBarO(
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
                  fillColor: (group, ordinalData, index) =>
                      Colors.blue.shade800,
                  groupList: ordinalGroup)),
        ),
      );
    }
  }
}
