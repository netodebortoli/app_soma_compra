import 'dart:async';

import 'package:app_soma_conta/controllers/ItemController.dart';

import '../../domain/Compra.dart';
import '../../domain/ItemCompra.dart';

class ControllerListagemItensCompra {
  ControllerListagemItensCompra();
  ItemController controller = ItemController();

  final streamController = StreamController<List<ItemCompra>>();

  List<ItemCompra>? itens;

  Future<List<ItemCompra>?> buscarItensCompra(Compra compra) async {
    itens = await controller.listarItensPorCompra(compra.id);
    streamController.add(itens!);
    return itens;
  }
}
