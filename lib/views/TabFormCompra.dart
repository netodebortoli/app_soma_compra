import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../customs_widget/Botao.dart';
import '../customs_widget/CampoForm.dart';
import '../domain/Grupo.dart';
import '../utils/Formatacao.dart';
import 'interaction_controller/ControllerCadastroCompra.dart';

class TabFormCompra extends StatefulWidget {
  BuildContext buildContext;
  ControllerCadastroCompra controllerCompra;
  Future futureDados;

  TabFormCompra(this.buildContext, this.controllerCompra, this.futureDados,{super.key});

  @override
  State<TabFormCompra> createState() => _TabFormCompraState();
}

List<String> tiposCompras = <String>["Mercado", "Serviços", "Saúde", "Lazer", "Urgência", "Transporte", "Outros"];
List<String> tiposPagamentos = <String>["Dinheiro", "Pix", "Débito", "Crédito", "Outros"];
String tipoCompraSelecionado = tiposCompras.first;
String tipoPagamentoSelecionado = tiposPagamentos.first;
final dateMask = MaskTextInputFormatter(mask: '##/##/####');

class _TabFormCompraState extends State<TabFormCompra> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.futureDados,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(child: Text('Erro ao carregar dados'));
            }
            return _formCompras();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  _formCompras() {
    return Container(
      margin: const EdgeInsets.all(7),
      child: Form(
        key: widget.controllerCompra.formkey,
        child: ListView(
          children: [
            MultiSelectDialogField(
              title: const Text("Grupos"),
              dialogHeight: MediaQuery.of(context).size.height * 0.5,
              dialogWidth: MediaQuery.of(context).size.width * 0.5,
              buttonText: const Text("Selecione os grupos desta compra",
                  style: TextStyle(fontSize: 16)),
              buttonIcon:
                  const Icon(Icons.arrow_drop_down, color: Colors.blueGrey),
              cancelText: const Text("Cancelar"),
              searchable: true,
              searchHint: "Pesquise pelo nome",
              searchTextStyle: const TextStyle(color: Colors.black),
              initialValue: widget.controllerCompra.gruposSelecionados!,
              items: widget.controllerCompra.gruposDisponiveis!
                  .map((grupo) => MultiSelectItem<Grupo>(grupo, grupo.descricao))
                  .toList(),
              onConfirm: (value) {
                widget.controllerCompra.gruposSelecionados = value;
                FocusScope.of(context).requestFocus(widget.controllerCompra.focus_descricao_compra);
              },
            ),
            CampoForm("Descrição", widget.controllerCompra.controleDescricao,
                marcadorFoco: widget.controllerCompra.focus_descricao_compra,
                passarFocoPara: widget.controllerCompra.focus_data_compra,
                maxLength: 200),
            const SizedBox(height: 15),
            TextFormField(
              focusNode: widget.controllerCompra.focus_data_compra,
              onFieldSubmitted: (String text) {
                FocusScope.of(context).requestFocus(widget.controllerCompra.focus_tipo_compra);
              },
              inputFormatters: [dateMask],
              controller: widget.controllerCompra.controleData,
              validator: (String? text) {
                if (text != null && text.isEmpty) {
                  return "O campo \"Data da Compra\" é obrigatório.";
                }
                if ((text!.isNotEmpty && text.length < 10) ||
                    int.parse(text.substring(3, 5)) <= 0) {
                  return "Formato inválido.";
                }
                if (text.length == 10 && int.parse(text.substring(3, 5)) > 12) {
                  return "Mês inválido.";
                }
                if (gerarDateTimeFromString(text)!.compareTo(DateTime.now()) >
                    0) {
                  return "Data inválida.";
                }
              },
              keyboardType: TextInputType.datetime,
              readOnly: true,
              onTap: () async {
                DateTime? pickerDate = await showDatePicker(
                    context: widget.buildContext,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2099),
                    locale: const Locale("pt", "BR"));

                if (pickerDate != null) {
                  setState(() {
                    widget.controllerCompra.controleData.text =
                        DateFormat('dd/MM/yyyy').format(pickerDate);
                  });
                }
              },
              decoration: const InputDecoration(
                  labelText: "Data da compra",
                  icon: Icon(Icons.calendar_today_sharp)),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField(
              focusNode: widget.controllerCompra.focus_tipo_compra,
              value: tipoCompraSelecionado,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.blueGrey),
              validator: (value) =>
                  value == null ? 'O campo é obrigatório' : null,
              onChanged: (value) {
                FocusScope.of(context).requestFocus(widget.controllerCompra.focus_tipo_pagamento);
                setState(() {
                  tipoCompraSelecionado = value!;
                });
              },
              decoration: const InputDecoration(
                  labelText: "Tipo de compra",
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 20)),
              items: tiposCompras.map<DropdownMenuItem<String>>((String? value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value!),
                );
              }).toList(),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField(
              focusNode: widget.controllerCompra.focus_tipo_pagamento,
              value: tipoPagamentoSelecionado,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.blueGrey),
              validator: (value) =>
                  value == null ? 'O campo é obrigatório' : null,
              onChanged: (value) {
                FocusScope.of(context).requestFocus(widget.controllerCompra.focus_botao_cadastrar);
                setState(() {
                  tipoPagamentoSelecionado = value!;
                });
              },
              decoration: const InputDecoration(
                  labelText: "Forma do pagamento",
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 20)),
              items: tiposPagamentos.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextFormField(
              controller: widget.controllerCompra.controleValorTotal,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: "Valor Total", prefix: Text("R\$ ")),
              enabled: false,
            ),
            const SizedBox(height: 20),
            Botao("Salvar", marcadorFoco: widget.controllerCompra.focus_botao_cadastrar,
                onClick: () {
              widget.controllerCompra.cadastrarCompra(widget.buildContext);
            }),
            const SizedBox(height: 15),
            Botao("Cancelar", onClick: () {
              widget.controllerCompra.cancelarCompra(widget.buildContext);
            }, backgroundColor: Colors.red)
          ],
        ),
      ),
    );
  }
}
