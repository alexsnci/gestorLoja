import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EstoqueModel {
  final int id;
  final int idmarca;
  final int idfornecedor;
  final int idcategoria;
  final String produto;
  final String fornecedor;
  final double valoraquisicao;
  final double margemlucro;
  final double valorvenda;
  final double quantidadeatual;
  final double quantidademinima;
  final String categoria;
  final String modelo;
  final String cor;
  final String tamanho;
  final String setor;
  final String codigobarras;
  final String descricao;
  final int idusuario;

  EstoqueModel({
    required this.id,
    required this.idmarca,
    required this.idfornecedor,
    required this.idcategoria,
    required this.produto,
    required this.fornecedor,
    required this.valoraquisicao,
    required this.margemlucro,
    required this.valorvenda,
    required this.quantidadeatual,
    required this.quantidademinima,
    required this.categoria,
    required this.modelo,
    required this.cor,
    required this.tamanho,
    required this.setor,
    required this.codigobarras,
    required this.descricao,
    required this.idusuario,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idmarca': idmarca,
      'idfornecedor': idfornecedor,
      'idcategoria': idcategoria,
      'produto': produto,
      'fornecedor': fornecedor,
      'valoraquisicao': valoraquisicao,
      'margemlucro': margemlucro,
      'valorvenda': valorvenda,
      'quantidadeatual': quantidadeatual,
      'quantidademinima': quantidademinima,
      'categoria': categoria,
      'modelo': modelo,
      'cor': cor,
      'tamanho': tamanho,
      'setor': setor,
      'codigobarras': codigobarras,
      'descricao': descricao,
      'idusuario': idusuario,
    };
  }

  factory EstoqueModel.fromMap(Map<String, dynamic> map) {
    return EstoqueModel(
      id: map['id'] ?? 0,
      idmarca: map['idproduto'] ?? 0,
      idfornecedor: map['idfornecedor'] ?? 0,
      idcategoria: map['idcategoria'] ?? 0,
      produto: map['produto'] ?? '',
      fornecedor: map['fornecedor'] ?? '',
      valoraquisicao: map['valoraquisicao'] as double,
      margemlucro: map['margemlucro'] as double,
      valorvenda: map['valorvenda'] as double,
      quantidadeatual: map['quantidadeatual'] as double,
      quantidademinima: map['quantidademinima'] as double,
      categoria: map['categoria'] ?? '',
      modelo: map['modelo'] ?? '',
      cor: map['cor'] ?? '',
      tamanho: map['tamanho'] ?? '',
      setor: map['setor'] ?? '',
      codigobarras: map['codigobarras'] ?? '',
      descricao: map['descricao'] ?? '',
      idusuario: map['idusuario'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory EstoqueModel.fromJson(String source) =>
      EstoqueModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
