import 'package:flutter/material.dart';

import 'mock_produtos_data.dart';
import 'produto_item.dart';
import 'produto_inserir.dart';

class ProdutosLista extends StatelessWidget {
  const ProdutosLista({super.key});

  void inserirProduto(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const ProdutoInserir();
    }));
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
            children: MOCK_PRODUTOS_DATA.map((produto) {
              return ProdutoItem(
                produto.nome,
                produto.cor,
                produto.id,
                produto.descricao,
                produto.imagem,
                produto.preco,
                produto.quantidade,
                produto.unidade,
                produto.categoria,
                produto.fornecedor,
                produto.data,
                produto.validade,
                produto.lote,
                produto.local,
                produto.observacao,
              );
            }).toList()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => inserirProduto(context),
          backgroundColor: Colors.amber[300],
          splashColor: Colors.amber[100],
          child: const Icon(Icons.add),
        ));
  }
}
