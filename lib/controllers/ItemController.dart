import 'package:app_soma_conta/domain/ItemCompra.dart';
import 'package:app_soma_conta/persistencia/dao/ItemCompraDao.dart';

class ItemController {
  ItemCompraDAO dao = ItemCompraDAO();

  Future<List<ItemCompra>> listarItensPorCompra(int idCompra) async {
    List<ItemCompra>? dados = await dao.listarTodos(idCompra);
    List<ItemCompra> itens = [];
    if (dados != null) {
      itens.addAll(dados);
    }
    return itens;
  }
}
