import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginModel {
  final int id;
  final int idcolaborador;
  final String username;
  final String userpassword;
  final int userpermissoes;
  final String status;
  final String nome;
  LoginModel({
    required this.id,
    required this.idcolaborador,
    required this.username,
    required this.userpassword,
    required this.userpermissoes,
    required this.status,
    required this.nome,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idcolaborador': idcolaborador,
      'username': username,
      'userpassword': userpassword,
      'userpermissoes': userpermissoes,
      'status': status,
      'nome': nome,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      id: map['id'] as int,
      idcolaborador: map['idcolaborador'] as int,
      username: map['username'] as String,
      userpassword: map['userpassword'] as String,
      userpermissoes: map['userpermissoes'] as int,
      status: map['status'] as String,
      nome: map['nome'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
