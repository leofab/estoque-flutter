import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/produto.dart';

class HttpHelper {
  Future<void> getHttp() async {
    var url = Uri.parse('${dotenv.env['url']}/produtos.json');
    final response = await http.get(url);
    final data = json.decode(response.body);
  }

  Future<void> postHttp(Produto produto) async {
    var url = Uri.parse('${dotenv.env['url']}/produtos/${produto.id}.json');
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
            }))
        .then((response) {
      print(json.decode(response.body));
    });
  }

  Future<void> patchHttp(Produto produto) async {
    var url = Uri.parse('${dotenv.env['url']}/produtos/${produto.id}.json');
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
            }))
        .then((response) {
      print(json.decode(response.body));
    });
  }
}
