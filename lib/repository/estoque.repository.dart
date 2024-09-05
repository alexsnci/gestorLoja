import 'dart:convert';

import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/estoque.model.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';

class EstoqueRepository implements IEstoque {
  final IHttpClient client;
  final String url;
  EstoqueRepository({
    required this.client,
    required this.url,
  });

  @override
  Future<List<EstoqueModel>> getEstoque({required String valor}) async {
    final response =
        await client.get(url: url, endpoint: 'Estoque?nome=$valor');

    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        final List<EstoqueModel> lEleitores = [];

        final body = jsonDecode(response.body);
        body.map((item) {
          final EstoqueModel eleitor = EstoqueModel.fromMap(item);
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
  Future<String> postEstoque({required List<EstoqueModel> dados}) async {
    late List<Map<String, dynamic>> itens = [];
    if (dados.isNotEmpty) {
      for (EstoqueModel item in dados) {
        itens.add(item.toMap());
      }
    }

    String data = json.encode(itens);

    final response = await client.post(
      url: url,
      data: data,
      endpoint: 'Estoque',
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
  Future<List<EstoqueModel>> getEstoquePorCategoria({required int id}) async {
    final response =
        await client.get(url: url, endpoint: 'Estoqueporcategoria?id=$id');

    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        final List<EstoqueModel> lEleitores = [];

        final body = jsonDecode(response.body);
        body.map((item) {
          final EstoqueModel eleitor = EstoqueModel.fromMap(item);
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
  Future<List<EstoqueModel>> getEstoqueProduto({required String valor}) async {
    final response =
        await client.get(url: url, endpoint: 'Estoqueproduto?valor=$valor');

    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        final List<EstoqueModel> lEleitores = [];

        final body = jsonDecode(response.body);
        body.map((item) {
          final EstoqueModel eleitor = EstoqueModel.fromMap(item);
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
  Future<String> atualizaEstoque(
      {required int idproduto,
      required double quantidade,
      required int iduser}) async {
    final response = await client.get(
        url: url,
        endpoint:
            'AtualizaEstoque?id=$idproduto&qtd=$quantidade&iduser=$iduser');

    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 404) {
      throw NotFoundException('URL não encontrada!');
    } else {
      throw Exception('Não foi possível carregar os dados do servidor!');
    }
  }
}
