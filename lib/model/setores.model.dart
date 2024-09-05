// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SetoresModel {
  final int id;
  final String descricao;

  SetoresModel({required this.id, required this.descricao});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'descricao': descricao,
    };
  }

  factory SetoresModel.fromMap(Map<String, dynamic> map) {
    return SetoresModel(
      id: map['id'] as int,
      descricao: map['descricao'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SetoresModel.fromJson(String source) =>
      SetoresModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
