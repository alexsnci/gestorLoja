// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/fornecedores.model.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';

class FornecedoresStore {
  final IFornecedores repository;
  FornecedoresStore({
    required this.repository,
  });
  final ValueNotifier<List<FornecedoresModel>> state =
      ValueNotifier<List<FornecedoresModel>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String> erro = ValueNotifier<String>('');
  final ValueNotifier<String> post = ValueNotifier<String>('');

  Future getFornecedores({required String nome}) async {
    isLoading.value = true;
    try {
      final result = await repository.getFornecedores(valor: nome);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future postFornecedores({required List<FornecedoresModel> dados}) async {
    isLoading.value = true;
    try {
      final result = await repository.postFornecedor(dados: dados);
      post.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
