import 'dart:io' as io;
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';

import '../models/produto.dart';

class DatabaseHelper {
  Future<void> initDatabase() async {
    final io.Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String dbPath = path.join(documentsDirectory.path, 'produtos.db');
    var db = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE produtos(id INTEGER PRIMARY KEY, tipo TEXT, nome TEXT, valorCompraTotal REAL, preco REAL, quantidade INTEGER, unidade TEXT, vendas INTEGER)');
    });
  }

  Future<void> insertDb(Map<String, dynamic> data) async {
    final io.Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String dbPath = path.join(documentsDirectory.path, 'produtos.db');
    final db = await databaseFactory.openDatabase(dbPath);
    await db.insert('produtos', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> alterProductByID(Map<String, dynamic> data) async {
    final io.Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String dbPath = path.join(documentsDirectory.path, 'produtos.db');
    final db = await databaseFactory.openDatabase(dbPath);
    await db.update('produtos', data, where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<void> alterProductByQuantidade(Map<String, dynamic> data) async {
    final io.Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String dbPath = path.join(documentsDirectory.path, 'produtos.db');
    final db = await databaseFactory.openDatabase(dbPath);
    await db.update('produtos', data,
        where: 'quantidade = ?', whereArgs: [data['quantidade']]);
  }

  Future<void> alterProductByName(Map<String, dynamic> data) async {
    final io.Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String dbPath = path.join(documentsDirectory.path, 'produtos.db');
    final db = await databaseFactory.openDatabase(dbPath);
    await db
        .update('produtos', data, where: 'nome = ?', whereArgs: [data['nome']]);
  }

  Future<void> alterProductByUnidade(Map<String, dynamic> data) async {
    final io.Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String dbPath = path.join(documentsDirectory.path, 'produtos.db');
    final db = await databaseFactory.openDatabase(dbPath);
    await db.update('produtos', data,
        where: 'unidade = ?', whereArgs: [data['unidade']]);
  }

  Future<String> dbToString() async {
    final io.Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String dbPath = path.join(documentsDirectory.path, 'produtos.db');
    final db = await databaseFactory.openDatabase(dbPath);
    final List<Map<String, dynamic>> maps = await db.query('produtos');
    return maps.toString();
  }

  Future<List<Produto>> fetchFromDB() async {
    final io.Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String dbPath = path.join(documentsDirectory.path, 'produtos.db');
    final db = await databaseFactory.openDatabase(dbPath);
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
        vendas: maps[i]['vendas'],
      );
    });
  }

  Future<Produto> getLastProduct() async {
    final io.Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String dbPath = path.join(documentsDirectory.path, 'produtos.db');
    final db = await databaseFactory.openDatabase(dbPath);
    final List<Map<String, dynamic>> maps = await db.query('produtos');
    return Produto(
      id: maps.last['id'],
      tipo: maps.last['tipo'],
      nome: maps.last['nome'],
      valorCompraTotal: maps.last['valorCompraTotal'],
      preco: maps.last['preco'],
      quantidade: maps.last['quantidade'],
      unidade: maps.last['unidade'],
      vendas: maps.last['vendas'],
    );
  }
}
