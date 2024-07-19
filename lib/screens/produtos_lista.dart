import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_helder/main.dart';
import 'package:flutter_application_helder/providers/produtos_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/produto.dart';
import 'produto_item.dart';
import 'produto_inserir.dart';
import 'filtrar.dart';
import '../helpers/database.dart';
import '../helpers/http.dart';
import '../service/connectivity_service.dart';
import '../debauncer.dart';

class ProdutosLista extends StatefulWidget {
  const ProdutosLista({super.key});

  @override
  State<ProdutosLista> createState() => _ProdutosListaState();
}

class _ProdutosListaState extends State<ProdutosLista> with RouteAware {
  List<Produto> produtosProdutos = [];
  List<ProdutoItem> produtosFiltro = [];
  List<Produto> produtosVendidos = [];
  List<Produto> firebaseProdutos = [];
  List<Produto> sqlProdutos = [];
  bool _isInit = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  final ConnectivityService _connectivityService = ConnectivityService();
  final Debouncer _debouncer = Debouncer(milliseconds: 200);
  bool isLoadingState = false;

  @override
  void initState() {
    super.initState();
    // Schedule compareData to run after the widget is built
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_isInit) {
        // compareData();
        _connectivitySubscription =
            _connectivityService.connectivityStream.listen((result) {
          if (result.contains(ConnectivityResult.wifi) ||
              result.contains(ConnectivityResult.mobile) ||
              result.contains(ConnectivityResult.ethernet)) {
            _debouncer.run(compareData);
          }
        });
        _isInit = false;
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      compareData();
    });
  }

  Future<void> compareData() async {
    isLoadingState = true;
    try {
      final resultDb = await DatabaseHelper().fetchFromDB();
      sqlProdutos = resultDb;
    } catch (e) {
      print('Error fetching from local database: $e');
    }
    List<ConnectivityResult> isConnected =
        await _connectivityService.isConnected;

    if (isConnected.contains(ConnectivityResult.wifi) ||
        isConnected.contains(ConnectivityResult.mobile) ||
        isConnected.contains(ConnectivityResult.ethernet)) {
      try {
        final resultFirebase = await HttpHelper().fetchFromFirebase();
        firebaseProdutos = resultFirebase;
      } catch (e) {
        print('Error fetching from Firebase: $e');
        firebaseProdutos = [];
      }
    } else {
      firebaseProdutos = [];
    }
    try {
      final resultSales = await DatabaseHelper().fetchAllProductsWithSales();
      produtosVendidos = resultSales;
    } catch (e) {
      print('Error fetching sold products: $e');
    }
    try {
      await compareLists(firebaseProdutos, sqlProdutos);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {});
        }
      });
    } catch (e) {
      print('Error comparing lists: $e');
    }
    isLoadingState = false;
  }

  Future<void> compareLists(
      List<Produto> firebaseProdutos, List<Produto> sqlProdutos) async {
    produtosProdutos = [];

    List<ConnectivityResult> isConnected =
        await _connectivityService.isConnected;

    bool hasInternet = isConnected.contains(ConnectivityResult.wifi) ||
        isConnected.contains(ConnectivityResult.mobile) ||
        isConnected.contains(ConnectivityResult.ethernet);

    if (hasInternet) {
      try {
        final resultFirebase = await HttpHelper().fetchFromFirebase();
        firebaseProdutos = resultFirebase;
      } catch (e) {
        print('Error fetching from Firebase: $e');
        firebaseProdutos = [];
      }
    } else {
      firebaseProdutos = [];
    }

    if (hasInternet && firebaseProdutos.isEmpty) {
      for (var produto in sqlProdutos) {
        try {
          await HttpHelper().postHttp(produto);
        } catch (e) {
          print('Error posting to Firebase: $e');
        }
      }
      produtosProdutos = sqlProdutos;
    }

    if (hasInternet && sqlProdutos.isEmpty) {
      for (var produto in firebaseProdutos) {
        try {
          await DatabaseHelper().insertDb(produto.toMap());
        } catch (e) {
          print('Error inserting to local DB: $e');
        }
      }
      produtosProdutos = firebaseProdutos;
    }
    if (sqlProdutos.length > firebaseProdutos.length) {
      for (var produtos in sqlProdutos) {
        for (var prod in firebaseProdutos) {
          if (prod.id == produtos.id && prod.vendas != produtos.vendas ||
              prod.quantidade != produtos.quantidade) {
            try {
              await HttpHelper().deleteHttp(produtos);
              await HttpHelper().postHttp(produtos);
            } catch (e) {
              print('Error updating Firebase: $e');
            }
          } else if (prod.id != produtos.id) {
            try {
              await HttpHelper().postHttp(produtos);
            } catch (e) {
              print('Error posting to Firebase: $e');
            }
          }
        }
      }
      produtosProdutos = sqlProdutos;
    } else if (sqlProdutos.length < firebaseProdutos.length) {
      for (var produto in firebaseProdutos) {
        if (!sqlProdutos.contains(produto)) {
          try {
            await DatabaseHelper().insertDb(produto.toMap());
          } catch (e) {
            print('Error inserting to local DB: $e');
          }
        } else {
          try {
            await DatabaseHelper().alterProductByID(produto.toMap());
          } catch (e) {
            print('Error updating local DB: $e');
          }
        }
      }
      produtosProdutos = firebaseProdutos;
    } else {
      produtosProdutos = sqlProdutos;
    }

    produtosFiltro = produtosProdutos
        .map((produto) => ProdutoItem(
              produto: produto,
              id: produto.id.toString(),
              tipo: produto.nome,
              nome: produto.nome,
              preco: produto.preco.toString(),
              quantidade: produto.quantidade.toString(),
            ))
        .toList();
  }

  Future<void> _navigateToProdutoInserir(BuildContext context) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const ProdutoInserir();
      },
    ));
    if (result != null) {
      await compareData();
    }
  }

  @override
  Widget build(BuildContext context) {
    ProdutosProvider provider = ProdutosProvider.of(context);
    provider.produtosItems = produtosFiltro;
    provider.produtosVendidos = produtosVendidos;
    provider.produtos = produtosProdutos;
    List<ProdutoItem> produtos = provider.isFiltered
        ? provider.produtos.map((produto) {
            return ProdutoItem(
              produto: produto,
              id: produto.id.toString(),
              tipo: produto.nome,
              nome: produto.nome,
              preco: produto.preco.toString(),
              quantidade: produto.quantidade.toString(),
            );
          }).toList()
        : provider.produtosItems
            .where((produto) => produto.produto.quantidade > 0)
            .toList();

    return isLoadingState
        ? Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 180),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Carregando produtos',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20),
                    const CircularProgressIndicator(
                      semanticsLabel: 'Circular progress indicator',
                      backgroundColor: Colors.black,
                      color: Color(0xFFFFD54F),
                    ),
                  ]),
            ),
          )
        : Scaffold(
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
              padding: const EdgeInsets.all(25),
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                return produtos[index];
              },
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
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
                      if (ModalRoute.of(context)!.settings.name !=
                          "/produtos") {
                        Navigator.of(context).pushReplacementNamed("/produtos");
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  ListTile(
                    title: const Text("Vendas / Caixa"),
                    onTap: () async {
                      if (ModalRoute.of(context)!.settings.name != "/vendas") {
                        await compareData();
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
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton.extended(
                    label: const Text("Filtrar"),
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
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
                    onPressed: () => _navigateToProdutoInserir(context),
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
                  DatabaseHelper().deleteAllProdutosFromDB();
                },
                child: const Text("Limpar Filtros"),
              ),
            ],
          );
  }
}
