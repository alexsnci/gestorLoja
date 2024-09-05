// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/cep.model.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';

class CepRepository implements ICepRepository {
  final IHttpClient client;
  final String cep;
  const CepRepository({
    required this.client,
    required this.cep,
  });
  @override
  Future<List<CepModel>> getCep() async {
    final response = await client.get(
      url: 'https://viacep.com.br/ws/',
      endpoint: '$cep/json/',
    );
    if (response.statusCode == 200) {
      final List<CepModel> lcep = [];

      final body = jsonDecode(response.body);
      lcep.add(
        CepModel(
          cep: (body["cep"] ?? '') as String,
          logradouro: (body["logradouro"] ?? '') as String,
          complemento: (body["complemento"] ?? '') as String,
          localidade: (body["localidade"] ?? '') as String,
          bairro: (body["bairro"] ?? '') as String,
          uf: (body["uf"] ?? '') as String,
          ibge: (body["ibge"] ?? '') as String,
          gia: (body["gia"] ?? '') as String,
          ddd: (body["ddd"] ?? '') as String,
          siafi: (body["siafi"] ?? '') as String,
        ),
      );

      return lcep;
    } else if (response.statusCode == 404) {
      throw NotFoundException('URL informada não encontrada!');
    } else {
      throw Exception('Não foi possivel carregar os dados do servidor!');
    }
  }
}
