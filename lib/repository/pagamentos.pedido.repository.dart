import 'dart:convert';

import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';
import 'package:gestorloja/model/pagamentos.pedidos.model.dart';

class PagamentosPedidosRepository implements IPagamentosPedido {
  final IHttpClient client;
  final String url;
  PagamentosPedidosRepository({
    required this.client,
    required this.url,
  });

  @override
  Future<List<PagamentosPedidosModel>> getPagamentos(
      {required int idvenda}) async {
    final response = await client.get(
        url: url, endpoint: 'PagamentosPedido?idvenda=$idvenda');

    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        final List<PagamentosPedidosModel> lEleitores = [];

        final body = jsonDecode(response.body);
        body.map((item) {
          final PagamentosPedidosModel eleitor =
              PagamentosPedidosModel.fromMap(item);
          lEleitores.add(eleitor);
        }).toList();

        return lEleitores;
      }
    } else if (response.statusCode == 404) {
      throw NotFoundException('URL não encontrada!');
    } else {
      throw Exception('Não foi possível carregar os dados do servidor!');
    }
  }

  @override
  Future<String> postPagamentos(
      {required List<PagamentosPedidosModel> dados}) async {
    late List<Map<String, dynamic>> itens = [];
    if (dados.isNotEmpty) {
      for (PagamentosPedidosModel item in dados) {
        itens.add(item.toMap());
      }
    }

    String data = json.encode(itens);

    final response = await client.post(
      url: url,
      data: data,
      endpoint: 'PagamentosPedido',
    );

    if (response.statusCode == 200) {
      if (int.tryParse(response.body) != null) {
        return 'Registro inserido com sucesso!';
      } else {
        return response.body;
      }
    } else if (response.statusCode == 404) {
      throw NotFoundException('URL não encontrada!');
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<String> deletePagamento({required int id}) async {
    final response =
        await client.get(url: url, endpoint: 'Apagarpagamento?id=$id');
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 404) {
      throw NotFoundException('URL não encontrada!');
    } else {
      throw Exception('Não foi possível carregar os dados do servidor!');
    }
  }
}
