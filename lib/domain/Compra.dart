import 'package:app_soma_conta/domain/Objeto.dart';
import 'package:flutter/foundation.dart';

import '../utils/Formatacao.dart';
import 'FormaPagamento.dart';
import 'Grupo.dart';
import 'ItemCompra.dart';
import 'TipoCompra.dart';

class Compra extends Objeto {
  late List<ItemCompra>? itens;
  late double valorTotal;
  late String descricao;
  late DateTime dataCompra;
  late List<Grupo>? grupos;
  late TipoPagamento tipoPagamento;
  late TipoCompra tipoCompra;

  Compra(
      {required this.descricao,
      required this.tipoPagamento,
      required this.tipoCompra,
      this.itens,
      required this.dataCompra,
      this.grupos});

  Compra.mock(
      {required this.descricao,
      required this.tipoPagamento,
      required this.tipoCompra,
      required this.valorTotal,
      this.itens,
      required this.dataCompra,
      this.grupos});

  Compra.fromMapToEntity(Map<String, dynamic> map)
      : super.fromMapToEntity(map) {
    // grupo
    valorTotal = map["valorTotal"];
    descricao = map["descricao"];
    dataCompra = gerarDateTimeFromString(map["dataCompra"])!;
    // itens
    tipoPagamento = map["tipoPagamento"];
    tipoCompra = map["tipoCompra"];
  }

  String getDataFormatada() {
    return formatarDateTimeToString(dataCompra);
  }
}
