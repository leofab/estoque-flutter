import 'package:flutter/material.dart';

class ProdutoVendas extends StatelessWidget {
  const ProdutoVendas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vendas / Caixa")),
      body: const Center(
        child: Text("Vendas / Caixa"),
      ),
    );
  }
}
