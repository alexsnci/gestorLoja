import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MovimentacaoCaixaModel {
  final int id;
  final int idcaixa;
  final String data;
  final double valor;
  final String tipo;
  final String obs;
  final String descricao;
  MovimentacaoCaixaModel({
    required this.id,
    required this.idcaixa,
    required this.data,
    required this.valor,
    required this.tipo,
    required this.obs,
    required this.descricao,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idcaixa': idcaixa,
      'data': data,
      'valor': valor,
      'tipo': tipo,
      'obs': obs,
      'descricao': descricao,
    };
  }

  factory MovimentacaoCaixaModel.fromMap(Map<String, dynamic> map) {
    return MovimentacaoCaixaModel(
      id: map['id'] as int,
      idcaixa: map['idcaixa'] as int,
      data: map['data'] as String,
      valor: map['valor'] as double,
      tipo: map['tipo'] as String,
      obs: map['obs'] ?? '',
      descricao: map['descricao'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovimentacaoCaixaModel.fromJson(String source) =>
      MovimentacaoCaixaModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
