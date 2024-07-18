import 'package:flutter/material.dart';
import 'package:flutter_application_helder/screens/produto_detalhes_tela.dart';
import '../models/produto.dart';

class ProdutoItem extends StatelessWidget {
  final Produto produto;
  final String id;
  final String tipo;
  final String nome;
  final String preco;
  final String quantidade;

  const ProdutoItem(
      {super.key,
      required this.produto,
      required this.id,
      required this.nome,
      required this.tipo,
      required this.preco,
      required this.quantidade});

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
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.amber.withOpacity(0.7),
              const Color(0xFFFFD54F),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nome,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              quantidade,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
