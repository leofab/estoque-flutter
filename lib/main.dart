import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'screens/login.dart';
import 'screens/produtos_lista.dart';
import './screens/produto_inserir.dart';
import './screens/filtrar.dart';
import 'screens/produto_vendas.dart';
import './providers/produtos_provider.dart ';

Future main() async {
  runApp(const MainApp());
}

GoRouter router() {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/produtos',
        builder: (context, state) => const ProdutosLista(),
        routes: [
          GoRoute(
            path: 'inserir',
            builder: (context, state) => const ProdutoInserir(),
          ),
          GoRoute(
            path: 'vendas',
            builder: (context, state) => const ProdutoVendas(),
          ),
          GoRoute(
            path: 'filtrar',
            builder: (context, state) => const Filtrar(),
          ),
        ],
      ),
    ],
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Produtos()),
      ],
      child: MaterialApp.router(
        title: 'Estoque App',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        routerConfig: router(),
      ),
    );
  }
}
