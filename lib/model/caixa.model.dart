import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CaixaModel {
  final int id;
  final int idcolaborador;
  final double valorabertura;
  final double total;
  final double entradas;
  final double saidas;
  final String observacoes;
  final String data;
  final String status;
  CaixaModel({
    required this.id,
    required this.idcolaborador,
    required this.valorabertura,
    required this.total,
    required this.entradas,
    required this.saidas,
    required this.observacoes,
    required this.data,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idcolaborador': idcolaborador,
      'valorabertura': valorabertura,
      'total': total,
      'entradas': entradas,
      'saidas': saidas,
      'observacoes': observacoes,
      'data': data,
      'status': status,
    };
  }

  factory CaixaModel.fromMap(Map<String, dynamic> map) {
    return CaixaModel(
      id: map['id'] as int,
      idcolaborador: map['idcolaborador'] as int,
      valorabertura: map['valorabertura'] ?? 0,
      total: map['total'] ?? 0,
      entradas: map['entradas'] ?? 0,
      saidas: map['saidas'] ?? 0,
      observacoes: map['observacoes'] as String,
      data: map['data'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CaixaModel.fromJson(String source) =>
      CaixaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
