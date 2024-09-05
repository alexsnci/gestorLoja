import 'dart:convert';

import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/caixa.model.dart';
import 'package:gestorloja/model/fechamento.caixa.model.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';

class CaixaRepository implements ICaixas {
  final IHttpClient client;
  final String url;
  CaixaRepository({
    required this.client,
    required this.url,
  });

  @override
  Future<List<CaixaModel>> getCaixa({required int idcaixa}) async {
    final response =
        await client.get(url: url, endpoint: 'Caixa?caixa=$idcaixa');

    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        final List<CaixaModel> lEleitores = [];

        final body = jsonDecode(response.body);
        body.map((item) {
          final CaixaModel eleitor = CaixaModel.fromMap(item);
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
  Future<String> postCaixa({required List<CaixaModel> dados}) async {
    late List<Map<String, dynamic>> itens = [];
    if (dados.isNotEmpty) {
      for (CaixaModel item in dados) {
        itens.add(item.toMap());
      }
    }

    String data = json.encode(itens);

    final response = await client.post(
      url: url,
      data: data,
      endpoint: 'Caixa',
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
  Future<String> statusCaixa() async {
    final response = await client.get(
      url: url,
      endpoint: 'statuscaixa',
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
  Future<String> postFecharCaixa(
      {required List<FechamentoCaixaModel> dados}) async {
    late List<Map<String, dynamic>> itens = [];
    if (dados.isNotEmpty) {
      for (FechamentoCaixaModel item in dados) {
        itens.add(item.toMap());
      }
    }

    String data = json.encode(itens);

    final response = await client.post(
      url: url,
      data: data,
      endpoint: 'Fecharcaixa',
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
  Future<List<FechamentoCaixaModel>> getRelatorioCaixa({required int idcaixa}) async {
    final response =
        await client.get(url: url, endpoint: 'RelatorioCaixa?id=$idcaixa');

    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        final List<FechamentoCaixaModel> lEleitores = [];

        final body = jsonDecode(response.body);
        body.map((item) {
          final FechamentoCaixaModel eleitor = FechamentoCaixaModel.fromMap(item);
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
}
