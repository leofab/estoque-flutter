import 'package:flutter/material.dart';

enum Tipos {
  absinto("Absinto", Colors.green),
  amarguinha("Amarguinha", Colors.green),
  cachaca("Cachaça", Colors.green),
  cerveja("Cerveja", Colors.green),
  champanhe("Champanhe", Colors.green),
  conhaque("Conhaque", Colors.green),
  gim("Gim", Colors.green),
  grappa("Grappa", Colors.green),
  hidromel("Hidromel", Colors.green),
  licor("Licor", Colors.green),
  rum("Rum", Colors.green),
  saque("Saque", Colors.green),
  sidra("Sidra", Colors.green),
  tequila("Tequila", Colors.green),
  vermute("Vermute", Colors.green),
  vinho("Vinho", Colors.green),
  vodka("Vodka", Colors.green),
  whisky("Whisky", Colors.green),
  semAlcool("Sem Álcool", Colors.green),
  gelo("Gelo", Colors.green),
  outros("Outros", Colors.green);

  const Tipos(this.tipo, this.cor);
  final String tipo;
  final Color cor;
}

class Produto {
  String id;
  String tipo;
  String nome;
  String valorCompraTotal;
  String preco;
  String quantidade;
  String unidade;

  Produto({
    required this.id,
    required this.tipo,
    required this.nome,
    required this.valorCompraTotal,
    required this.preco,
    required this.quantidade,
    required this.unidade,
  });
}
