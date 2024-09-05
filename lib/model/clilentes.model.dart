import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ClientesModel {
  final int id;
  final String nome;
  final String datanascimento;
  final String contato;
  final String logradouro;
  final String numero;
  final String bairro;
  final String cidade;
  final String uf;
  final String email;
  final String status;
  final String cep;
  ClientesModel({
    required this.id,
    required this.nome,
    required this.datanascimento,
    required this.contato,
    required this.logradouro,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.uf,
    required this.email,
    required this.status,
    required this.cep,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'datanascimento': datanascimento,
      'contato': contato,
      'logradouro': logradouro,
      'numero': numero,
      'bairro': bairro,
      'cidade': cidade,
      'uf': uf,
      'email': email,
      'status': status,
      'cep': cep,
    };
  }

  factory ClientesModel.fromMap(Map<String, dynamic> map) {
    return ClientesModel(
      id: map['id'] as int,
      nome: map['nome'] ?? '',
      datanascimento: map['datanascimento'] ?? '',
      contato: map['contato'] ?? '',
      logradouro: map['logradouro'] ?? '',
      numero: map['numero'] ?? '',
      bairro: map['bairro'] ?? '',
      cidade: map['cidade'] ?? '',
      uf: map['uf'] ?? '',
      email: map['email'] ?? '',
      status: map['status'] ?? '',
      cep: map['cep'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientesModel.fromJson(String source) =>
      ClientesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
