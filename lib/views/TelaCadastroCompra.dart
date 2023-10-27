import 'package:app_soma_conta/customs_widget/CampoForm.dart';
import 'package:app_soma_conta/views/interaction_controller/ControllerCadastroCompra.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      body: _body(context),
    );
  }

  final ControllerCadastroCompra controllerForm = ControllerCadastroCompra();

  _body(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(20),
      child: Form(
        key: controllerForm.formkey,
        child: ListView(
          children: [
            CampoForm("Descricao", controllerForm.controleDescricao,
                hint: "Descrição da compra"),
            const SizedBox(height: 17),
            TextFormField(
              controller: controllerForm.controleData,
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
            )
          ],
        ),
      ),
    );
  }
}
