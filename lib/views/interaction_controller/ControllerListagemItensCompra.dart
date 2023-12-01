import 'dart:async';

import 'package:app_soma_conta/services/ItemService.dart';

import '../../domain/Compra.dart';
import '../../domain/ItemCompra.dart';

class ControllerListagemItensCompra {
  ControllerListagemItensCompra();
  ItemService itemService = ItemService();

  final streamController = StreamController<List<ItemCompra>>();

  List<ItemCompra>? itens;

  Future<List<ItemCompra>?> buscarItensCompra(Compra compra) async {
    itens = await itemService.listarItensPorCompra(compra.id);
    streamController.add(itens!);
    return itens;
  }
}
