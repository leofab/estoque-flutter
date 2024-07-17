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

enum Unidades {
  lata350("Lata 350"),
  lata269("Lata 269"),
  seissentos("600"),
  litrao("Litrão"),
  litro("Litro"),
  saco("Saco");

  const Unidades(this.unidade);
  final String unidade;
  final Color cor = Colors.green;
}

class ProdutoSql {
  String tipo;
  String nome;
  double valorCompraTotal;
  double preco;
  int quantidade;
  String unidade;
  int vendas;
  String data;

  ProdutoSql({
    required this.tipo,
    required this.nome,
    required this.valorCompraTotal,
    required this.preco,
    required this.quantidade,
    required this.unidade,
    this.vendas = 0,
    required this.data,
  });

  Map<String, Object?> toMap() {
    return {
      'tipo': tipo,
      'nome': nome,
      'valorCompraTotal': valorCompraTotal,
      'preco': preco,
      'quantidade': quantidade,
      'unidade': unidade,
      'vendas': vendas,
      'data': data,
    };
  }

  factory ProdutoSql.fromMap(Map<String, dynamic> map) {
    return ProdutoSql(
      tipo: map['tipo'],
      nome: map['nome'],
      valorCompraTotal: map['valorCompraTotal'],
      preco: map['preco'],
      quantidade: map['quantidade'],
      unidade: map['unidade'],
      vendas: map['vendas'],
      data: map['data'],
    );
  }

  @override
  String toString() {
    return 'Produto{tipo: $tipo, nome: $nome, valorCompraTotal: $valorCompraTotal, preco: $preco, quantidade: $quantidade, unidade: $unidade, vendas: $vendas, data: $data}';
  }
}
