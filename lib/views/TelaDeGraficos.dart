import 'package:app_soma_conta/customs_widget/CampoFormMaiorQueZero.dart';
import 'package:app_soma_conta/views/interaction_controller/ControllerGrafico.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../customs_widget/Botao.dart';

class TelaDeGraficos extends StatefulWidget {
  const TelaDeGraficos({super.key});

  @override
  State<TelaDeGraficos> createState() => _TelaDeGraficosState();
}

final List<String> opcoesDeBusca = <String>[
  "",
  "Mês",
  "Tipo de compra",
  "Tipo de pagamento"
];
String opcaoSelecionada = "";

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
        Form(
          key: _controllerGrafico.formkey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: DropdownButtonFormField(
                      focusNode: _controllerGrafico.focusTipoFiltro,
                      value: opcaoSelecionada,
                      validator: (value) =>
                          value == null ? 'O campo é obrigatório' : null,
                      onChanged: (value) {
                        FocusScope.of(context)
                            .requestFocus(_controllerGrafico.focusAno);
                        setState(() {
                          opcaoSelecionada = value!;
                        });
                      },
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 15),
                      decoration: const InputDecoration(
                          labelText: "Filtrar por...",
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 20)),
                      items: opcoesDeBusca
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.88,
                      child: CampoFormMaiorQueZero(
                        marcadorFoco: _controllerGrafico.focusAno,
                          passarFocoPara:  _controllerGrafico.focusBotao,
                          'Ano', _controllerGrafico.controlador_ano,
                          maxLength: 4)),
                ],
              ),
              SizedBox(
                height: 10,
                width: MediaQuery.of(context).size.width,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Botao(
                    marcadorFoco: _controllerGrafico.focusBotao,
                    'Gerar',
                    onClick: () {
                      switch (opcaoSelecionada) {
                        case "Mês":
                          grafico = _controllerGrafico.gerarGrafico(
                              TipoGrafico.DATA, context);
                          Future.delayed(const Duration(milliseconds: 500), () {
                            setState(() {});
                          });
                        case "Tipo de compra":
                          grafico = _controllerGrafico.gerarGrafico(
                              TipoGrafico.TIPO_COMPRA, context);
                          Future.delayed(const Duration(milliseconds: 500), () {
                            setState(() {});
                          });
                        case "Tipo de pagamento":
                          grafico = _controllerGrafico.gerarGrafico(
                              TipoGrafico.TIPO_PAGAMENTO, context);
                          Future.delayed(const Duration(milliseconds: 500), () {
                            setState(() {});
                          });
                        default:
                          grafico = _controllerGrafico.gerarGrafico(
                              TipoGrafico.UNKNOWN, context);
                          Future.delayed(const Duration(milliseconds: 10), () {
                            setState(() {});
                          });
                      }
                    },
                  ),
                )
              ])
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(child: grafico),
          ],
        ),
      ],
    );
  }
}
