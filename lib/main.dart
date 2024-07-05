import 'dart:async';
import 'package:flutter/material.dart';

import 'screens/login.dart';
import 'screens/produtos_lista.dart';
import 'screens/produto_vendas.dart';

Future main() async {
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
