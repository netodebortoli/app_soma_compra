import 'package:app_soma_conta/domain/Objeto.dart';

import 'Compra.dart';

class ItemCompra extends Objeto {
  double valor;
  String descricao;
  int quantidade;
  Compra compra;

  ItemCompra(
      {required this.valor,
      required this.descricao,
      required this.quantidade,
      required this.compra});
}
