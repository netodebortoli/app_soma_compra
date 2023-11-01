abstract class BaseDaoImpl<T> {

  Future<List<T>?> listarTodos();
  Future<int?> criar(T model);
  void atualizar(T model);
  Future<int?> excluir(T model);

}