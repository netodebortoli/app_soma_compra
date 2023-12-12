import 'package:app_soma_conta/customs_widget/DialogFormGrupo.dart';
import 'package:app_soma_conta/views/TelaDeGraficos.dart';
import 'package:app_soma_conta/views/interaction_controller/ControllerHomePage.dart';
import 'package:flutter/material.dart';
import 'TelaListagemDeCompras.dart';
import 'TelaListagemDeGrupos.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum PopupMenuPages { grupos }

class _HomePageState extends State<HomePage> {
  ControllerHomePage controllerHomePage = ControllerHomePage();
  int indiceDaPagina = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: const Text('Soma Compra'),
        actions: [
          PopupMenuButton<PopupMenuPages>(
              tooltip: 'Menu de ações',
              onSelected: (PopupMenuPages valueSelected) {
                switch (valueSelected) {
                  case PopupMenuPages.grupos:
                    showDialog(context: context, builder: (BuildContext context) => DialogFormGrupo(null));
                    break;
                }
              },
              icon: const Icon(Icons.create_new_folder),
              itemBuilder: (BuildContext context) {
                return <PopupMenuItem<PopupMenuPages>>[
                  const PopupMenuItem(
                      value: PopupMenuPages.grupos,
                      child: Text('Criar novo grupo'))
                ];
              })
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Nova compra"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () {
          controllerHomePage.cadastrarCompras(context);
        },
        tooltip: 'Cadastrar nova compra',
        icon: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indiceDaPagina,
        onTap: (index) {
          setState(() {
            indiceDaPagina = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              label: "Gráficos", icon: Icon(Icons.bar_chart)),
          BottomNavigationBarItem(
              label: "Grupos", icon: Icon(Icons.group_work_outlined)),
          BottomNavigationBarItem(
              label: "Compras", icon: Icon(Icons.shopping_basket))
        ],
      ),
      body: IndexedStack(
        index: indiceDaPagina,
        children: const [
          TelaDeGraficos(),
          ListagemDeGrupos(),
          ListagemDeCompras(),
        ],
      ),
    );
  }
}
