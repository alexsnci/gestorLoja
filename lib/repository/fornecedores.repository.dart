// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/fornecedores.model.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';

class FornecedoresRepository implements IFornecedores {
  final IHttpClient client;
  final String url;
  FornecedoresRepository({
    required this.client,
    required this.url,
  });

  @override
  Future<List<FornecedoresModel>> getFornecedores(
      {required String valor}) async {
    final response =
        await client.get(url: url, endpoint: 'Fornecedores?nome=$valor');

    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        final List<FornecedoresModel> lEleitores = [];

        final body = jsonDecode(response.body);
        body.map((item) {
          final FornecedoresModel eleitor = FornecedoresModel.fromMap(item);
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
  Future<String> postFornecedor(
      {required List<FornecedoresModel> dados}) async {
    late List<Map<String, dynamic>> itens = [];
    if (dados.isNotEmpty) {
      for (FornecedoresModel item in dados) {
        itens.add(item.toMap());
      }
    }

    String data = json.encode(itens);

    final response = await client.post(
      url: url,
      data: data,
      endpoint: 'Fornecedores',
    );

    if (response.statusCode == 200) {
      if (int.tryParse(response.body) != null) {
        idFornecedorRetorno = int.parse(response.body);
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
}
