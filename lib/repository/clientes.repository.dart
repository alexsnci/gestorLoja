// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/clilentes.model.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';

class ClientesRepository implements IClientes {
  final IHttpClient client;
  final String url;
  ClientesRepository({
    required this.client,
    required this.url,
  });

  @override
  Future<List<ClientesModel>> getClientes({required String valor}) async {
    final response =
        await client.get(url: url, endpoint: 'clientes?nome=$valor');

    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        final List<ClientesModel> lEleitores = [];

        final body = jsonDecode(response.body);
        body.map((item) {
          final ClientesModel eleitor = ClientesModel.fromMap(item);
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
  Future<String> postCliente({required List<ClientesModel> dados}) async {
    late List<Map<String, dynamic>> itens = [];
    if (dados.isNotEmpty) {
      for (ClientesModel item in dados) {
        itens.add(item.toMap());
      }
    }

    String data = json.encode(itens);

    final response = await client.post(
      url: url,
      data: data,
      endpoint: 'clientes',
    );

    if (response.statusCode == 200) {
      if (int.tryParse(response.body) != null) {
        idClienteRetorno = int.parse(response.body);
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
