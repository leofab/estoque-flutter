import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

import 'package:provider/provider.dart';
import '../models/produto.dart';
import '../helpers/database.dart';
import '../helpers/http.dart';
import '../screens/produto_item.dart';

class ProdutosProvider extends ChangeNotifier {
  List<Produto> _produtos = [];
  List<ProdutoItem> _produtosItems = [];
  List<Produto> produtosFiltro = [];
  List<Produto> _produtosVendidos = [];

  List<ProdutoItem> get produtosItems {
    return [..._produtosItems];
  }

  set produtosItems(List<ProdutoItem> produtosItems) {
    _produtosItems = produtosItems;
    notifyListeners();
  }

  set produtosVendidos(List<Produto> produtosVendidos) {
    _produtosVendidos = produtosVendidos;
    notifyListeners();
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
    produtosFiltro =
        _produtos.where((produto) => produto.tipo.contains(tipo)).toList();
    notifyListeners();
    return produtosFiltro;
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

  static ProdutosProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ProdutosProvider>(context, listen: listen);
  }
}
