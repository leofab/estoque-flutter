import 'package:flutter/material.dart';

class ProdutoDetalhes extends StatelessWidget {
  final String id;
  final String tipo;
  final String nome;
  final String preco;
  final String quantidade;

  const ProdutoDetalhes(
      this.id, this.tipo, this.nome, this.preco, this.quantidade,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(tipo, style: const TextStyle(color: Colors.black)),
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
              Text("Descrição: $tipo", style: const TextStyle(fontSize: 20)),
              Text("Nome: $nome", style: const TextStyle(fontSize: 20)),
              Text("Preço: $preco", style: const TextStyle(fontSize: 20)),
              Text("Quantidade: $quantidade",
                  style: const TextStyle(fontSize: 20)),
            ],
          ),
        ));
  }
}
