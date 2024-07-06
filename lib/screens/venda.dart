import 'package:flutter/material.dart';

import '../providers/produtos_provider.dart';
import '../models/produto.dart';

class Venda extends StatefulWidget {
  final Produto produto;
  const Venda({super.key, required this.produto});

  @override
  State<Venda> createState() => _VendaState();
}

class _VendaState extends State<Venda> {
  final myControllerQuantidade = TextEditingController();
  int quantidade = 0;

  @override
  void dispose() {
    myControllerQuantidade.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProdutosProvider provider = ProdutosProvider.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Vendas / Caixa")),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(25),
          children: <Widget>[
            Text("Produto: ${widget.produto.nome}",
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            Text("Quantidade Restante: ${widget.produto.quantidade}",
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            Text("Preço: ${widget.produto.preco}",
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            TextFormField(
              onChanged: (value) => setState(() {
                quantidade = int.parse(value);
              }),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Quantidade"),
              controller: myControllerQuantidade,
              validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            Text("Total: ${widget.produto.preco * quantidade}",
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (widget.produto.quantidade < quantidade) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text("Quantidade de Produtos Insuficiente!"),
                      );
                    },
                  );
                } else if (quantidade == 0) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text("Quantidade de Produtos Inválida!"),
                      );
                    },
                  );
                } else {
                  widget.produto.quantidade -= quantidade;
                  widget.produto.vendas += quantidade;
                  provider.alterarProduto(widget.produto);
                  Produto produtoVendido = Produto(
                    id: widget.produto.id,
                    tipo: widget.produto.tipo,
                    nome: widget.produto.nome,
                    valorCompraTotal: widget.produto.valorCompraTotal,
                    preco: widget.produto.preco,
                    unidade: widget.produto.unidade,
                    quantidade: quantidade,
                  );
                  provider.venderProduto(produtoVendido);
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Vender"),
            ),
          ],
        ),
      ),
    );
  }
}
