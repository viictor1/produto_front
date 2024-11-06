import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:produto_front/views/produtoList.dart';
import 'package:produto_front/views/produtoForm.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Produto Front',
      theme: ThemeData.dark(),
      home: ProdutoList(),
      routes: {
        '/produtoForm': (_) => ProdutoForm()
      }
    );
  }
}

