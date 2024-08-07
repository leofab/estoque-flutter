import 'package:flutter/material.dart';
import 'package:flutter_application_helder/screens/produto_detalhes_tela.dart';
import '../models/produto.dart';

class ProdutoItemVendas extends StatelessWidget {
  final Produto produto;
  final String id;
  final String tipo;
  final String nome;
  final String preco;
  final String quantidade;
  final String vendas;

  const ProdutoItemVendas(
      {super.key,
      required this.produto,
      required this.id,
      required this.nome,
      required this.tipo,
      required this.preco,
      required this.quantidade,
      required this.vendas});

  void selecionarProduto(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProdutoDetalhes(
        produto: produto,
        id: id,
        tipo: tipo,
        nome: nome,
        preco: preco,
        quantidade: quantidade,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selecionarProduto(context),
      splashColor: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.amber.withOpacity(0.7),
              const Color(0xFFFFD54F),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nome,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              vendas,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
