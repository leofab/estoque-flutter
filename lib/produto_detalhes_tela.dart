import 'package:flutter/material.dart';

class ProdutoDetalhes extends StatefulWidget {
  final String id;
  final String tipo;
  final String nome;
  final String preco;
  final String quantidade;

  const ProdutoDetalhes(
      this.id, this.tipo, this.nome, this.preco, this.quantidade,
      {super.key});

  @override
  State<ProdutoDetalhes> createState() => _ProdutoDetalhesState();
}

class _ProdutoDetalhesState extends State<ProdutoDetalhes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tipo, style: const TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: GridView(
          padding: const EdgeInsets.all(25),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            Text("Descrição: ${widget.tipo}",
                style: const TextStyle(fontSize: 20)),
            Text("Nome: ${widget.nome}", style: const TextStyle(fontSize: 20)),
            Text("Preço: ${widget.preco}",
                style: const TextStyle(fontSize: 20)),
            Text("Quantidade: ${widget.quantidade}",
                style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("Venda"),
      ),
    );
  }
}
