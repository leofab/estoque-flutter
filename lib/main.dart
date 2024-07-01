import 'package:flutter/material.dart';

import 'login.dart';
import 'produtos_lista.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Estoque App', initialRoute: '/login', routes: {
      '/login': (context) => const LoginScreen(),
      '/produtos': (context) => const ProdutosLista(),
    });
  }
}
