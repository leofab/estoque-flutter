import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/produtos_provider.dart';
import 'produtos_lista.dart';

class Filtrar extends StatefulWidget {
  const Filtrar({super.key});

  @override
  State<Filtrar> createState() => _FiltrarState();
}

class _FiltrarState extends State<Filtrar> {
  final key = GlobalKey<FormState>();
  final myControllerTipo = TextEditingController();

  @override
  void dispose() {
    myControllerTipo.dispose();
    super.dispose();
  }

  Future<void> _retornar(BuildContext context) async {
    ProdutosProvider provider =
        Provider.of<ProdutosProvider>(context, listen: false);
    final result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ProdutosLista();
      },
    ));
    if (result == true) {
      provider.notifyListeners();
    }
  }

  @override
  Widget build(BuildContext context) {
    ProdutosProvider provider = ProdutosProvider.of(context);
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
                        provider.filtrarPorTipo(
                            myControllerTipo.text.toLowerCase());
                        _retornar(context);
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
