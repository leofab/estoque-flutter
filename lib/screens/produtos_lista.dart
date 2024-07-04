import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../widget/produto_item.dart';
import '../widget/grid_view_widget.dart';
import 'produto_inserir.dart';
import 'filtrar.dart';
import '../providers/produtos_provider.dart';

class ProdutosLista extends StatefulWidget {
  const ProdutosLista({super.key});

  @override
  State<ProdutosLista> createState() => _ProdutosListaState();
}

class _ProdutosListaState extends State<ProdutosLista> {
  @override
  Widget build(BuildContext context) {
    var scaffold = ChangeNotifierProvider(
      create: (context) => Produtos(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Produtos",
            style: TextStyle(color: Colors.amber[100]),
          ),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          backgroundColor: Colors.black45,
        ),
        body: GridViewWidget(),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.amber,
                ),
                child: Text(
                  "Estoque App",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text("Produtos"),
                onTap: () {
                  if (ModalRoute.of(context)!.settings.name != "/produtos") {
                    context.push('/produtos');
                  } else {
                    context.pop();
                  }
                },
              ),
              ListTile(
                title: const Text("Vendas / Caixa"),
                onTap: () {
                  if (ModalRoute.of(context)!.settings.name != "/vendas") {
                    context.go("/produtos/vendas");
                  } else {
                    context.pop();
                  }
                },
              ),
              ListTile(
                title: const Text("Sair"),
                onTap: () {
                  context.pushReplacement('/login');
                },
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton.extended(
                label: const Text("Filtrar"),
                onPressed: () {
                  context.go('/produtos/filtrar');
                },
                backgroundColor: Colors.amber[300],
                splashColor: Colors.amber[100],
                icon: const Icon(Icons.filter_alt),
                heroTag: null,
              ),
              FloatingActionButton(
                onPressed: () {
                  context.go('/produtos/inserir');
                },
                backgroundColor: Colors.amber[300],
                splashColor: Colors.amber[100],
                heroTag: null,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          ElevatedButton(
            onPressed: () {},
            child: const Text("Limpar Filtros"),
          ),
        ],
      ),
    );
    return scaffold;
  }
}
