import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:produto_front/service/produtoService.dart';
import 'package:produto_front/models/produto.dart';

class ProdutoForm extends StatefulWidget {
  @override
  _ProdutoFormState createState() => _ProdutoFormState();
}

class _ProdutoFormState extends State<ProdutoForm> {
  Produto? produto;
  final _form = GlobalKey<FormState>();

  late TextEditingController _descricaoController;
  late TextEditingController _precoController;
  late TextEditingController _estoqueController;
  late TextEditingController _dataController;

  final ProdutoService _produtoService = ProdutoService();

  DateTime? _selectedDate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    if (produto == null) {
      produto = ModalRoute.of(context)!.settings.arguments as Produto;
      
      _descricaoController = TextEditingController(text: produto!.descricao);
      _precoController = TextEditingController(text: produto!.preco.toString());
      _estoqueController = TextEditingController(text: produto!.estoque.toString());
      _dataController = TextEditingController(text: produto!.data.toLocal().toString().split(' ')[0]);
    }
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    _precoController.dispose();
    _estoqueController.dispose();
    _dataController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    if (!_form.currentState!.validate()) return;

    final produto = Produto(
      descricao: _descricaoController.text,
      preco: double.parse(_precoController.text),
      data: _selectedDate ?? DateTime.now(),
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

  Future<void> selecionarData() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dataController.text = '${_selectedDate!.toLocal()}'.split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produto Form'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            width: 500,
            child: Form(
              key: _form,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _descricaoController,
                    decoration: InputDecoration(labelText: 'Descrição'),
                    textAlign: TextAlign.center,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Descrição Inválida';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _precoController,
                    decoration: InputDecoration(labelText: 'Preço'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d*)?')),
                    ],
                    textAlign: TextAlign.center,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preço inválido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _estoqueController,
                    decoration: InputDecoration(labelText: 'Estoque'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    textAlign: TextAlign.center,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Estoque inválido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _dataController,
                    decoration: InputDecoration(
                      labelText: 'Data',
                      suffixIcon: GestureDetector(
                        onTap: selecionarData,
                        child: Icon(Icons.calendar_today),
                      ),
                    ),
                    textAlign: TextAlign.center,
                    readOnly: true,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
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
