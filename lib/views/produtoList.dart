import 'package:flutter/material.dart';
import 'package:produto_front/service/produtoService.dart';
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

  void _refreshProdutos() {
    setState(() {
      futureProdutos = ProdutoService().fetchProdutos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Lista de Produtos')),
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
            return Center( 
              child: Container(
                width: 500,  
                child: ListView.builder(
                  itemCount: produtos.length,
                  itemBuilder: (context, index) {
                    final produto = produtos[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: Card(
                        color: Color(0xFFF5F5F5),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          title: Text(
                            produto.descricao,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () async {
                            await Navigator.of(context).pushNamed(
                              '/produtoDetail',
                              arguments: produto,
                            );
                            _refreshProdutos();
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/produtoForm');
          _refreshProdutos();
        },
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: Icon(Icons.add),
      ),
    );
  }
}
