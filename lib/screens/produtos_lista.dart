import 'package:flutter/material.dart';
import 'package:flutter_application_helder/providers/produtos_provider.dart';
import 'package:provider/provider.dart';

import '../mock_produtos_data.dart';
import 'produto_item.dart';
import 'produto_inserir.dart';
import 'filtrar.dart';

class ProdutosLista extends StatefulWidget {
  const ProdutosLista({super.key});

  @override
  State<ProdutosLista> createState() => _ProdutosListaState();
}

class _ProdutosListaState extends State<ProdutosLista> {
  // void inserirProduto(BuildContext context) {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
  //     return ProdutoInserir(update: _update, produtos: produtos);
  //   }));
  // }

  // void filtrarProdutos(BuildContext context) {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
  //     return Filtrar(update: _update, produtos: produtos);
  //   }));
  // }
  

  // void _update(List<ProdutoItem> newProdutos) {
  //   setState(() {
  //     produtos = newProdutos;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    ProdutosProvider provider = ProdutosProvider.of(context);

    List<ProdutoItem> produtos = provider.produtos
        .map((produto) => ProdutoItem(
              produto.id.toString(),
              produto.nome,
              produto.nome,
              produto.preco.toString(),
              produto.quantidade.toString(),
            ))
        .toList();
    return Scaffold(
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
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        physics: const ScrollPhysics(),
        children: produtos,
      ),
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
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) {
                  return const Filtrar();
                },
              )),
              backgroundColor: Colors.amber[300],
              splashColor: Colors.amber[100],
              icon: const Icon(Icons.filter_alt),
              heroTag: null,
            ),
            FloatingActionButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) {
                  return const ProdutoInserir();
                },
              )),
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
            // _update(MOCK_PRODUTOS_DATA
            //     .map((produto) => ProdutoItem(
            //           produto.id.toString(),
            //           produto.nome,
            //           produto.nome,
            //           produto.preco.toString(),
            //           produto.quantidade.toString(),
            //         ))
            //     .toList());
          },
          child: const Text("Limpar Filtros"),
        ),
      ],
    );
  }
}
