import 'package:app_soma_conta/domain/Compra.dart';
import 'package:app_soma_conta/persistencia/dao/BaseDado.dart';
import 'package:app_soma_conta/persistencia/dao/BaseDaoImpl.dart';

class CompraDao extends BaseDAO<Compra> implements BaseDaoImpl<Compra> {

  @override
  String get nomeTabela => "compras";

  @override
  Compra fromMapToEntity(Map<String, dynamic> map) {
    return Compra.fromMapToEntity(map);
  }

  @override
  void atualizar(Compra model) async {
    atualizarBase(
        colunas: ["descricao", "tipoPagamento","tipoCompra", "valorTotal", "itens", "dataCompra", "grupos" ],
        nomesFiltros: ["id"],
        valores: [model.descricao, model.tipoPagamento, model.tipoCompra, model.valorTotal, model.itens, model.dataCompra, model.grupos, model.id]);
  }

  @override
  Future<int?> criar(Compra model) async {
    return await inserirBase(
        colunas: ["descricao", "tipoPagamento","tipoCompra", "valorTotal", "itens", "dataCompra", "grupos" ],
        valores: [model.descricao, model.tipoPagamento, model.tipoCompra, model.valorTotal, model.itens, model.dataCompra, model.grupos]);
  }

  @override
  Future<int?> excluir(Compra model) async {
    return await excluirBase(
        nomesFiltros: ["id"],
        valores: [model.id]);
  }

  @override
  Future<List<Compra>?> listarTodos() async {
    return await obterListaBase();
  }



}