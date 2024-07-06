import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/produto.dart';

class ProdutosProvider extends ChangeNotifier {
  List<Produto> _produtos = [
    Produto(
      id: 1,
      tipo: Tipos.vinho.name,
      nome: 'Vinho Sao Francisco',
      valorCompraTotal: 50.00,
      preco: 10.00,
      quantidade: 10,
      unidade: 'L',
    ),
    Produto(
      id: 2,
      tipo: Tipos.cachaca.name,
      nome: 'Cachaça Ypioca',
      valorCompraTotal: 25.00,
      preco: 5.00,
      quantidade: 5,
      unidade: 'L',
    ),
    Produto(
      id: 3,
      tipo: Tipos.vodka.name,
      nome: 'Vodka Smirnoff',
      valorCompraTotal: 75.00,
      preco: 15.00,
      quantidade: 15,
      unidade: 'L',
    ),
    Produto(
      id: 4,
      tipo: Tipos.whisky.name,
      nome: 'Whisky Johnnie Walker',
      valorCompraTotal: 100.00,
      preco: 20.00,
      quantidade: 20,
      unidade: 'L',
    ),
    Produto(
      id: 5,
      tipo: Tipos.cerveja.name,
      nome: 'Cerveja Skol',
      valorCompraTotal: 10.00,
      preco: 2.00,
      quantidade: 20,
      unidade: 'L',
    ),
    Produto(
      id: 6,
      tipo: Tipos.gelo.name,
      nome: 'Gelo',
      valorCompraTotal: 1.00,
      preco: 1.00,
      quantidade: 5,
      unidade: 'kg',
    ),
    Produto(
      id: 7,
      tipo: Tipos.outros.name,
      nome: 'Amendoin',
      valorCompraTotal: 7.00,
      preco: 7.00,
      quantidade: 7,
      unidade: 'kg',
    ),
    Produto(
      id: 8,
      tipo: Tipos.rum.name,
      nome: 'Rum Motilla',
      valorCompraTotal: 8.00,
      preco: 8.00,
      quantidade: 8,
      unidade: 'L',
    ),
    Produto(
      id: 9,
      tipo: Tipos.semAlcool.name,
      nome: 'Refrigerante',
      valorCompraTotal: 3.00,
      preco: 3.00,
      quantidade: 3,
      unidade: 'L',
    ),
    Produto(
      id: 10,
      tipo: Tipos.vinho.name,
      nome: 'Vinho Aurora',
      valorCompraTotal: 4.00,
      preco: 4.00,
      quantidade: 4,
      unidade: 'L',
    ),
    Produto(
      id: 11,
      tipo: Tipos.tequila.name,
      nome: 'Tequila Jose Cuervo',
      valorCompraTotal: 5.00,
      preco: 5.00,
      quantidade: 5,
      unidade: 'L',
    ),
    Produto(
      id: 12,
      tipo: Tipos.absinto.name,
      nome: 'Absinto',
      valorCompraTotal: 6.00,
      preco: 6.00,
      quantidade: 6,
      unidade: 'L',
    ),
    Produto(
      id: 13,
      tipo: Tipos.cerveja.name,
      nome: 'Cerveja Heineken',
      valorCompraTotal: 7.00,
      preco: 7.00,
      quantidade: 7,
      unidade: 'L',
    ),
    Produto(
      id: 14,
      tipo: Tipos.cerveja.name,
      nome: 'Cerveja Budweiser',
      valorCompraTotal: 8.00,
      preco: 8.00,
      quantidade: 8,
      unidade: 'L',
    ),
  ];

  List<Produto> produtosFiltro = [];

  List<Produto> _produtosVendidos = [];

  double valorCompraTotal() {
    return _produtos.fold(0, (total, produto) {
      return total + produto.valorCompraTotal;
    });
  }

  double valorVendaTotal() {
    return _produtosVendidos.fold(0, (total, produto) {
      return total + produto.preco * produto.quantidade;
    });
  }

  bool get filtroOn {
    return produtosFiltro.isNotEmpty;
  }

  List<Produto> get produtos {
    if (produtosFiltro.isNotEmpty) {
      return produtosFiltro;
    }
    return [..._produtos];
  }

  List<Produto> get produtosVendidos {
    return [..._produtosVendidos];
  }

  set produtos(List<Produto> produtos) {
    _produtos = produtos;
    notifyListeners();
  }

  void adicionarProduto(Produto produto) {
    _produtos.add(produto);
    notifyListeners();
  }

  List<Produto> filtrarPorTipo(String tipo) {
    produtosFiltro =
        _produtos.where((produto) => produto.tipo.contains(tipo)).toList();
    notifyListeners();
    return produtosFiltro;
  }

  void limparFiltro() {
    produtosFiltro = [];
    notifyListeners();
  }

  void venderProduto(Produto produto) {
    Produto produtoVendido = _produtosVendidos.firstWhere(
      (p) => p.id == produto.id,
      orElse: () {
        _produtosVendidos.add(produto);
        return produto;
      },
    );
    if (produtoVendido != produto) {
      produtoVendido.quantidade += produto.quantidade;
    }
    notifyListeners();
  }

  void alterarProduto(Produto produto) {
    final index = _produtos.indexWhere((p) => p.id == produto.id);
    _produtos[index] = produto;
    notifyListeners();
  }

  void alterarProdutoVendido(Produto produto) {
    final index = _produtosVendidos.indexWhere((p) => p.id == produto.id);
    _produtosVendidos[index] = produto;
    notifyListeners();
  }

  static ProdutosProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ProdutosProvider>(context, listen: listen);
  }
}
