import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FechamentoCaixaModel {
  final int id;
  final int idcaixa;
  final String datafechamento;
  final double valoravistainformado;
  final double valoravistaregistrado;
  final double valorcartaocreditoinformado;
  final double valorcartaocreditoregistrado;
  final double valorcartaodebitoinformado;
  final double valorcartaodebitoregistrado;
  final double valorpixinformado;
  final double valorpixregistrado;
  FechamentoCaixaModel({
    required this.id,
    required this.idcaixa,
    required this.datafechamento,
    required this.valoravistainformado,
    required this.valoravistaregistrado,
    required this.valorcartaocreditoinformado,
    required this.valorcartaocreditoregistrado,
    required this.valorcartaodebitoinformado,
    required this.valorcartaodebitoregistrado,
    required this.valorpixinformado,
    required this.valorpixregistrado,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idcaixa': idcaixa,
      'datafechamento': datafechamento,
      'valoravistainformado': valoravistainformado,
      'valoravistaregistrado': valoravistaregistrado,
      'valorcartaocreditoinformado': valorcartaocreditoinformado,
      'valorcartaocreditoregistrado': valorcartaocreditoregistrado,
      'valorcartaodebitoinformado': valorcartaodebitoinformado,
      'valorcartaodebitoregistrado': valorcartaodebitoregistrado,
      'valorpixinformado': valorpixinformado,
      'valorpixregistrado': valorpixregistrado,
    };
  }

  factory FechamentoCaixaModel.fromMap(Map<String, dynamic> map) {
    return FechamentoCaixaModel(
      id: map['id'] as int,
      idcaixa: map['idcaixa'] ?? 0,
      datafechamento: map['datafechamento'] as String,
      valoravistainformado: map['valoravistainformado'] ?? 0.0,
      valoravistaregistrado: map['valoravistaregistrado'] ?? 0.0,
      valorcartaocreditoinformado: map['valorcartaocreditoinformado'] ?? 0.0,
      valorcartaocreditoregistrado: map['valorcartaocreditoregistrado'] ?? 0.0,
      valorcartaodebitoinformado: map['valorcartaodebitoinformado'] ?? 0.0,
      valorcartaodebitoregistrado: map['valorcartaodebitoregistrado'] ?? 0.0,
      valorpixinformado: map['valorpixinformado'] ?? 0.0,
      valorpixregistrado: map['valorpixregistrado'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory FechamentoCaixaModel.fromJson(String source) =>
      FechamentoCaixaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
