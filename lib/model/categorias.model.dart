import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoriasModel {
  final int id;
  final String descricao;
  final String status;
  CategoriasModel({
    required this.id,
    required this.descricao,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'descricao': descricao,
      'status': status,
    };
  }

  factory CategoriasModel.fromMap(Map<String, dynamic> map) {
    return CategoriasModel(
      id: map['id'] as int,
      descricao: map['descricao'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriasModel.fromJson(String source) =>
      CategoriasModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
