import 'package:app_soma_conta/persistencia/dao/CompraDao.dart';

import '../domain/Compra.dart';

class CompraController {

  final CompraDAO _dao = CompraDAO();

  Future<List<Compra>> listarTodos() async {
    List<Compra>? dados = await _dao.listarTodos();
    List<Compra> compras = <Compra>[];
    if(dados == null){
      return compras;
    }
    compras.addAll(dados);
    return compras;
  }

  void inserirCompra(Compra compra) {
    _dao.criar(compra);
  }

  void excluirCompra(Compra compra){
    _dao.excluir(compra);
  }

  void atualizarCompra(Compra compra){
    _dao.atualizar(compra);
  }
}
