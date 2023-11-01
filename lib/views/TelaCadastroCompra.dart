import 'package:app_soma_conta/customs_widget/Botao.dart';
import 'package:app_soma_conta/customs_widget/CampoForm.dart';
import 'package:app_soma_conta/domain/FormaPagamento.dart';
import 'package:app_soma_conta/domain/TipoCompra.dart';
import 'package:app_soma_conta/views/interaction_controller/ControllerCadastroCompra.dart';
import 'package:app_soma_conta/views/interaction_controller/ControllerItemCompra.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TelaCadastroCompra extends StatefulWidget {
  static final String routeName = '/compras/novo';

  @override
  State<StatefulWidget> createState() => _TelaCadastroCompra();
}

final ControllerCadastroCompra controllerCompra = ControllerCadastroCompra();

final dateMask = MaskTextInputFormatter(mask: '##/##/####');

const List<TipoCompra> tiposCompras = TipoCompra.values;
const List<TipoPagamento> tiposPagamento = TipoPagamento.values;
TipoCompra dropdownValueTipoCompra = tiposCompras.first;
TipoPagamento dropdownValueTipoPagamento = tiposPagamento.first;

class _TelaCadastroCompra extends State<TelaCadastroCompra> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(tabs: [
                Tab(icon: Icon(Icons.shopping_cart_rounded)),
                Tab(icon: Icon(Icons.add_shopping_cart))
              ]),
              title: const Text("Gerenciar Compras"),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            body: Builder(builder: (context) {
              return TabBarView(
                children: <Widget>[_formCompras(), _formItensCompras()],
              );
            })),
      ),
    );
  }

  _formCompras() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(20),
      child: Form(
        key: controllerCompra.formkey,
        child: ListView(
          children: [
            CampoForm("Descrição", controllerCompra.controleDescricao,
                hint: "Descrição da compra"),
            const SizedBox(height: 17),
            TextFormField(
              inputFormatters: [dateMask],
              controller: controllerCompra.controleData,
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
                    controllerCompra.controleData.text =
                        DateFormat('dd/MM/yyyy').format(pickerDate);
                  });
                }
              },
              decoration: const InputDecoration(
                  labelText: "Data da compra",
                  icon: Icon(Icons.calendar_today_sharp)),
            ),
            const SizedBox(height: 17),
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
            CampoForm("Valor Total", controllerCompra.controleValorTotal,
                isFormRequired: false,
                typeInput: TextInputType.number,
                formEnable: false),
            const SizedBox(height: 20),
            Botao("Salvar", onClick: () {
              controllerCompra.cadastrarCompra(context);
            }),
            const SizedBox(height: 17),
            Botao("Cancelar", onClick: () {
              controllerCompra.cancelarCompra(context);
            })
          ],
        ),
      ),
    );
  }

  _calcularPrecoTotal() {
    double total = 0;
    for (int i = 0; i < controllerItemCompra.quantidade.length; i++) {
      if (controllerItemCompra.preco[i].value.text.isNotEmpty) {
        total += double.parse(controllerItemCompra.preco[i].text);
      }
    }
    setState(() {
      // como setar o valor total no form field de "valor total"
    });
  }

  final ControllerItemCompra controllerItemCompra = ControllerItemCompra();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addItem();
    });
  }

  _addItem() {
    setState(() {
      controllerItemCompra.itens.add(TextEditingController());
      controllerItemCompra.preco.add(TextEditingController());
      controllerItemCompra.quantidade.add(TextEditingController());
    });
    _calcularPrecoTotal();
  }

  _removeItem(i) {
    setState(() {
      controllerItemCompra.itens.removeAt(i);
      controllerItemCompra.preco.removeAt(i);
      controllerItemCompra.quantidade.removeAt(i);
    });
    _calcularPrecoTotal();
  }

  _formItensCompras() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text("Adicione os itens da compra ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  )),
              InkWell(
                onTap: () {
                  _addItem();
                },
                child:
                    const Icon(Icons.add_circle, color: Colors.blue, size: 30),
              )
            ],
          ),
          Form(
            key: controllerItemCompra.formKey,
            child: Column(
              children: [
                for (int i = 0; i < controllerItemCompra.itens.length; i++)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: CampoForm(
                                  "Descrição", controllerItemCompra.itens[i]),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: CampoForm(
                                  "Qtd", controllerItemCompra.quantidade[i],
                                  typeInput: TextInputType.number),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: CampoForm(
                                  "Preço", controllerItemCompra.preco[i],
                                  typeInput: TextInputType.number),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {
                                    _removeItem(i);
                                  },
                                  child: const Icon(
                                      Icons.remove_circle_outlined,
                                      color: Colors.red,
                                      size: 30))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
