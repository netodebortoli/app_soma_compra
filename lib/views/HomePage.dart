import 'package:app_soma_conta/customs_widget/Botao.dart';
import 'package:app_soma_conta/views/TelaDeGraficos.dart';
import 'package:app_soma_conta/views/interaction_controller/ControllerHomePage.dart';
import 'package:flutter/material.dart';

import '../customs_widget/CampoForm.dart';
import 'TelaListagemDeCompras.dart';
import 'TelaListagemDeGrupos.dart';
import 'interaction_controller/ControllerCadastroGrupo.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum PopupMenuPages { grupos, compras }

class _HomePageState extends State<HomePage> {
  ControllerHomePage controllerHomePage = ControllerHomePage();
  final ControllerCadastroGrupo controllerCadastroGrupo =
      ControllerCadastroGrupo();
  int indiceDaPagina = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text("Cadastro de novo grupo"),
                              content: Form(
                                key: controllerCadastroGrupo.formkey,
                                child: CampoForm("Nome",
                                    controllerCadastroGrupo.controleDescricao,
                                    typeInput: TextInputType.text),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    controllerCadastroGrupo.cancelar(context);
                                  },
                                  child: const Text('Cancelar'),
                                ),
                                Botao(
                                  "Salvar",
                                  onClick: () {
                                    controllerCadastroGrupo
                                        .cadastrarGrupo(context);
                                  },
                                ),
                              ],
                            ));
                    break;
                  case PopupMenuPages.compras:
                    //TO-DO: direcionar para cadastro de nova compra
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return <PopupMenuItem<PopupMenuPages>>[
                  const PopupMenuItem(
                      value: PopupMenuPages.grupos,
                      child: Text('Criar novo grupo'))
                ];
              })
        ],
      ),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: const <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text('Nome de usuário aqui',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    )),
              )),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Minha conta'),
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Ajuda'),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Nova compra"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () {
          this.controllerHomePage.cadastrarCompras(context);
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
