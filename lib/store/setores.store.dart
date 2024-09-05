// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';
import 'package:gestorloja/model/setores.model.dart';

class SetoresStore {
  final ISetores repository;
  SetoresStore({
    required this.repository,
  });
  final ValueNotifier<List<SetoresModel>> state =
      ValueNotifier<List<SetoresModel>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String> erro = ValueNotifier<String>('');
  final ValueNotifier<String> post = ValueNotifier<String>('');

  Future getSetores({required String nome}) async {
    isLoading.value = true;
    try {
      final result = await repository.getSetores(valor: nome);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future postSetor({required List<SetoresModel> dados}) async {
    isLoading.value = true;
    try {
      final result = await repository.postSetor(dados: dados);
      post.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
