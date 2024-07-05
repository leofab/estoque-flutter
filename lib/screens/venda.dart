import 'package:flutter/material.dart';

import '../providers/produtos_provider.dart';
import '../models/produto.dart';

class Venda extends StatelessWidget {
  final Produto produto;
  const Venda({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    ProdutosProvider provider = ProdutosProvider.of(context);
    List<Produto> produtosVendas = provider.produtosVendidos;
    return Scaffold(
      appBar: AppBar(title: const Text("Vendas / Caixa")),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(25),
          children: [
            Text("Produto: ${produto.nome}",
                style: const TextStyle(fontSize: 20)),
            Text("Preço: ${produto.preco}",
                style: const TextStyle(fontSize: 20)),
            Text("Quantidade: ${produto.quantidade}",
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            Text("Total: ${produto.preco * produto.quantidade}",
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Vender"),
            ),
          ],
        ),
      ),
    );
  }
}
