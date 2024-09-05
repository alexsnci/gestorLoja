import 'dart:convert';

import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/categorias.model.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';

class CategoriasRepository implements ICategorias {
  final IHttpClient client;
  final String url;
  CategoriasRepository({
    required this.client,
    required this.url,
  });

  @override
  Future<List<CategoriasModel>> getCategorias({required String valor}) async {
    final response =
        await client.get(url: url, endpoint: 'Categorias?nome=$valor');

    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        final List<CategoriasModel> lEleitores = [];

        final body = jsonDecode(response.body);
        body.map((item) {
          final CategoriasModel eleitor = CategoriasModel.fromMap(item);
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
  Future<String> postCategorias({required List<CategoriasModel> dados}) async {
    late List<Map<String, dynamic>> itens = [];
    if (dados.isNotEmpty) {
      for (CategoriasModel item in dados) {
        itens.add(item.toMap());
      }
    }

    String data = json.encode(itens);

    final response = await client.post(
      url: url,
      data: data,
      endpoint: 'Categorias',
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
