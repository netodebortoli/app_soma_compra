import 'package:app_soma_conta/domain/Objeto.dart';

import 'Compra.dart';

class ItemCompra extends Objeto {
  late double valor;
  late String descricao;
  late int quantidade;
  late Compra compra;

  ItemCompra(
      {required this.valor,
      required this.descricao,
      required this.quantidade});

  ItemCompra.fromMapToEntity(Map<String, dynamic> map) : super.fromMapToEntity(map) {
    valor = map["valor"];
    descricao = map["descricao"];
    quantidade = map["quantidade"];
  }
}
