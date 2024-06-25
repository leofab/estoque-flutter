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
    return const MaterialApp(
      title: 'Estoque App',
      home: ProdutosLista(),
    );
  }
}
