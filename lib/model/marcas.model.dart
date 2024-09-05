import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MarcasModel {
  final int id;
  final String descricao;
  final String status;

  MarcasModel({
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

  factory MarcasModel.fromMap(Map<String, dynamic> map) {
    return MarcasModel(
      id: map['id'] as int,
      descricao: map['descricao'] as String,
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MarcasModel.fromJson(String source) =>
      MarcasModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
