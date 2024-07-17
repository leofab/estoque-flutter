import 'package:flutter/material.dart';

import '../providers/produtos_provider.dart';
import '../screens/produto_item_vendas.dart';

class ProdutoVendas extends StatefulWidget {
  const ProdutoVendas({super.key});

  @override
  State<ProdutoVendas> createState() => _ProdutoVendasState();
}

class _ProdutoVendasState extends State<ProdutoVendas> {
  @override
  Widget build(BuildContext context) {
    ProdutosProvider provider = ProdutosProvider.of(context);
    List<ProdutoItemVendas> produtos = provider.produtosVendidos
        .map((produto) => ProdutoItemVendas(
              produto: produto,
              id: produto.id.toString(),
              tipo: produto.nome,
              nome: produto.nome,
              preco: produto.preco.toString(),
              quantidade: produto.quantidade.toString(),
              vendas: produto.vendas.toString(),
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Produtos Vendidos",
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
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        physics: const ScrollPhysics(),
        children: produtos,
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.black45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Total de Vendas: ${(provider.valorVendaTotal()).toString()}",
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 12,
              ),
            ),
            Text(
              "Total Valor Compra: ${(provider.valorCompraTotal()).toString()}",
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 12,
              ),
            ),
            Text(
              "Lucro Esperado: ${(provider.valorVendaTotal() - provider.valorCompraTotal()).toString()}",
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
