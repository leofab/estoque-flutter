import 'package:flutter/material.dart';

import 'mock_produtos_data.dart';
import 'produto_item.dart';

class ProdutosLista extends StatelessWidget {
  const ProdutosLista({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            children: MOCK_PRODUTOS_DATA.map((produto) {
              return ProdutoItem(produto.nome, produto.cor);
            }).toList()));
  }
}
