import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VendaModel {
  final int id;
  final int idcliente;
  final int idcolaborador;
  final int idloja;
  final String data;
  final String status;
  final String tipo;
  final double valorcompra;
  VendaModel({
    required this.id,
    required this.idcliente,
    required this.idcolaborador,
    required this.idloja,
    required this.data,
    required this.status,
    required this.tipo,
    required this.valorcompra,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idcliente': idcliente,
      'idcolaborador': idcolaborador,
      'idloja': idloja,
      'data': data,
      'status': status,
      'tipo': tipo,
      'valorcompra': valorcompra,
    };
  }

  factory VendaModel.fromMap(Map<String, dynamic> map) {
    return VendaModel(
      id: map['id'] as int,
      idcliente: map['idcliente'] as int,
      idcolaborador: map['idcolaborador'] as int,
      idloja: map['idloja'] as int,
      data: map['data'] as String,
      status: map['status'] as String,
      tipo: map['tipo'] as String,
      valorcompra: map['valorcompra'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory VendaModel.fromJson(String source) =>
      VendaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
