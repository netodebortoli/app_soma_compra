import 'package:app_soma_conta/domain/Objeto.dart';

class ItemCompra extends Objeto {
  double valor;
  String descricao;
  int quantidade;

  ItemCompra(this.valor, this.descricao, this.quantidade);
}
