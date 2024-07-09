import 'dart:io' as io;
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  Future<void> initDatabase() async {
    if (io.Platform.isWindows || io.Platform.isLinux) {
      final io.Directory documentsDirectory =
          await getApplicationDocumentsDirectory();
      final String dbPath = path.join(documentsDirectory.path, 'produtos.db');
      var db = await databaseFactory.openDatabase(dbPath);
      await db.execute(
          'CREATE TABLE produtos(id INTEGER PRIMARY KEY, tipo TEXT, nome TEXT, valorCompraTotal REAL, preco REAL, quantidade INTEGER, unidade TEXT, vendas INTEGER)');
    }
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

  Future<String> dbToString() async {
    final io.Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String dbPath = path.join(documentsDirectory.path, 'produtos.db');
    final db = await databaseFactory.openDatabase(dbPath);
    final List<Map<String, dynamic>> maps = await db.query('produtos');
    return maps.toString();
  }
}
