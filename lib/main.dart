import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login.dart';
import 'screens/produtos_lista.dart';
import 'screens/produto_vendas.dart';

import 'providers/produtos_provider.dart';

Future main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProdutosProvider()),
      ],
      child: MaterialApp(title: 'Estoque App', initialRoute: '/login', routes: {
        '/login': (context) => const LoginScreen(),
        '/produtos': (context) => const ProdutosLista(),
        '/vendas': (context) => const ProdutoVendas(),
      }),
    );
  }
}
