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
        title: Text('Detalhes do Produto'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    'Descrição',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    produto.descricao,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Divider(),
                Center(
                  child: Text(
                    'Preço',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'R\$ ${produto.preco.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Divider(),
                Center(
                  child: Text(
                    'Estoque',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    '${produto.estoque}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Divider(),
                Center(
                  child: Text(
                    'Data',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    '${produto.data.toLocal().toString().split(' ')[0]}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: SizedBox(
          height: 70,
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            buttonPadding: EdgeInsets.all(12),
            children: [
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => handleDeletar(context, produto.id),
              ),
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () async {
                  await Navigator.of(context).pushNamed(
                    '/produtoForm',
                    arguments: produto,
                  );
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
