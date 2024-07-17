import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/produto.dart';

class HttpHelper {
  Future<void> postHttp(Produto produto) async {
    var url =
        Uri.parse('${dotenv.env['url']}/produtos/produto${produto.id}.json');
    return http
        .post(url,
            body: json.encode({
              'id': produto.id,
              'tipo': produto.tipo,
              'nome': produto.nome,
              'valorCompraTotal': produto.valorCompraTotal,
              'preco': produto.preco,
              'quantidade': produto.quantidade,
              'unidade': produto.unidade,
              'vendas': produto.vendas,
              'data': produto.data,
            }))
        .then((response) {
      print(json.decode(response.body));
    });
  }

  Future<void> deleteHttp(Produto produto) async {
    var url =
        Uri.parse('${dotenv.env['url']}/produtos/produto${produto.id}.json');
    return http.delete(url).then((response) {
      print(json.decode(response.body));
    });
  }

  Future<void> patchHttp(Produto produto) async {
    var url =
        Uri.parse('${dotenv.env['url']}/produtos/produto${produto.id}.json');
    return http
        .patch(url,
            body: json.encode({
              'id': produto.id,
              'tipo': produto.tipo,
              'nome': produto.nome,
              'valorCompraTotal': produto.valorCompraTotal,
              'preco': produto.preco,
              'quantidade': produto.quantidade,
              'unidade': produto.unidade,
              'vendas': produto.vendas,
              'data': produto.data,
            }))
        .then((response) {
      print(json.decode(response.body));
    });
  }

  Future<List<Produto>> fetchFromFirebase() async {
    String jsonString = '';
    var url = Uri.parse('${dotenv.env['url']}/produtos.json');
    return http.get(url).then((response) {
      jsonString = response.body;
      List<dynamic> preData = json.decode(jsonString).values.toList();
      final data = <String, dynamic>{};
      for (var value in preData) {
        data.addEntries(value.entries as Iterable<MapEntry<String, dynamic>>);
      }

      final dataMap = data as Map<String, dynamic>;
      List<Produto> produtos = [];
      dataMap.values.forEach((value) {
        produtos.add(Produto(
          id: value['id'],
          tipo: value['tipo'],
          nome: value['nome'],
          valorCompraTotal: value['valorCompraTotal'],
          preco: value['preco'],
          quantidade: value['quantidade'],
          unidade: value['unidade'],
          vendas: value['vendas'],
          data: DateTime.parse(value['data']).toString(),
        ));
      });
      return produtos;
    });
  }
}
