import 'package:flutter/material.dart';

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
  final myControllerDescricao = TextEditingController();
  final myControllerPrecoTotal = TextEditingController();
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

  @override
  void dispose() {
    myControllerNome.dispose();
    myControllerTipo.dispose();
    myControllerDescricao.dispose();
    myControllerPrecoTotal.dispose();
    myControllerPreco.dispose();
    myControllerQuantidade.dispose();
    myControllerUnidade.dispose();
    myControllerCategoria.dispose();
    myControllerFornecedor.dispose();
    myControllerData.dispose();
    myControllerValidade.dispose();
    myControllerLote.dispose();
    myControllerLocal.dispose();
    myControllerObservacao.dispose();
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
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Categoria"),
                    controller: myControllerCategoria,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Fornecedor"),
                    controller: myControllerFornecedor,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Data"),
                    controller: myControllerData,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Validade"),
                    controller: myControllerValidade,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Lote"),
                    controller: myControllerLote,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Local"),
                    controller: myControllerLocal,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Observação"),
                    controller: myControllerObservacao,
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (key.currentState!.validate()) {
                Produto produto = Produto(
                  id: DateTime.now().toString(),
                  tipo: myControllerTipo.text,
                  nome: myControllerNome.text,
                  descricao: myControllerDescricao.text,
                  valorCompraTotal: myControllerPrecoTotal.text,
                  preco: myControllerPreco.text,
                  quantidade: myControllerQuantidade.text,
                  unidade: myControllerUnidade.text,
                  categoria: myControllerCategoria.text,
                  fornecedor: myControllerFornecedor.text,
                  data: myControllerData.text,
                  validade: myControllerValidade.text,
                  lote: myControllerLote.text,
                  local: myControllerLocal.text,
                  observacao: myControllerObservacao.text,
                );
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
