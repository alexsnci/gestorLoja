// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/categorias.model.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';

class CategoriasStore {
  final ICategorias repository;
  CategoriasStore({
    required this.repository,
  });
  final ValueNotifier<List<CategoriasModel>> state =
      ValueNotifier<List<CategoriasModel>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String> erro = ValueNotifier<String>('');
  final ValueNotifier<String> post = ValueNotifier<String>('');

  Future getCategorias({required String nome}) async {
    isLoading.value = true;
    try {
      final result = await repository.getCategorias(valor: nome);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future postCategorias({required List<CategoriasModel> dados}) async {
    isLoading.value = true;
    try {
      final result = await repository.postCategorias(dados: dados);
      post.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
