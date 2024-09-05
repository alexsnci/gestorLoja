import 'dart:convert';

import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';
import 'package:gestorloja/model/venda.model.dart';

class VendaRepository implements IVenda {
  final IHttpClient client;
  final String url;
  VendaRepository({
    required this.client,
    required this.url,
  });

  @override
  Future<List<VendaModel>> getVenda({required int idvenda}) async {
    final response = await client.get(url: url, endpoint: 'Venda?id=$idvenda');

    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        final List<VendaModel> lEleitores = [];

        final body = jsonDecode(response.body);
        body.map((item) {
          final VendaModel eleitor = VendaModel.fromMap(item);
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
  Future<String> postVenda({required List<VendaModel> dados}) async {
    late List<Map<String, dynamic>> itens = [];
    if (dados.isNotEmpty) {
      for (VendaModel item in dados) {
        itens.add(item.toMap());
      }
    }

    String data = json.encode(itens);

    final response = await client.post(
      url: url,
      data: data,
      endpoint: 'Venda',
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
  Future<String> statusVenda({required int idcolaborador}) async {
    final response = await client.get(
        url: url, endpoint: 'Statusvenda?idcolaborador=$idcolaborador');

    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        return response.body;
      }
    } else if (response.statusCode == 404) {
      throw NotFoundException('URL não encontrada!');
    } else {
      throw Exception('Não foi possível carregar os dados do servidor!');
    }
  }

  @override
  Future<String> cancelarVenda({required int idvenda}) async {
    final response = await client.post(
      url: url,
      endpoint: 'Cancelarvenda?id=$idvenda',
      data: '',
    );

    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        return response.body;
      }
    } else if (response.statusCode == 404) {
      throw NotFoundException('URL não encontrada!');
    } else {
      throw Exception('Não foi possível carregar os dados do servidor!');
    }
  }

  @override
  Future<String> finalizarvenda({required int idvenda}) async {
    final response = await client.get(
      url: url,
      endpoint: 'Finalizarpedido?id=$idvenda',
    );

    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        return response.body;
      }
    } else if (response.statusCode == 404) {
      throw NotFoundException('URL não encontrada!');
    } else {
      throw Exception('Não foi possível carregar os dados do servidor!');
    }
  }

  @override
  Future<String> passarcliente(
      {required int idvenda, required String nome}) async {
    final response = await client.get(
      url: url,
      endpoint: 'vendacliente?idpedido=$idvenda&nome=$nome',
    );

    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        return response.body;
      }
    } else if (response.statusCode == 404) {
      throw NotFoundException('URL não encontrada!');
    } else {
      throw Exception('Não foi possível carregar os dados do servidor!');
    }
  }

  @override
  Future<String> passartipo(
      {required int idvenda, required String tipo}) async {
    final response = await client.get(
      url: url,
      endpoint: 'vendatipo?idpedido=$idvenda&tipo=$tipo',
    );

    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        return response.body;
      }
    } else if (response.statusCode == 404) {
      throw NotFoundException('URL não encontrada!');
    } else {
      throw Exception('Não foi possível carregar os dados do servidor!');
    }
  }
}
