import 'package:flutter/material.dart';

import 'produto_item.dart';
import 'mock_produtos_data.dart';

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

  void retornar(BuildContext context) {
    Navigator.of(context).pop();
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
                        widget.update(produtos = (MOCK_PRODUTOS_DATA
                            .where((produto) =>
                                produto.tipo == myControllerTipo.text)
                            .map((p) => ProdutoItem(
                                p.id.toString(),
                                p.nome,
                                p.tipo,
                                p.preco.toString(),
                                p.quantidade.toString()))
                            .toList()));
                        retornar(context);
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
