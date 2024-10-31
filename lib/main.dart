import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> listItems = [];

  @override
  void initState() {
    super.initState();
    fetchItems().then((items) {
      setState(() {
        listItems.clear();
        listItems.addAll(items);
      });
    }).catchError((error) {
      print("Erro ao buscar itens: $error");
    });
  }

  Future<List<String>> fetchItems() async {
    final response = await http.get(Uri.parse('https://sua-api.com/endpoint'));
    print(response);

    if (response.statusCode == 200) {
      List<dynamic> items = json.decode.(response.body);
      return items.map((item) => item.toString()).toList();
    } else {
      throw Exception('Falha ao carregar itens');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista com itens clicáveis"),
      ),
      body: listItems.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: listItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${listItems[index]}'),
                );
              },
            ),
    );
  }
}
