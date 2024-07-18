import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/produto.dart';

class HttpHelper {
  Future<void> postHttp(Produto produto) async {
    var url =
        Uri.parse('${dotenv.env['url']}/produtos/produto${produto.id}.json');
    try {
      final response = await http.post(url,
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
          }));
      if (response.statusCode == 200) {
        print(json.decode(response.body));
      } else {
        throw Exception('Failed to post data to Firebase');
      }
    } catch (e) {
      print('ClientException with SocketException: $e');
    }
  }

  Future<void> deleteHttp(Produto produto) async {
    var url =
        Uri.parse('${dotenv.env['url']}/produtos/produto${produto.id}.json');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
      } else {
        throw Exception('Failed to delete data from Firebase');
      }
    } catch (e) {
      print('ClientException with SocketException: $e');
    }
  }

  Future<List<Produto>> fetchFromFirebase() async {
    String jsonString = '';
    var url = Uri.parse('${dotenv.env['url']}/produtos.json');
    try {
      final response = await _retryHttpGet(url);
      if (response.statusCode == 200) {
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
      } else {
        throw Exception('Failed to load data from Firebase');
      }
    } catch (e) {
      print('ClientException with SocketException: $e');
      return [];
    }
  }

  Future<http.Response> _retryHttpGet(Uri url,
      {int retries = 3, Duration delay = const Duration(seconds: 2)}) async {
    int attempt = 0;
    while (attempt < retries) {
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          return response;
        } else {
          throw http.ClientException(
              'Failed with status code: ${response.statusCode}');
        }
      } catch (e) {
        attempt++;
        if (attempt >= retries) {
          rethrow;
        }
        await Future.delayed(delay);
      }
    }
    throw http.ClientException('Failed after $retries attempts');
  }
}
