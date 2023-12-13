import 'package:flutter/material.dart';

class AvisoGrafico extends StatelessWidget {
  const AvisoGrafico({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.30,
        child: const Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.info),
            Text('Não há dados referentes ao filtro e ao ano selecionados.'),
          ],
        )));
  }
}
