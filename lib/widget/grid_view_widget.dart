import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './produto_item.dart';
import '../providers/produtos_provider.dart';

class GridViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final produtosGrid = Provider.of<Produtos>(context);
    final produtos = produtosGrid.items;
    return GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        physics: const ScrollPhysics(),
        children: produtos
            .map(
              (produto) => ProdutoItem(
                produto.id.toString(),
                produto.nome,
                produto.nome,
                produto.preco.toString(),
                produto.quantidade.toString(),
              ),
            )
            .toList());
  }
}
