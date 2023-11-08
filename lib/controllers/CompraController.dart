import 'package:app_soma_conta/persistencia/dao/CompraDao.dart';

import '../domain/Compra.dart';

class CompraController {

  final CompraDAO _dao = CompraDAO();

  Future<List<Compra>> listarTodos() async {
    return await _dao.listarTodos();
  }

  Future<List<Compra>> listarComprasPorGrupo(int idGrupo) async {
    List<Compra>? dados = await _dao.listarTodasComprasGrupo(idGrupo);
    List<Compra> compras = [];
    if(dados != null){
      compras.addAll(dados);
    }
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
