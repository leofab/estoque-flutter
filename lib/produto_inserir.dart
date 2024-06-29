import 'package:flutter/material.dart';

class ProdutoInserir extends StatefulWidget {
  const ProdutoInserir({super.key});

  @override
  State<ProdutoInserir> createState() => _ProdutoInserirState();
}

class _ProdutoInserirState extends State<ProdutoInserir> {
  final key = GlobalKey<FormState>();
  final myControllerNome = TextEditingController();
  final myControllerTipo = TextEditingController();
  final myControllerDescricao = TextEditingController();
  final myControllerPreco = TextEditingController();
  final myControllerQuantidade = TextEditingController();
  final myControllerUnidade = TextEditingController();
  final myControllerCategoria = TextEditingController();
  final myControllerFornecedor = TextEditingController();
  final myControllerData = TextEditingController();
  final myControllerValidade = TextEditingController();
  final myControllerLote = TextEditingController();
  final myControllerLocal = TextEditingController();
  final myControllerObservacao = TextEditingController();

  void alerta(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Produto inserido com sucesso!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Nome"),
                    controller: myControllerNome,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Tipo"),
                    controller: myControllerTipo,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Descrição"),
                    controller: myControllerDescricao,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Preço"),
                    controller: myControllerPreco,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Quantidade"),
                    controller: myControllerQuantidade,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Unidade"),
                    controller: myControllerUnidade,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Categoria"),
                    controller: myControllerCategoria,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Fornecedor"),
                    controller: myControllerFornecedor,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Data"),
                    controller: myControllerData,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Validade"),
                    controller: myControllerValidade,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Lote"),
                    controller: myControllerLote,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Local"),
                    controller: myControllerLocal,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Observação"),
                    controller: myControllerObservacao,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        alerta(context);
                      }
                    },
                    child: const Text("Inserir"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
