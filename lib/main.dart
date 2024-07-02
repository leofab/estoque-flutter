import 'dart:io' as io;
import 'package:path/path.dart' as p;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'login.dart';
import 'produtos_lista.dart';
import 'produto_vendas.dart';
import 'models/produto.dart';

Future main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'estoque_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE produtos(id INTEGER PRIMARY KEY, tipo TEXT, nome TEXT, valorCompraTotal DOUBLE, preco DOUBLE, quantidade INTEGER, unidade TEXT)',
      );
    },
    version: 1,
  );

  Future<List<Produto>> produtos() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('produtos');
    return List.generate(maps.length, (i) {
      return Produto(
        id: maps[i]['id'],
        tipo: maps[i]['tipo'],
        nome: maps[i]['nome'],
        valorCompraTotal: maps[i]['valorCompraTotal'],
        preco: maps[i]['preco'],
        quantidade: maps[i]['quantidade'],
        unidade: maps[i]['unidade'],
      );
    });
  }

  print(await produtos());

  var produto1 = Produto(
      id: 1,
      tipo: 'Alimento',
      nome: 'Arroz',
      valorCompraTotal: 10.0,
      preco: 5.0,
      quantidade: 10,
      unidade: 'kg');

  Future<void> inserirProdutoDB(Produto produto) {
    return database.then((db) {
      db.insert(
        'produtos',
        produto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  inserirProdutoDB(produto1);

  print(await produtos());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Estoque App', initialRoute: '/login', routes: {
      '/login': (context) => const LoginScreen(),
      '/produtos': (context) => const ProdutosLista(),
      '/vendas': (context) => const ProdutoVendas(),
    });
  }
}
