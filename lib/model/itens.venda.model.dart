import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ItensVendaModel {
  final int id;
  final int idvenda;
  final int idproduto;
  final String obs;
  final double valor;
  final double quantidade;
  final double subtotal;
  final String produto;
  final String marca;
  final String cor;
  final String tamanho;
  ItensVendaModel({
    required this.id,
    required this.idvenda,
    required this.idproduto,
    required this.obs,
    required this.valor,
    required this.quantidade,
    required this.subtotal,
    required this.produto,
    required this.marca,
    required this.cor,
    required this.tamanho,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idvenda': idvenda,
      'idproduto': idproduto,
      'obs': obs,
      'valor': valor,
      'quantidade': quantidade,
      'subtotal': subtotal,
      'produto': produto,
      'marca': marca,
      'cor': cor,
      'tamanho': tamanho,
    };
  }

  factory ItensVendaModel.fromMap(Map<String, dynamic> map) {
    return ItensVendaModel(
      id: map['id'] as int,
      idvenda: map['idvenda'] as int,
      idproduto: map['idproduto'] as int,
      obs: map['obs'] as String,
      valor: map['valor'] as double,
      quantidade: map['quantidade'] as double,
      subtotal: map['subtotal'] as double,
      produto: map['produto'] as String,
      marca: map['marca'] as String,
      cor: map['cor'] as String,
      tamanho: map['tamanho'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItensVendaModel.fromJson(String source) =>
      ItensVendaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
