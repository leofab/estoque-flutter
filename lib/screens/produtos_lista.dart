import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart%20%20';

import '../mock_produtos_data.dart';
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
  List<ProdutoItem> produtos = MOCK_PRODUTOS_DATA
      .map((produto) => ProdutoItem(
            produto.id.toString(),
            produto.nome,
            produto.nome,
            produto.preco.toString(),
            produto.quantidade.toString(),
          ))
      .toList();

  void inserirProduto(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ChangeNotifierProvider(
              create: (context) => Produtos(),
              builder: (context, child) =>
                  ProdutoInserir(update: _update, produtos: produtos),
            )));
  }

  void filtrarProdutos(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return Filtrar(update: _update, produtos: produtos);
    }));
  }

  void _update(List<ProdutoItem> newProdutos) {
    setState(() {
      produtos = newProdutos;
    });
  }

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
                    Navigator.of(context).pushReplacementNamed("/produtos");
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                title: const Text("Vendas / Caixa"),
                onTap: () {
                  if (ModalRoute.of(context)!.settings.name != "/vendas") {
                    Navigator.of(context).pushNamed("/vendas");
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                title: const Text("Sair"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
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
                onPressed: () => filtrarProdutos(context),
                backgroundColor: Colors.amber[300],
                splashColor: Colors.amber[100],
                icon: const Icon(Icons.filter_alt),
                heroTag: null,
              ),
              FloatingActionButton(
                onPressed: () => inserirProduto(context),
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
            onPressed: () {
              _update(Provider.of<Produtos>(context)
                  .items
                  .map((produto) => ProdutoItem(
                        produto.id.toString(),
                        produto.nome,
                        produto.nome,
                        produto.preco.toString(),
                        produto.quantidade.toString(),
                      ))
                  .toList());
            },
            child: const Text("Limpar Filtros"),
          ),
        ],
      ),
    );
    return scaffold;
  }
}
