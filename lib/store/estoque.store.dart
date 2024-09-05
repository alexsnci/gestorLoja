// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/estoque.model.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';

class EstoqueStore {
  final IEstoque repository;
  EstoqueStore({
    required this.repository,
  });
  final ValueNotifier<List<EstoqueModel>> state =
      ValueNotifier<List<EstoqueModel>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String> erro = ValueNotifier<String>('');
  final ValueNotifier<String> post = ValueNotifier<String>('');
  final ValueNotifier<String> atualiza = ValueNotifier<String>('');

  Future getEstoque({required String nome}) async {
    isLoading.value = true;
    try {
      final result = await repository.getEstoque(valor: nome);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future postEstoque({required List<EstoqueModel> dados}) async {
    isLoading.value = true;
    try {
      final result = await repository.postEstoque(dados: dados);
      post.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future getEstoquePorCategoria({required int id}) async {
    isLoading.value = true;
    try {
      final result = await repository.getEstoquePorCategoria(id: id);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future getEstoqueProduto({required String valor}) async {
    isLoading.value = true;
    try {
      final result = await repository.getEstoqueProduto(valor: valor);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future atualizaEstoque(
      {required int idproduto, required double quantidade}) async {
    isLoading.value = true;
    try {
      final result = await repository.atualizaEstoque(
          idproduto: idproduto, quantidade: quantidade, iduser: idUser);
      atualiza.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
