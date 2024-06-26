import 'package:flutter/material.dart';

class ProdutoInserir extends StatefulWidget {
  const ProdutoInserir({super.key});

  @override
  State<ProdutoInserir> createState() => _ProdutoInserirState();
}

class _ProdutoInserirState extends State<ProdutoInserir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inserir Produto"),
        backgroundColor: Colors.amber[100],
      ),
      body: const Center(
        child: Text("Inserir Produto"),
      ),
    );
  }
}
