import 'package:app_soma_conta/domain/ItemCompra.dart';
import 'package:app_soma_conta/persistencia/dao/BaseDao.dart';

import '../../domain/Compra.dart';

class ItemCompraDAO extends BaseDAO<ItemCompra> {

  @override
  String get nomeTabela => "item_compra";

  @override
  ItemCompra fromMapToEntity(Map<String, dynamic> map) {
    return ItemCompra.fromMapToEntity(map);
  }

  Future<List<ItemCompra>?> listarTodos(int idCompra) async {
    return await obterListaBase(
      nomesFiltros: ["id_compra"],
      valores: [idCompra]);
  }

}