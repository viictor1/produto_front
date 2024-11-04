import 'package:flutter/material.dart';
import 'package:produto_front/data/produtoService.dart';
import 'package:produto_front/models/produto.dart';

class ProdutoList extends StatefulWidget {
  @override
  _ProdutoListState createState() => _ProdutoListState();
}

class _ProdutoListState extends State<ProdutoList> {
  late Future<List<Produto>> futureProdutos;

  @override
  void initState() {
    super.initState();
    futureProdutos = ProdutoService().fetchProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos'),
      ),
      body: FutureBuilder<List<Produto>>(
        future: futureProdutos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            final produtos = snapshot.data!;
            return ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (ctx, i) {
                final produto = produtos[i];

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8),
                    title: Text(
                      produto.descricao,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    onTap: () {
                      // Handle product tap
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
