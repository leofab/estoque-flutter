import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import './models/produto.dart';
import 'produto_item.dart';
import 'mock_produtos_data.dart';

class ProdutoInserir extends StatefulWidget {
  final List<ProdutoItem> produtos;
  final Function(List<ProdutoItem>) update;
  const ProdutoInserir(
      {super.key, required this.update, required this.produtos});

  @override
  State<ProdutoInserir> createState() => _ProdutoInserirState();
}

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

class _ProdutoInserirState extends State<ProdutoInserir> {
  final key = GlobalKey<FormState>();
  final myControllerNome = TextEditingController();
  final myControllerTipo = TextEditingController();
  final myControllerPrecoTotal = TextEditingController();
  final myControllerPreco = TextEditingController();
  final myControllerQuantidade = TextEditingController();
  final myControllerUnidade = TextEditingController();

  @override
  void dispose() {
    myControllerNome.dispose();
    myControllerTipo.dispose();
    myControllerPrecoTotal.dispose();
    myControllerPreco.dispose();
    myControllerQuantidade.dispose();
    myControllerUnidade.dispose();
    super.dispose();
  }

  void alerta(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Produto inserido com sucesso!"),
        );
      },
    );
  }

  void carregarDB() async {
    openDatabase(
      join(await getDatabasesPath(), 'estoque_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE produtos(id TEXT PRIMARY KEY, tipo TEXT, nome TEXT, valorCompraTotal TEXT, preco TEXT, quantidade TEXT, unidade TEXT)',
        );
      },
      version: 1,
    );
  }

  void inserirProdutoDB(Produto produto) async {
    final Database db = await openDatabase(
      join(await getDatabasesPath(), 'estoque_database.db'),
    );
    await db.insert(
      'estoque_database.db',
      produto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inserir Produto"),
        backgroundColor: Colors.amber[100],
      ),
      body: ListView(
        physics: const ScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Nome"),
                    controller: myControllerNome,
                    validator: (value) =>
                        value!.isEmpty ? "Campo obrigatório" : null,
                  ),
                  const SizedBox(height: 20),
                  DropdownMenu<Tipos>(
                    initialSelection: Tipos.absinto,
                    controller: myControllerTipo,
                    requestFocusOnTap: true,
                    label: const Text("Tipo"),
                    onSelected: (Tipos? cor) {
                      setState(() {
                        myControllerTipo.text = cor!.tipo;
                      });
                    },
                    dropdownMenuEntries: Tipos.values
                        .map<DropdownMenuEntry<Tipos>>((Tipos tipo) {
                      return DropdownMenuEntry<Tipos>(
                        value: tipo,
                        label: tipo.name,
                        enabled: tipo.name != 'Grey',
                        style: MenuItemButton.styleFrom(
                          foregroundColor: tipo.cor,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Preço de Compra Total"),
                    controller: myControllerPrecoTotal,
                    validator: (value) =>
                        value!.isEmpty ? "Campo obrigatório" : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Preço"),
                    controller: myControllerPreco,
                    validator: (value) =>
                        value!.isEmpty ? "Campo obrigatório" : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Quantidade"),
                    controller: myControllerQuantidade,
                    validator: (value) =>
                        value!.isEmpty ? "Campo obrigatório" : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Unidade"),
                    controller: myControllerUnidade,
                    validator: (value) =>
                        value!.isEmpty ? "Campo obrigatório" : null,
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (key.currentState!.validate()) {
                Produto produto = Produto(
                  id: DateTime.now().hashCode.toString(),
                  tipo: myControllerTipo.text,
                  nome: myControllerNome.text,
                  valorCompraTotal: myControllerPrecoTotal.text,
                  preco: myControllerPreco.text,
                  quantidade: myControllerQuantidade.text,
                  unidade: myControllerUnidade.text,
                );
                inserirProdutoDB(produto);
                MOCK_PRODUTOS_DATA.add(produto);
                widget.update([
                  ...widget.produtos,
                  ProdutoItem(
                    produto.id,
                    produto.nome,
                    produto.tipo,
                    produto.preco,
                    produto.quantidade,
                  ),
                ]);
                Navigator.of(context).pop();
                alerta(context);
              }
            },
            child: const Text("Inserir"),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
