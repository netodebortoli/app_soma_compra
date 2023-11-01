import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ConexaoBanco {
  // Para garantir apenas uma instância (Singleton) de DatabaseHelper
  static final ConexaoBanco _instance = ConexaoBanco._getInstance();

  // Esse é um named contructor (que chama o construtor padrão alocando o objeto)
  ConexaoBanco._getInstance();

  // Se o usuário usar DatabaseHelper() é a mesma coisa de fazer DatabaseHelper.getInstance()
  factory ConexaoBanco() => _instance;

  static Database? _db = null;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDb();
    return _db!;
  }

  Future _initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'soma_compra.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE grupos (id	INTEGER PRIMARY KEY, descricao TEXT NOT NULL, valorTotal	REAL)');
    await db.execute(
        'CREATE TABLE compras (id	INTEGER PRIMARY KEY, valorTotal	REAL, descricao	VARCHAR(200) NOT NULL, forma_pagamento VARCHAR(50) NOT NULL, data_compra CHAR(10) NOT NULL, tipo_compra VARCHAR(50) NOT NULL)');
    await db.execute(
        'CREATE TABLE itens_compra (id	INTEGER PRIMARY KEY, valor	REAL NOT NULL, descricao VARCHAR(50) NOT NULL, quantidade INTEGER NOT NULL, id_compra INTEGER NOT NULL, FOREIGN KEY(id_compra) REFERENCES compras(id))');
    await db.execute(
        'CREATE TABLE grupos_compras (id_grupo INTEGER, id_compra INTEGER, FOREIGN KEY(id_grupo) REFERENCES grupo(id),FOREIGN KEY(id_compra) REFERENCES compras(id),PRIMARY KEY (id_grupo, id_compra))');

    await db.transaction((txn) async {
      int id3 = await txn.rawInsert('INSERT INTO grupos(descricao, valorTotal) '
          'VALUES("Outubro/2023", 50)');
      print('inserted3: $id3');

      int id2 = await txn.rawInsert(
          'INSERT INTO compras(valorTotal, descricao, forma_pagamento, data_compra, tipo_compra) '
          'VALUES(50, "Compra no mercadinho", "Dinheiro", "2023-10-31" ,"Mercado")');
      print('inserted2: $id2');

      int id1 = await txn
          .rawInsert('INSERT INTO itens_compra(valor, descricao, quantidade, id_compra) '
              'VALUES(50, "Carne", 1, 1)');
      print('inserted1: $id1');

      int id0 =
          await txn.rawInsert('INSERT INTO grupos_compras(id_grupo, id_compra) '
              'VALUES(1,1)');
      print('inserted0: $id0');
    });
  }

  Future close() async {
    var dbClient = await db;
    return dbClient?.close();
  }
}
