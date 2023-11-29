import 'package:app_soma_conta/domain/Objeto.dart';

import '../customs_widget/ToastErro.dart';
import '../utils/Formatacao.dart';
import 'Grupo.dart';
import 'ItemCompra.dart';

class Compra extends Objeto {
  late List<ItemCompra>? itens;
  late double? valor_total;
  late String descricao;
  late DateTime data_compra;
  late List<Grupo>? grupos;
  late String tipo_pagamento;
  late String tipo_compra;

  Compra(
      {required this.descricao,
      required this.tipo_pagamento,
      required this.tipo_compra,
      this.itens,
      required this.data_compra,
      this.valor_total,
      this.grupos});

  Compra.mock(
      {required this.descricao,
      required this.tipo_pagamento,
      required this.tipo_compra,
      required this.valor_total,
      this.itens,
      required this.data_compra,
      this.grupos});

  Compra.fromMapToEntity(Map<String, dynamic> map)
      : super.fromMapToEntity(map) {
    try {
      // grupo
      valor_total = map["valor_total"];
      descricao = map["descricao"];
      data_compra = gerarDateTimeFromISOString(map["data_compra"])!;
      // itens
      tipo_pagamento = map["tipo_pagamento"];
      tipo_compra = map["tipo_compra"];
    } on Exception {
      ToastErro("Erro ao converter data.");
    }
  }

  String getDataFormatada() {
    return formatarDateTimeToString(data_compra);
  }
}
