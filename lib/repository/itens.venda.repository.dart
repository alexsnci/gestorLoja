import 'dart:convert';

import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';
import 'package:gestorloja/model/itens.venda.model.dart';

class ItensVendaRepository implements IItensVenda {
  final IHttpClient client;
  final String url;
  ItensVendaRepository({
    required this.client,
    required this.url,
  });

  @override
  Future<List<ItensVendaModel>> getItensVenda({required int idvenda}) async {
    final response =
        await client.get(url: url, endpoint: 'Itensvenda?pedido=$idvenda');

    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        final List<ItensVendaModel> lEleitores = [];

        final body = jsonDecode(response.body);
        body.map((item) {
          final ItensVendaModel eleitor = ItensVendaModel.fromMap(item);
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
  Future<String> postItemVenda({required List<ItensVendaModel> dados}) async {
    late List<Map<String, dynamic>> itens = [];
    if (dados.isNotEmpty) {
      for (ItensVendaModel item in dados) {
        itens.add(item.toMap());
      }
    }

    String data = json.encode(itens);

    final response = await client.post(
      url: url,
      data: data,
      endpoint: 'Itensvenda',
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
  Future<String> adicionaritem(
      {required int idproduto, required int idvenda}) async {
    final response = await client.post(
      url: url,
      data: '',
      endpoint: 'Adicionaritemvenda?idproduto=$idproduto&idvenda=$idvenda',
    );
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 404) {
      throw NotFoundException('URL não encontrada!');
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<String> removeritem(
      {required int idproduto, required int idvenda}) async {
    final response = await client.post(
      url: url,
      data: '',
      endpoint: 'Apagaritemvenda?idproduto=$idproduto&idvenda=$idvenda',
    );
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 404) {
      throw NotFoundException('URL não encontrada!');
    } else {
      throw Exception(response.body);
    }
  }
}
