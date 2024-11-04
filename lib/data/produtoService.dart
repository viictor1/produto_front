import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:produto_front/models/produto.dart';

class ProdutoService {
  final String apiUrl = 'https://localhost:3000/';

  Future<List<Produto>> fetchProdutos() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Produto.fromJson(item)).toList();
    } else {
      throw Exception('Erro ao carregar produtos');
    }
  }
}
