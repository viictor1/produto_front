import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:produto_front/service/produtoService.dart';
import 'package:produto_front/models/produto.dart';

class ProdutoForm extends StatefulWidget {
  @override
  _ProdutoFormState createState() => _ProdutoFormState();
}

class _ProdutoFormState extends State<ProdutoForm> {
  final _form = GlobalKey<FormState>();

  final _descricaoController = TextEditingController();
  final _precoController = TextEditingController();
  final _estoqueController = TextEditingController();
  
  final ProdutoService _produtoService = ProdutoService();

  @override
  void dispose() {
    _descricaoController.dispose();
    _precoController.dispose();
    _estoqueController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    if (!_form.currentState!.validate()) return;

    final produto = Produto(
      descricao: _descricaoController.text,
      preco: double.parse(_precoController.text),
      data: DateTime.now(),
      estoque: int.parse(_estoqueController.text),
    );

    try {
      await _produtoService.saveProduto(produto);
      Navigator.of(context).pop();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produto Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Descrição Inválida';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _precoController,
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d*)?')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preço inválido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _estoqueController,
                decoration: InputDecoration(labelText: 'Estoque'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Estoque inválido';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveForm,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: Icon(Icons.save),
      ),
    );
  }
}
