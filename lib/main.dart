import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:produto_front/views/produtoList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: ProdutoList(),
    );
  }
}

