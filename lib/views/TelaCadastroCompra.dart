import 'package:app_soma_conta/customs_widget/Botao.dart';
import 'package:app_soma_conta/customs_widget/CampoForm.dart';
import 'package:app_soma_conta/customs_widget/ToastErro.dart';
import 'package:app_soma_conta/customs_widget/ToastSucesso.dart';
import 'package:app_soma_conta/domain/FormaPagamento.dart';
import 'package:app_soma_conta/domain/TipoCompra.dart';
import 'package:app_soma_conta/views/interaction_controller/ControllerCadastroCompra.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TelaCadastroCompra extends StatefulWidget {
  static final String routeName = '/compras/novo';

  @override
  State<StatefulWidget> createState() => _TelaCadastroCompra();
}

class _TelaCadastroCompra extends State<TelaCadastroCompra> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: const Text("Cadastro de Compras"),
      ),
      body: _tabFormCompra(context),
    );
  }

  final ControllerCadastroCompra controllerForm = ControllerCadastroCompra();

  final mask = MaskTextInputFormatter(mask: '##/##/####');
  static const List<TipoCompra> tiposCompras = TipoCompra.values;
  static const List<TipoPagamento> tiposPagamento = TipoPagamento.values;

  TipoCompra dropdownValueTipoCompra = tiposCompras.first;
  TipoPagamento dropdownValueTipoPagamento = tiposPagamento.first;

  _tabFormCompra(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(20),
      child: Form(
        key: controllerForm.formkey,
        child: ListView(
          children: [
            CampoForm("Descrição", controllerForm.controleDescricao,
                hint: "Descrição da compra"),
            const SizedBox(height: 17),
            TextFormField(
              inputFormatters: [mask],
              controller: controllerForm.controleData,
              validator: (String? text) {
                if (text != null && text.isEmpty) {
                  return "O campo \"Data da Compra\" é obrigatório.";
                }
              },
              keyboardType: TextInputType.datetime,
              onTap: () async {
                DateTime? pickerDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2099),
                    locale: const Locale("pt", "BR"));

                if (pickerDate != null) {
                  setState(() {
                    controllerForm.controleData.text =
                        DateFormat('dd/MM/yyyy').format(pickerDate);
                  });
                }
              },
              decoration: const InputDecoration(
                  labelText: "Data da compra",
                  icon: Icon(Icons.calendar_today_sharp)),
            ),
            SizedBox(height: 17),
            DropdownButtonFormField(
              value: dropdownValueTipoCompra,
              validator: (value) =>
                  value == null ? 'O campo é obrigatório' : null,
              onChanged: (TipoCompra? value) {
                setState(() {
                  dropdownValueTipoCompra = value!;
                });
              },
              decoration: const InputDecoration(
                  labelText: "Tipo da Compra",
                  labelStyle:
                      const TextStyle(color: Colors.grey, fontSize: 20)),
              items: tiposCompras
                  .map<DropdownMenuItem<TipoCompra>>((TipoCompra value) {
                return DropdownMenuItem<TipoCompra>(
                  value: value,
                  child: Text(value.valor),
                );
              }).toList(),
            ),
            const SizedBox(height: 17),
            DropdownButtonFormField(
              value: dropdownValueTipoPagamento,
              validator: (value) =>
                  value == null ? 'O campo é obrigatório' : null,
              onChanged: (TipoPagamento? value) {
                setState(() {
                  dropdownValueTipoPagamento = value!;
                });
              },
              decoration: const InputDecoration(
                  labelText: "Tipo do Pagamento",
                  labelStyle:
                      const TextStyle(color: Colors.grey, fontSize: 20)),
              items: tiposPagamento
                  .map<DropdownMenuItem<TipoPagamento>>((TipoPagamento value) {
                return DropdownMenuItem<TipoPagamento>(
                  value: value,
                  child: Text(value.valor),
                );
              }).toList(),
            ),
            CampoForm("Valor Total", controllerForm.controleValorTotal,
                isFormRequired: false,
                typeInput: TextInputType.number,
                formEnable: false),
            const SizedBox(height: 25),
            Botao("Salvar", onClick: () {
              controllerForm.cadastrarCompra(context);
            }),
            const SizedBox(height: 17),
            Botao("Cancelar", onClick: () {
              controllerForm.cancelarCompra(context);
            })
          ],
        ),
      ),
    );
  }

  _tabItensCompra() {

  }
}
