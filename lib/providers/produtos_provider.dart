import 'package:flutter/material.dart';

import '../models/produto.dart';

class Produtos with ChangeNotifier {
  List<Produto> _items = [];

  List<Produto> get items => [..._items];

  void addProduto(Produto produto) {
    _items.add(produto);
    notifyListeners();
  }

  void removeProduto(int id) {
    _items.removeWhere((produto) => produto.id == id);
    notifyListeners();
  }

  void alterarProduto(Produto produto) {
    final index = _items.indexWhere((prod) => prod.id == produto.id);
    if (index >= 0) {
      _items[index] = produto;
      notifyListeners();
    }
  }
}
