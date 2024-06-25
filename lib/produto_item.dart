import 'package:flutter/material.dart';

class ProdutoItem extends StatelessWidget {
  final String nome;
  final Color cor;

  const ProdutoItem(this.nome, this.cor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            cor.withOpacity(0.7),
            cor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(nome),
    );
  }
}
