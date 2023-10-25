import 'ItemCompra.dart';

class Compras {
  List<ItemCompra>? itens;
  double valorTotal = 0;
  String descricao;

  Compras(this.descricao, {this.itens});
}
