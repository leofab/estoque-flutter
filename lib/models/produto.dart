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
  int id;
  String tipo;
  String nome;
  double valorCompraTotal;
  double preco;
  int quantidade;
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

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'tipo': tipo,
      'nome': nome,
      'valorCompraTotal': valorCompraTotal,
      'preco': preco,
      'quantidade': quantidade,
      'unidade': unidade,
    };
  }

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      tipo: map['tipo'],
      nome: map['nome'],
      valorCompraTotal: map['valorCompraTotal'],
      preco: map['preco'],
      quantidade: map['quantidade'],
      unidade: map['unidade'],
    );
  }

  @override
  String toString() {
    return 'Produto{id: $id, tipo: $tipo, nome: $nome, valorCompraTotal: $valorCompraTotal, preco: $preco, quantidade: $quantidade, unidade: $unidade}';
  }
}
