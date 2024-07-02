import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'login.dart';
import 'produtos_lista.dart';
import 'produto_vendas.dart';

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
