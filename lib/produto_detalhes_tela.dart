import 'package:flutter/material.dart';

class ProdutoDetalhes extends StatelessWidget {
  const ProdutoDetalhes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes do Produto',
              style: TextStyle(color: Colors.black)),
        ),
        body: const Center(
          child: Text('Detalhes do Produto'),
        ));
  }
}
