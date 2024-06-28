import 'package:flutter/material.dart';
import 'package:flutter_application_helder/produto_detalhes_tela.dart';

class ProdutoItem extends StatelessWidget {
  final String id;
  final String tipo;
  final String nome;
  final String preco;
  final String quantidade;

  const ProdutoItem(this.id, this.nome, this.tipo, this.preco, this.quantidade,
      {super.key});

  void selecionarProduto(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return ProdutoDetalhes(
        id,
        tipo,
        nome,
        preco,
        quantidade,
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
              quantidade,
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
