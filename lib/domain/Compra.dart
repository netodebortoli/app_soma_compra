import 'package:app_soma_conta/domain/Objeto.dart';

import 'FormaPagamento.dart';
import 'Grupo.dart';
import 'ItemCompra.dart';
import 'TipoCompra.dart';

class Compra extends Objeto {
  List<ItemCompra>? itens;
  double valorTotal = 0;
  String descricao;
  DateTime dataCompra;
  Grupo? grupo;
  TipoPagamento tipoPagamento;
  TipoCompra tipoCompra;

  Compra(
      {required this.descricao,
      required this.tipoPagamento,
      required this.tipoCompra,
      this.itens,
      required this.dataCompra,
      this.grupo});
}
