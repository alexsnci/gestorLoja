// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';
import 'package:gestorloja/model/usuarios.model.dart';

class UsuariosRepository implements IUsuarios {
  final IHttpClient client;
  final String url;
  UsuariosRepository({
    required this.client,
    required this.url,
  });

  @override
  Future<List<UsuariosModel>> getUsuarios({required String nome}) async {
    final response =
        await client.get(url: url, endpoint: 'Usuarios?nome=$nome');
    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        final List<UsuariosModel> lEleitores = [];

        final body = jsonDecode(response.body);
        body.map((item) {
          final UsuariosModel eleitor = UsuariosModel.fromMap(item);
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
  Future<String> postUsuario({required List<UsuariosModel> dados}) async {
    late List<Map<String, dynamic>> itens = [];
    if (dados.isNotEmpty) {
      for (UsuariosModel item in dados) {
        itens.add(item.toMap());
      }
    }

    String data = json.encode(itens);

    final response = await client.post(
      url: url,
      data: data,
      endpoint: 'Usuarios',
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
