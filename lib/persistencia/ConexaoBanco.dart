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

  Future<void> deleteDatabase(String path) => databaseFactory.deleteDatabase(path);

  Future _initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'soma_compra.db');

    //deleteDatabase(path);
    var db = await openDatabase(path, version: 1, onConfigure: onConfigure, onCreate: _onCreate);
    return db;
  }

  Future onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE grupo (id	INTEGER PRIMARY KEY, descricao TEXT NOT NULL, valor_total	REAL)');
    await db.execute(
        'CREATE TABLE compra (id	INTEGER PRIMARY KEY, valor_total	REAL, descricao	VARCHAR(200) NOT NULL, tipo_pagamento VARCHAR(50) NOT NULL, data_compra CHAR(10) NOT NULL, tipo_compra VARCHAR(50) NOT NULL)');
    await db.execute(
        'CREATE TABLE item_compra (id	INTEGER PRIMARY KEY, valor	REAL NOT NULL, descricao VARCHAR(50) NOT NULL, quantidade INTEGER NOT NULL, id_compra INTEGER NOT NULL, FOREIGN KEY(id_compra) REFERENCES compra(id) ON DELETE CASCADE)');
    await db.execute(
        'CREATE TABLE grupo_compra (id_grupo INTEGER, id_compra INTEGER, FOREIGN KEY(id_grupo) REFERENCES grupo(id) ON DELETE CASCADE, FOREIGN KEY(id_compra) REFERENCES compra(id) ON DELETE CASCADE,PRIMARY KEY (id_grupo, id_compra))');

    // await db.transaction((txn) async {
    //   int id3 = await txn.rawInsert('INSERT INTO grupo(descricao, valor_total) '
    //       'VALUES("Outubro/2023", 50)');
    //   print('inserted3: $id3');
    //
    //   int id2 = await txn.rawInsert(
    //       'INSERT INTO compra(valor_total, descricao, tipo_pagamento, data_compra, tipo_compra) '
    //       'VALUES(50, "Compra no mercadinho", "Dinheiro", "2023-11-25" , "Mercado")');
    //   print('inserted2: $id2');
    //
    //   int id1 = await txn
    //       .rawInsert('INSERT INTO item_compra(valor, descricao, quantidade, id_compra) '
    //           'VALUES(50, "Carne", 1, 1)');
    //   print('inserted1: $id1');
    //
    //   int id0 =
    //       await txn.rawInsert('INSERT INTO grupo_compra(id_grupo, id_compra) '
    //           'VALUES(1,1)');
    //   print('inserted0: $id0');
    //
    //   int id4 = await txn.rawInsert(
    //       'INSERT INTO compra(valor_total, descricao, tipo_pagamento, data_compra, tipo_compra) '
    //           'VALUES(73, "Compra no mercadinho", "Pix", "2023-10-22" , "Mercado")');
    //   print('inserted4: $id4');
    //
    //   int id5 = await txn.rawInsert(
    //       'INSERT INTO compra(valor_total, descricao, tipo_pagamento, data_compra, tipo_compra) '
    //           'VALUES(60, "Lanche", "Crédito", "2023-10-10" , "Lazer")');
    //   print('inserted5: $id5');
    //
    //   int id6 = await txn.rawInsert(
    //       'INSERT INTO compra(valor_total, descricao, tipo_pagamento, data_compra, tipo_compra) '
    //           'VALUES(15, "Café da cantina", "Pix", "2023-09-10" , "Lazer")');
    //   print('inserted6: $id6');
    //
    //   int id7 = await txn.rawInsert(
    //       'INSERT INTO compra(valor_total, descricao, tipo_pagamento, data_compra, tipo_compra) '
    //           'VALUES(300, "Pneu", "Débito", "2023-12-20" , "Serviços")');
    //   print('inserted7: $id7');
    //
    //   int id8 = await txn.rawInsert(
    //       'INSERT INTO compra(valor_total, descricao, tipo_pagamento, data_compra, tipo_compra) '
    //           'VALUES(250, "Presente", "Pix", "2023-03-01" , "Lazer")');
    //   print('inserted8: $id8');
    //
    // });
  }

  Future close() async {
    var dbClient = await db;
    return dbClient?.close();
  }
}
