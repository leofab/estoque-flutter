import 'package:flutter/material.dart';

class ProdutoDetalhes extends StatelessWidget {
  final String id;
  final String nome;
  final String descricao;
  final String imagem;
  final String preco;
  final String quantidade;
  final String unidade;
  final String categoria;
  final String fornecedor;
  final String data;
  final String validade;
  final String lote;
  final String local;
  final String observacao;

  const ProdutoDetalhes(
      this.id,
      this.nome,
      this.descricao,
      this.imagem,
      this.preco,
      this.quantidade,
      this.unidade,
      this.categoria,
      this.fornecedor,
      this.data,
      this.validade,
      this.lote,
      this.local,
      this.observacao,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(nome, style: const TextStyle(color: Colors.black)),
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
              Image.network(imagem),
              Text("Descrição: $descricao",
                  style: const TextStyle(fontSize: 20)),
              Text("Preço: $preco", style: const TextStyle(fontSize: 20)),
              Text("Quantidade: $quantidade",
                  style: const TextStyle(fontSize: 20)),
              Text("Unidade: $unidade", style: const TextStyle(fontSize: 20)),
              Text("Categoria: $categoria",
                  style: const TextStyle(fontSize: 20)),
              Text("Fornecedor: $fornecedor",
                  style: const TextStyle(fontSize: 20)),
              Text("Data: $data", style: const TextStyle(fontSize: 20)),
              Text("Validade: $validade", style: const TextStyle(fontSize: 20)),
              Text("Lote: $lote", style: const TextStyle(fontSize: 20)),
              Text("Local: $local", style: const TextStyle(fontSize: 20)),
              Text("Observação: $observacao",
                  style: const TextStyle(fontSize: 20)),
            ],
          ),
        ));
  }
}
