import 'package:flutter/material.dart';

class BarraDeNavegacao extends StatefulWidget {
  const BarraDeNavegacao({super.key});

  @override
  State<BarraDeNavegacao> createState() => _BarraDeNavegacaoState();
}

class _BarraDeNavegacaoState extends State<BarraDeNavegacao> {
  int _indexSelecionado = 1;
  static const TextStyle estiloTextoSelecionado =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _selecionarItem(int index) {
    setState(() {
      _indexSelecionado = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Gráficos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Compras',
        ),
      ],
      currentIndex: _indexSelecionado,
      selectedItemColor: Colors.blueAccent[400],
      onTap: _selecionarItem,
    );
  }
}
