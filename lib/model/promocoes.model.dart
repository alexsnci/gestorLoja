import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PromocoesModel {
  final int id;
  final int idestoque;
  final double valor;
  final double valordesconto;
  final double valoratual;
  final String datainicio;
  final String datafim;
  final String status;
  final double porcentagem;
  final String produto;
  final String modelo;
  final String setor;
  final String tamanho;
  final String cor;
  PromocoesModel({
    required this.id,
    required this.idestoque,
    required this.valor,
    required this.valordesconto,
    required this.valoratual,
    required this.datainicio,
    required this.datafim,
    required this.status,
    required this.porcentagem,
    required this.produto,
    required this.modelo,
    required this.setor,
    required this.tamanho,
    required this.cor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idestoque': idestoque,
      'valor': valor,
      'valordesconto': valordesconto,
      'valoratual': valoratual,
      'datainicio': datainicio,
      'datafim': datafim,
      'status': status,
      'porcentagem': porcentagem,
      'produto': produto,
      'modelo': modelo,
      'setor': setor,
      'tamanho': tamanho,
      'cor': cor,
    };
  }

  factory PromocoesModel.fromMap(Map<String, dynamic> map) {
    return PromocoesModel(
      id: map['id'] as int,
      idestoque: map['idestoque'] as int,
      valor: map['valor'] as double,
      valordesconto: map['valordesconto'] as double,
      valoratual: map['valoratual'] as double,
      datainicio: map['datainicio'] as String,
      datafim: map['datafim'] as String,
      status: map['status'] as String,
      porcentagem: map['porcentagem'] as double,
      produto: map['produto'] as String,
      modelo: map['modelo'] as String,
      setor: map['setor'] as String,
      tamanho: map['tamanho'] as String,
      cor: map['cor'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PromocoesModel.fromJson(String source) =>
      PromocoesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
