// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';
import 'package:gestorloja/model/marcas.model.dart';

class ProdutosStore {
  final IProdutos repository;
  ProdutosStore({
    required this.repository,
  });
  final ValueNotifier<List<MarcasModel>> state =
      ValueNotifier<List<MarcasModel>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String> erro = ValueNotifier<String>('');
  final ValueNotifier<String> post = ValueNotifier<String>('');

  Future getProdutos({required String nome}) async {
    isLoading.value = true;
    try {
      final result = await repository.getProdutos(valor: nome);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future postProdutos({required List<MarcasModel> dados}) async {
    isLoading.value = true;
    try {
      final result = await repository.postProdutos(dados: dados);
      post.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
