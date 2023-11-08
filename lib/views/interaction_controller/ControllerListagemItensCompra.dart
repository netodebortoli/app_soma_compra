import 'dart:async';

import '../../domain/Compra.dart';
import '../../domain/ItemCompra.dart';
import '../../persistencia/dao/ItemCompraDao.dart';

class ControllerListagemItensCompra {

  final streamController = StreamController<List<ItemCompra>>();
  List<ItemCompra>? itens;

  ControllerListagemItensCompra();
  ItemCompraDAO dao = ItemCompraDAO();

  Future<List<ItemCompra>?> buscarItensCompra(Compra compra) async {
    itens = await dao.listarTodos(compra);
    streamController.add(itens!);
    return itens;
  }

}