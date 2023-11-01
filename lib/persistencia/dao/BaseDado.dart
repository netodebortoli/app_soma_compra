import 'package:sqflite/sqflite.dart';
import '../ConexaoBanco.dart';

abstract class BaseDAO<T> {
  // Vai criar um get abstrato, ou seja, irá forçar os descendentes a atribuí-lo
  String get nomeTabela;

  // Obriga a definir um fromMap para o objeto específico
  T fromMap(Map<String, dynamic> map);

  Future<Database?> get db => ConexaoBanco().db;

  Future<int?> obterQuantidadeBase(
      {List<String>? nomesFiltros, List? valores}) async {

    final dbClient = await db;

    String sql;
    if (nomesFiltros == null) {
      sql = 'SELECT count(*) FROM $nomeTabela';
    } else {
      sql = 'SELECT count(*) FROM $nomeTabela WHERE ';
      int qtFiltros = nomesFiltros.length;
      for (int i = 0; i < (qtFiltros - 1); i++) {
        sql += ' ${nomesFiltros[i]} = ? and ';
      }
      sql += ' ${nomesFiltros[qtFiltros - 1]} = ?';
    }
    final list = await dbClient?.rawQuery(sql, valores);
    return Sqflite.firstIntValue(list!);
  }

  void atualizarBase(
      {required List<String> colunas,
      required List<String> nomesFiltros,
      List? valores}) async {

    var dbClient = await db;
    String sql = 'UPDATE $nomeTabela SET ';

    int qtColunas = colunas.length;

    for (int i = 0; i < (qtColunas! - 1); i++) {
      sql += ' ${colunas[i]} = ?, ';
    }

    if (nomesFiltros.isNotEmpty) {
      sql += ' ${colunas?[qtColunas - 1]} = ?';
      sql += ' WHERE ';
      int qtFiltros = nomesFiltros.length;

      for (int i = 0; i < (qtFiltros - 1); i++) {
        sql += ' ${nomesFiltros[i]} = ? and ';
      }
      sql += ' ${nomesFiltros[qtFiltros - 1]} = ?';
    }
    await dbClient?.rawUpdate(sql, valores);
  }

  Future<int?> inserirBase({required List<String> colunas, required List valores}) async {
    var dbClient = await db;
    String sql = 'INSERT INTO $nomeTabela (';
    int qtColunas = colunas.length;

    for (int i = 0; i < (qtColunas - 1); i++) {
      sql += '${colunas[i]}, ';
    }

    sql += '${colunas[qtColunas - 1]})';
    sql += ' VALUES (';

    for (int i = 0; i < (qtColunas - 1); i++) {
      sql += '?, ';
    }
    sql += '?)';

    var id = await dbClient?.rawInsert(sql, valores);
    return id;
  }

  Future<Future<List<T>?>> obterListaBase(
      {List<String>? nomesFiltros, List? valores}) async {

    String sql;

    if (nomesFiltros == null || nomesFiltros.isEmpty) {
      sql = 'SELECT * FROM $nomeTabela';
    } else {
      sql = 'SELECT * FROM $nomeTabela WHERE ';
      int qtFiltros = nomesFiltros.length;

      for (int i = 0; i < (qtFiltros - 1); i++) {
        sql += ' ${nomesFiltros[i]} = ? and ';
      }

      sql += ' ${nomesFiltros[qtFiltros - 1]} = ?';
    }
    return obterListaQueryBase(sql, valores);
  }

  Future<List<T>?> obterListaQueryBase(String sql, [List<dynamic>? arguments]) async {
    var dbClient = await db;
    final list = await dbClient?.rawQuery(sql, arguments);
    final List<T>? listEntity = list?.map<T>((map) => fromMap(map)).toList();
    return listEntity;
  }

  Future<int?> excluirBase({required List<String>? nomesFiltros, required List? valores}) async {
    var dbClient = await db;
    String sql = 'DELETE FROM $nomeTabela WHERE ';

    if(nomesFiltros != null && nomesFiltros.isNotEmpty) {
      int qtFiltros = nomesFiltros.length;

      for (int i = 0; i < (qtFiltros- 1); i++) {
        sql += ' ${nomesFiltros[i]} = ? and ';
      }

      sql += ' ${nomesFiltros[qtFiltros - 1]} = ?';
    }
    return await dbClient?.rawDelete(sql, valores);
  }

  Future<int?> excluirTodosBase() async {
    var dbClient = await db;
    return await dbClient?.rawDelete('DELETE FROM $nomeTabela');
  }
}
