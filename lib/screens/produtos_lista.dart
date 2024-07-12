import 'package:flutter/material.dart';
import 'package:flutter_application_helder/providers/produtos_provider.dart';

import '../models/produto.dart';
import 'produto_item.dart';
import 'produto_inserir.dart';
import 'filtrar.dart';
import '../helpers/database.dart';
import '../helpers/http.dart';

class ProdutosLista extends StatefulWidget {
  const ProdutosLista({super.key});

  @override
  State<ProdutosLista> createState() => _ProdutosListaState();
}

List<ProdutoItem> produtosFiltro = [];
List<Produto> firebaseProdutos = [];
List<Produto> sqlProdutos = [];
bool _isInit = true;

@override
void didChangeDependencies() {
  if (_isInit) {
    compareData();
    _isInit = false;
  }
}

@override
void setState() {
  produtosFiltro = compareLists(firebaseProdutos, sqlProdutos);
}

Future<void> compareData() async {
  try {
    final results = await Future.wait([
      DatabaseHelper().fetchFromDB(),
      HttpHelper().fetchFromFirebase(),
    ]);
    sqlProdutos = results[0];
    firebaseProdutos = results[1];
    setState();
  } catch (e) {
    print(e);
  }
}

List<ProdutoItem> compareLists(
    List<Produto> firebaseProdutos, List<Produto> sqlProdutos) {
  List<Produto> onlyInFirebase = firebaseProdutos
      .where((produto) => !sqlProdutos.any((p) => p.id == produto.id))
      .toList();
  List<Produto> onlyInSql = sqlProdutos
      .where((produto) => !firebaseProdutos.any((p) => p.id == produto.id))
      .toList();
  if (onlyInSql.length > onlyInFirebase.length) {
    produtosFiltro = onlyInSql
        .map((produto) => ProdutoItem(
              produto: produto,
              id: produto.id.toString(),
              tipo: produto.nome,
              nome: produto.nome,
              preco: produto.preco.toString(),
              quantidade: produto.quantidade.toString(),
            ))
        .toList();
    return produtosFiltro;
  } else if (onlyInSql.length < onlyInFirebase.length) {
    produtosFiltro = onlyInFirebase
        .map((produto) => ProdutoItem(
              produto: produto,
              id: produto.id.toString(),
              tipo: produto.nome,
              nome: produto.nome,
              preco: produto.preco.toString(),
              quantidade: produto.quantidade.toString(),
            ))
        .toList();
    return produtosFiltro;
  } else {
    produtosFiltro = sqlProdutos
        .map((produto) => ProdutoItem(
              produto: produto,
              id: produto.id.toString(),
              tipo: produto.nome,
              nome: produto.nome,
              preco: produto.preco.toString(),
              quantidade: produto.quantidade.toString(),
            ))
        .toList();
    return produtosFiltro;
  }
}

class _ProdutosListaState extends State<ProdutosLista> {
  @override
  Widget build(BuildContext context) {
    ProdutosProvider provider = ProdutosProvider.of(context);
    provider.produtosItems = produtosFiltro;
    List<ProdutoItem> produtos = provider.produtosItems;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Produtos",
          style: TextStyle(color: Colors.amber[100]),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        backgroundColor: Colors.black45,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          return produtos[index];
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Text(
                "Estoque App",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text("Produtos"),
              onTap: () {
                if (ModalRoute.of(context)!.settings.name != "/produtos") {
                  Navigator.of(context).pushReplacementNamed("/produtos");
                } else {
                  Navigator.pop(context);
                }
              },
            ),
            ListTile(
              title: const Text("Vendas / Caixa"),
              onTap: () {
                if (ModalRoute.of(context)!.settings.name != "/vendas") {
                  Navigator.of(context).pushReplacementNamed("/vendas");
                } else {
                  Navigator.pop(context);
                }
              },
            ),
            ListTile(
              title: const Text("Sair"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.extended(
              label: const Text("Filtrar"),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const Filtrar();
                },
              )),
              backgroundColor: Colors.amber[300],
              splashColor: Colors.amber[100],
              icon: const Icon(Icons.filter_alt),
              heroTag: null,
            ),
            FloatingActionButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) {
                  return const ProdutoInserir();
                },
              )),
              backgroundColor: Colors.amber[300],
              splashColor: Colors.amber[100],
              heroTag: null,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            // provider.limparFiltro();
          },
          child: const Text("Limpar Filtros"),
        ),
      ],
    );
  }
}
