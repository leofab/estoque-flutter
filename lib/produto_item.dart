import 'package:flutter/material.dart';

class ProdutoItem extends StatelessWidget {
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
  final Color cor;

  const ProdutoItem(
      this.nome,
      this.cor,
      this.id,
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
            data,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
