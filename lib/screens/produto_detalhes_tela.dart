import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/produtos_provider.dart';
import '../models/produto.dart';
import 'venda.dart';

class ProdutoDetalhes extends StatefulWidget {
  final Produto produto;
  final String id;
  final String tipo;
  final String nome;
  final String preco;
  final String quantidade;

  const ProdutoDetalhes(
      {super.key,
      required this.produto,
      required this.id,
      required this.tipo,
      required this.nome,
      required this.preco,
      required this.quantidade});

  @override
  State<ProdutoDetalhes> createState() => _ProdutoDetalhesState();
}

class _ProdutoDetalhesState extends State<ProdutoDetalhes> {
  Future<void> _navigateToProdutoVenda(BuildContext context) async {
    ProdutosProvider provider =
        Provider.of<ProdutosProvider>(context, listen: false);
    final result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return Venda(produto: widget.produto);
      },
    ));
    if (result == true) {
      provider.notifyListeners();
    }
  }

  @override
  Widget build(BuildContext context) {
    ProdutosProvider provider = ProdutosProvider.of(context);
    Produto? produto;
    try {
      produto = provider.produtos
          .firstWhere((element) => element.id == widget.produto.id);
    } catch (e) {
      produto = null;
    }
    return produto != null
        ? Scaffold(
            appBar: AppBar(
              title: Text(widget.tipo,
                  style: const TextStyle(color: Colors.black)),
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
                  Text("Descrição: ${produto.tipo}",
                      style: const TextStyle(fontSize: 20)),
                  Text("Nome: ${produto.nome}",
                      style: const TextStyle(fontSize: 20)),
                  Text("Preço: ${produto.preco}",
                      style: const TextStyle(fontSize: 20)),
                  Text("Valor Compra: ${produto.valorCompraTotal}",
                      style: const TextStyle(fontSize: 20)),
                  Text("Quantidade Restante: ${produto.quantidade}",
                      style: const TextStyle(fontSize: 20)),
                  Text("Quantidade Vendida: ${produto.vendas}",
                      style: const TextStyle(fontSize: 20)),
                  Text("Unidade: ${produto.unidade}",
                      style: const TextStyle(fontSize: 20)),
                  Text(
                      "Lucro Esperado: ${produto.vendas * produto.preco - produto.valorCompraTotal}",
                      style: const TextStyle(fontSize: 20)),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _navigateToProdutoVenda(context);
              },
              child: const Text("Venda"),
            ),
          )
        : const Scaffold(
            body: Center(
              child: Text("Produto não encontrado"),
            ),
          );
  }
}
