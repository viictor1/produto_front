import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:produto_front/models/produto.dart';

class ProdutoService {
  final String url = 'http://localhost:3000/';

  Future<List<Produto>> fetchProdutos() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Produto.fromJson(item)).toList();
    } else {
      throw Exception('Erro ao carregar produtos');
    }
  }

  Future<void> saveProduto(Produto produto) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(produto.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao salvar o produto');
    }
  }
}
