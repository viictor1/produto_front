import 'package:flutter/material.dart';

class Produto {
  final int? id;
  final String descricao;
  final double preco;
  final DateTime data;
  final int estoque;

  const Produto({
    this.id,
    required this.descricao,
    required this.preco,
    required this.data,
    required this.estoque,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'],
      descricao: json['descricao'],
      preco: (json['preco']).toDouble(),
      data: DateTime.parse(json['data']), 
      estoque: json['estoque'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'preco': preco,
      'data': data.toIso8601String(), 
      'estoque': estoque,
    };
  }
}
