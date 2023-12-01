import 'package:app_soma_conta/domain/dto/dto_numerico.dart';
import 'package:app_soma_conta/domain/dto/dto_ordinal.dart';
import 'package:app_soma_conta/persistencia/dao/CompraDao.dart';

import '../domain/Compra.dart';

class CompraService {
  final CompraDAO _dao = CompraDAO();

  Future<List<Compra>> listarTodos() async {
    return await _dao.listarTodos();
  }

  Future<List<Compra>> listarTodosPorAno(String ano) async {
    int compare = int.parse(ano);
    List<Compra>? dados = await _dao.listarTodos();
    List<Compra> compras = [];
    if (dados != null) {
      for(Compra cmp in dados){
        if(cmp.data_compra.year == compare){
          compras.add(cmp);
        }
      }
    }
    return compras;
  }

  Future<List<Compra>> listarComprasPorGrupo(int idGrupo) async {
    List<Compra>? dados = await _dao.listarTodasComprasGrupo(idGrupo);
    List<Compra> compras = [];
    if (dados != null) {
      compras.addAll(dados);
    }
    return compras;
  }

  Future<List<DtoNumerico>> getValorTotalPorMes(String ano) async {
    List<DtoNumerico>? dados = await _dao.getValorTotalPorMes(ano);
    List<DtoNumerico> valores = [];
    if (dados != null) {
      valores.addAll(dados);
    }
    return valores;
  }

  Future<List<DtoOrdinal>> getValorTotalPorTipoCompra(String ano) async {
    List<DtoOrdinal>? dados = await _dao.getValorTotalPorTipoCompra(ano);
    List<DtoOrdinal> valores = [];
    if (dados != null) {
      valores.addAll(dados);
    }
    return valores;
  }

  Future<List<DtoOrdinal>> getValorTotalPorTipoPagamento(String ano) async {
    List<DtoOrdinal>? dados = await _dao.getValorTotalPorTipoPagamento(ano);
    List<DtoOrdinal> valores = [];
    if (dados != null) {
      valores.addAll(dados);
    }
    return valores;
  }

  void inserirCompra(Compra compra) {
    _dao.criar(compra);
  }

  void excluirCompra(Compra compra) {
    _dao.excluir(compra);
  }

  void atualizarCompra(Compra compra) {
    _dao.atualizar(compra);
  }
}
