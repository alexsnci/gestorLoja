// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';
import 'package:gestorloja/model/movimentacao.caixa.model.dart';

class MovimentacaoCaixaStore {
  final IMovimentacaoCaixa repository;
  MovimentacaoCaixaStore({
    required this.repository,
  });
  final ValueNotifier<List<MovimentacaoCaixaModel>> state =
      ValueNotifier<List<MovimentacaoCaixaModel>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String> erro = ValueNotifier<String>('');
  final ValueNotifier<String> post = ValueNotifier<String>('');

  Future getMovimentacaoCaixa({required int idcaixa}) async {
    isLoading.value = true;
    try {
      final result = await repository.getMovimentacao(idcaixa: idcaixa);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future postMovimentacaoCaixa(
      {required List<MovimentacaoCaixaModel> dados}) async {
    isLoading.value = true;
    try {
      final result = await repository.postMovimentacao(dados: dados);
      post.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
