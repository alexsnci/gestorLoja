import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PagamentosPedidosModel {
  final int id;
  final int idpedido;
  final int idcaixa;
  final String formapagamento;
  final String data;
  final double valor;
  final double totalpago;
  PagamentosPedidosModel({
    required this.id,
    required this.idpedido,
    required this.idcaixa,
    required this.formapagamento,
    required this.data,
    required this.valor,
    required this.totalpago,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idpedido': idpedido,
      'idcaixa': idcaixa,
      'formapagamento': formapagamento,
      'data': data,
      'valor': valor,
      'totalpago': totalpago,
    };
  }

  factory PagamentosPedidosModel.fromMap(Map<String, dynamic> map) {
    return PagamentosPedidosModel(
      id: map['id'] ?? 0,
      idpedido: map['idpedido'] ?? 0,
      idcaixa: map['idcaixa'] ?? 0,
      formapagamento: map['formapagamento'] ?? '',
      data: map['data'] ?? '',
      valor: map['valor'] ?? 0.0,
      totalpago: map['totalpago'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PagamentosPedidosModel.fromJson(String source) =>
      PagamentosPedidosModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
