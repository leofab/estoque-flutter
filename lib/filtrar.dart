import 'package:flutter/material.dart';

import 'produto_item.dart';
import 'mock_produtos_data.dart';
import 'produto_item.dart';

class Filtrar extends StatefulWidget {
  final List<ProdutoItem> produtos;
  final Function(List<ProdutoItem>) update;
  const Filtrar({super.key, required this.update, required this.produtos});

  @override
  State<Filtrar> createState() => _FiltrarState();
}

class _FiltrarState extends State<Filtrar> {
  final key = GlobalKey<FormState>();
  final myControllerNome = TextEditingController();
  final myControllerTipo = TextEditingController();
  final myControllerCategoria = TextEditingController();
  final myControllerFornecedor = TextEditingController();
  final myControllerLote = TextEditingController();

  @override
  void dispose() {
    myControllerNome.dispose();
    myControllerTipo.dispose();
    myControllerCategoria.dispose();
    myControllerFornecedor.dispose();
    myControllerLote.dispose();
    super.dispose();
  }

  List produtos = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filtrar Produto"),
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
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Tipo"),
                    controller: myControllerTipo,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        widget.update(produtos = ProtudoItem(MOCK_PRODUTOS_DATA
                            .where((produto) =>
                                produto.tipo == myControllerTipo.text)
                            .toList()));
                      },
                      child: const Text("Filtrar"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
