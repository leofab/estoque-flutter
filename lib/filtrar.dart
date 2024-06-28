import 'package:flutter/material.dart';

class Filtrar extends StatefulWidget {
  final Function update;
  Filtrar({super.key, required this.update});

  @override
  State<Filtrar> createState() => _FiltrarState();
}

class _FiltrarState extends State<Filtrar> {
  final key = GlobalKey<FormState>();
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
                    decoration: const InputDecoration(labelText: "Nome"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Tipo"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Categoria"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Fornecedor"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Lote"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      onPressed: () {},
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
