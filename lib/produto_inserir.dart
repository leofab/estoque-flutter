import 'package:flutter/material.dart';

class ProdutoInserir extends StatefulWidget {
  const ProdutoInserir({super.key});

  @override
  State<ProdutoInserir> createState() => _ProdutoInserirState();
}

class _ProdutoInserirState extends State<ProdutoInserir> {
  final key = GlobalKey<FormState>();
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
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Descrição"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Imagem"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Preço"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Quantidade"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Unidade"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Categoria"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Fornecedor"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Data"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Validade"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Lote"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Local"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Observação"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        Navigator.of(context).pop();
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
