import 'package:flutter/material.dart';

enum Tipo {
  Absinto,
  Amarguinha,
  Cachaca,
  Cerveja,
  Champanhe,
  Conhaque,
  Gim,
  Grappa,
  Hidromel,
  Licor,
  Rum,
  Saque,
  Sidra,
  Tequila,
  Vermute,
  Vinho,
  Vodka,
  Whisky,
  SemAlcool,
  Gelo,
  Outros,
}

class Produto {
  final String id;
  final Tipo tipo;
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

  const Produto({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.descricao,
    required this.imagem,
    required this.preco,
    required this.quantidade,
    required this.unidade,
    required this.categoria,
    required this.fornecedor,
    required this.data,
    required this.validade,
    required this.lote,
    required this.local,
    required this.observacao,
  });
}
