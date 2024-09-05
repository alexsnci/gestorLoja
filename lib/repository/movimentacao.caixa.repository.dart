import 'dart:convert';

import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';
import 'package:gestorloja/model/movimentacao.caixa.model.dart';

class Movimentacaocaixarepository implements IMovimentacaoCaixa {
  final IHttpClient client;
  final String url;
  Movimentacaocaixarepository({
    required this.client,
    required this.url,
  });

  @override
  Future<List<MovimentacaoCaixaModel>> getMovimentacao(
      {required int idcaixa}) async {
    final response =
        await client.get(url: url, endpoint: 'Movimentacaocaixa?id=$idcaixa');

    if (response.statusCode == 200) {
      if (response.body.contains('Erro ao execultar consulta')) {
        return response.body;
      } else {
        final List<MovimentacaoCaixaModel> lEleitores = [];

        final body = jsonDecode(response.body);
        body.map((item) {
          final MovimentacaoCaixaModel eleitor =
              MovimentacaoCaixaModel.fromMap(item);
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
  Future<String> postMovimentacao(
      {required List<MovimentacaoCaixaModel> dados}) async {
    late List<Map<String, dynamic>> itens = [];
    if (dados.isNotEmpty) {
      for (MovimentacaoCaixaModel item in dados) {
        itens.add(item.toMap());
      }
    }

    String data = json.encode(itens);

    final response = await client.post(
      url: url,
      data: data,
      endpoint: 'Movimentacaocaixa',
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
