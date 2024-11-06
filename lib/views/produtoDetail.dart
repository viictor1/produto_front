import 'package:flutter/material.dart';
import 'package:produto_front/models/produto.dart';
import 'package:produto_front/service/produtoService.dart';

class ProdutoDetail extends StatelessWidget {
  final ProdutoService _produtoService = ProdutoService();

  Future<void> handleDeletar(BuildContext context, int? id) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirmar exclusão'),
        content: Text('Tem certeza que deseja excluir este produto?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              if (id != null) {
                await _produtoService.deleteProduto(id);
              }
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Produto excluído com sucesso!')),
              );
            },
            child: Text('Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Produto produto = ModalRoute.of(context)!.settings.arguments as Produto;

    return Scaffold(
      appBar: AppBar(
        title: Text('Produto Detalhes'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Container(
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Descrição: ${produto.descricao}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Preço: R\$ ${produto.preco.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
                SizedBox(height: 20),
                Text(
                  'Estoque: ${produto.estoque}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Text(
                  'Data de Cadastro: ${produto.data.toLocal().toString().split(' ')[0]}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => handleDeletar(context, produto.id),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: Icon(Icons.delete),
      ),
    );
  }
}
