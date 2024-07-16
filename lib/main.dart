import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'screens/login.dart';
import 'screens/produtos_lista.dart';
import 'screens/produto_vendas.dart';

import 'providers/produtos_provider.dart';
import './helpers/database.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
Future main() async {
  await dotenv.load(fileName: ".env");
  if (io.Platform.isWindows || io.Platform.isLinux) {
    databaseFactory = databaseFactoryFfi;
  } else {
    WidgetsFlutterBinding.ensureInitialized();
  }
  DatabaseHelper().initDatabase();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProdutosProvider()),
      ],
      child: MaterialApp(
          navigatorObservers: [routeObserver],
          title: 'Estoque App',
          debugShowCheckedModeBanner: false,
          initialRoute: '/login',
          routes: {
            '/login': (context) => const LoginScreen(),
            '/produtos': (context) => const ProdutosLista(),
            '/vendas': (context) => const ProdutoVendas(),
          }),
    );
  }
}
