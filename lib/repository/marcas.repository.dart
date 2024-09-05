import 'dart:convert';

import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';
import 'package:gestorloja/model/marcas.model.dart';

class ProdutosRepository implements IProdutos {
  final IHttpClient client;
  final String url;
  ProdutosRepository({
    required this.client,
    required this.url,
  });

  @override
  Future<List<MarcasModel>> getProdutos({required String valor}) async {
    final response = await client.get(url: url, endpoint: 'Marcas?nome=$valor');

    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        final List<MarcasModel> lEleitores = [];

        final body = jsonDecode(response.body);
        body.map((item) {
          final MarcasModel eleitor = MarcasModel.fromMap(item);
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
  Future<String> postProdutos({required List<MarcasModel> dados}) async {
    late List<Map<String, dynamic>> itens = [];
    if (dados.isNotEmpty) {
      for (MarcasModel item in dados) {
        itens.add(item.toMap());
      }
    }

    String data = json.encode(itens);

    final response = await client.post(
      url: url,
      data: data,
      endpoint: 'Marcas',
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
}
