import 'package:flutter/material.dart';

import '../providers/produtos_provider.dart';
import '../models/produto.dart';
import '../helpers/database.dart';
import '../helpers/http.dart';

class ProdutoInserir extends StatefulWidget {
  const ProdutoInserir({super.key});

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

enum Unidades {
  lata350("Lata 350"),
  lata269("Lata 269"),
  seissentos("600"),
  litrao("Litrão"),
  litro("Litro"),
  saco("Saco");

  const Unidades(this.unidade);
  final String unidade;
  final Color cor = Colors.green;
}

class _ProdutoInserirState extends State<ProdutoInserir> {
  final key = GlobalKey<FormState>();
  final myControllerNome = TextEditingController();
  final myControllerTipo = TextEditingController();
  final myControllerPrecoTotal = TextEditingController();
  final myControllerPreco = TextEditingController();
  final myControllerQuantidade = TextEditingController();
  final myControllerUnidade = TextEditingController();

  var isLoaded = false;

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

  Future<void> result(Produto produto) async {
    await HttpHelper().postHttp(produto);
    await DatabaseHelper().insertDb(produto.toMap());
  }

  @override
  Widget build(BuildContext context) {
    final provider = ProdutosProvider.of(context);
    int id = provider.produtosItems.length + 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inserir Produto"),
        backgroundColor: Colors.amber[100],
      ),
      body: isLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
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
                          decoration:
                              const InputDecoration(labelText: "Quantidade"),
                          controller: myControllerQuantidade,
                          validator: (value) =>
                              value!.isEmpty ? "Campo obrigatório" : null,
                        ),
                        const SizedBox(height: 10),
                        DropdownMenu<Unidades>(
                          initialSelection: Unidades.lata350,
                          controller: myControllerUnidade,
                          requestFocusOnTap: true,
                          label: const Text("Unidade"),
                          onSelected: (Unidades? cor) {
                            setState(() {
                              myControllerUnidade.text = cor!.unidade;
                            });
                          },
                          dropdownMenuEntries: Unidades.values
                              .map<DropdownMenuEntry<Unidades>>(
                                  (Unidades unidade) {
                            return DropdownMenuEntry<Unidades>(
                              value: unidade,
                              label: unidade.name,
                              enabled: unidade.name != 'Grey',
                              style: MenuItemButton.styleFrom(
                                foregroundColor: unidade.cor,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      setState(() {
                        isLoaded = true;
                      });
                      Produto produto = Produto(
                        id: id,
                        tipo: myControllerTipo.text.toLowerCase(),
                        nome: myControllerNome.text,
                        valorCompraTotal:
                            double.parse(myControllerPrecoTotal.text),
                        preco: double.parse(myControllerPreco.text),
                        quantidade: int.parse(myControllerQuantidade.text),
                        unidade: myControllerUnidade.text,
                      );
                      result(produto).then((_) {
                        setState(() {
                          isLoaded = false;
                        });
                        Navigator.pop(context, true);
                        alerta(context);
                      });
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
