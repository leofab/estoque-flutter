import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../models/produto.dart';
import '../screens/produto_item.dart';

class ProdutosProvider extends ChangeNotifier {
  List<Produto> _produtos = [];
  List<ProdutoItem> _produtosItems = [];
  List<Produto> _produtosFiltro = [];
  List<Produto> _produtosVendidos = [];
  bool _isFiltered = false;

  bool get isFiltered => _isFiltered;

  List<ProdutoItem> get produtosItems {
    return [..._produtosItems];
  }

  List<Produto> get produtos => _isFiltered ? _produtosFiltro : _produtos;

  List<Produto> get produtosVendidos {
    return [..._produtosVendidos];
  }

  void _scheduleNotifyListeners() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  set produtosItems(List<ProdutoItem> produtosItems) {
    _produtosItems = produtosItems;
    _scheduleNotifyListeners();
  }

  set produtosVendidos(List<Produto> produtosVendidos) {
    _produtosVendidos = produtosVendidos;
    _scheduleNotifyListeners();
  }

  set produtos(List<Produto> produtos) {
    _produtos = produtos;
    _scheduleNotifyListeners();
  }

  set produtosFiltro(List<Produto> produtosFiltro) {
    _produtosFiltro = produtosFiltro;
    _scheduleNotifyListeners();
  }

  double valorCompraTotal() {
    double total = 0;
    for (int i = 0; i < _produtos.length; i++) {
      total += _produtos[i].valorCompraTotal;
    }
    return total;
  }

  double valorVendaTotal() {
    return _produtosVendidos.fold(0, (total, produto) {
      return total + produto.preco * produto.vendas;
    });
  }

  List<Produto> filtrarPorTipo(String tipo) {
    _produtosFiltro =
        _produtos.where((produto) => produto.tipo.contains(tipo)).toList();
    _isFiltered = true;
    _scheduleNotifyListeners();
    return produtos;
  }

  void clearFilter() {
    _isFiltered = false;
    _scheduleNotifyListeners();
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
    _scheduleNotifyListeners();
  }

  void alterarProduto(Produto produto) {
    final index = _produtos.indexWhere((p) => p.id == produto.id);
    _produtos[index] = produto;
    _scheduleNotifyListeners();
  }

  static ProdutosProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ProdutosProvider>(context, listen: listen);
  }
}
