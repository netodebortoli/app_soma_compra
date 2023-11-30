import 'package:app_soma_conta/customs_widget/CampoForm.dart';
import 'package:app_soma_conta/views/interaction_controller/ControllerGrafico.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TelaDeGraficos extends StatefulWidget {
  const TelaDeGraficos({super.key});

  @override
  State<TelaDeGraficos> createState() => _TelaDeGraficosState();
}

final List<String> opcoesDeBusca = <String>[
  "Ano",
  "Tipo de compra",
  "Tipo de pagamento"
];
String opcaoSelecionada = opcoesDeBusca.first;

class _TelaDeGraficosState extends State<TelaDeGraficos> {
  Widget? grafico;
  late ControllerGrafico _controllerGrafico;

  @override
  void initState() {
    super.initState();

    // Bloqueando a orientação da tela para Retrato
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _controllerGrafico = ControllerGrafico();
    _controllerGrafico.setarAnoAtual();
  }

  @override
  void dispose() {
    super.dispose();

    // Desbloqueando a orientação da tela
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CampoForm('Ano', _controllerGrafico.controlador_ano),
        DropdownButtonFormField(
          value: opcaoSelecionada,
          validator: (value) => value == null ? 'O campo é obrigatório' : null,
          onChanged: (value) {
            setState(() {
              opcaoSelecionada = value!;
              switch (opcaoSelecionada) {
                case "Ano":
                  grafico =
                      _controllerGrafico.gerarGraficoPorTipo(TipoGrafico.DATA);
                case "Tipo de compra":
                  grafico = _controllerGrafico
                      .gerarGraficoPorTipo(TipoGrafico.TIPO_COMPRA);
                case "Tipo de pagamento":
                  grafico = _controllerGrafico
                      .gerarGraficoPorTipo(TipoGrafico.TIPO_PAGAMENTO);
              }
            });
          },
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          decoration: const InputDecoration(
              labelText: "Filtrar por...",
              labelStyle: TextStyle(color: Colors.grey, fontSize: 20)),
          items: opcoesDeBusca.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width * 0.95,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: 500, child: grafico),
              ),
            ),
          ],
        ),
        //
        // )
      ],
    );
  }
}
