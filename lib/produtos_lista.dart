import 'package:flutter/material.dart';

import 'mock_produtos_data.dart';
import 'produto_item.dart';

class ProdutosLista extends StatelessWidget {
  const ProdutosLista({super.key});

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
            }).toList()));
  }
}
