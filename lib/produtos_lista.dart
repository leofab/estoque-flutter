import 'package:flutter/material.dart';

import 'mock_produtos_data.dart';
import 'produto_item.dart';
import 'produto_inserir.dart';
import 'filtrar.dart';

class ProdutosLista extends StatefulWidget {
  const ProdutosLista({super.key});

  @override
  State<ProdutosLista> createState() => _ProdutosListaState();
}

class _ProdutosListaState extends State<ProdutosLista> {
  List<ProdutoItem> produtos = MOCK_PRODUTOS_DATA
      .map((produto) => ProdutoItem(
            produto.id,
            produto.nome,
            produto.nome,
            produto.preco,
            produto.quantidade,
          ))
      .toList();

  void inserirProduto(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const ProdutoInserir();
    }));
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Estoque App",
          style: TextStyle(color: Colors.amber[100]),
        ),
        backgroundColor: Colors.black,
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
            _update(MOCK_PRODUTOS_DATA
                .map((produto) => ProdutoItem(
                      produto.id,
                      produto.nome,
                      produto.nome,
                      produto.preco,
                      produto.quantidade,
                    ))
                .toList());
          },
          child: const Text("Limpar Filtros"),
        ),
      ],
    );
  }
}
