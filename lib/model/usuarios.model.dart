import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UsuariosModel {
  final int id;
  final int idcolaborador;
  final String nome;
  final String username;
  final String userpassword;
  final String status;
  final int userpermissoes;

  UsuariosModel({
    required this.id,
    required this.idcolaborador,
    required this.nome,
    required this.username,
    required this.userpassword,
    required this.status,
    required this.userpermissoes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idcolaborador': idcolaborador,
      'nome': nome,
      'username': username,
      'userpassword': userpassword,
      'status': status,
      'userpermissoes': userpermissoes,
    };
  }

  factory UsuariosModel.fromMap(Map<String, dynamic> map) {
    return UsuariosModel(
      id: map['id'] as int,
      idcolaborador: map['idcolaborador'] as int,
      nome: map['nome'] as String,
      username: map['username'] as String,
      userpassword: map['userpassword'] ?? '',
      status: map['status'] as String,
      userpermissoes: map['userpermissoes'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuariosModel.fromJson(String source) =>
      UsuariosModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
