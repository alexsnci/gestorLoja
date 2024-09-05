import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FornecedoresModel {
  final int id;
  final String razaosocial;
  final String cnpj;
  final String contato;
  final String vendedor;
  final String contatovendedor;
  final String status;
  FornecedoresModel({
    required this.id,
    required this.razaosocial,
    required this.cnpj,
    required this.contato,
    required this.vendedor,
    required this.contatovendedor,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'razaosocial': razaosocial,
      'cnpj': cnpj,
      'contato': contato,
      'vendedor': vendedor,
      'contatovendedor': contatovendedor,
      'status': status,
    };
  }

  factory FornecedoresModel.fromMap(Map<String, dynamic> map) {
    return FornecedoresModel(
      id: map['id'] as int,
      razaosocial: map['razaosocial'] as String,
      cnpj: map['cnpj'] as String,
      contato: map['contato'] as String,
      vendedor: map['vendedor'] as String,
      contatovendedor: map['contatovendedor'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FornecedoresModel.fromJson(String source) =>
      FornecedoresModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
