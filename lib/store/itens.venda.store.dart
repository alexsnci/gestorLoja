// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';
import 'package:gestorloja/model/itens.venda.model.dart';

class ItensVendaStore {
  final IItensVenda repository;
  ItensVendaStore({
    required this.repository,
  });
  final ValueNotifier<List<ItensVendaModel>> state =
      ValueNotifier<List<ItensVendaModel>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String> erro = ValueNotifier<String>('');
  final ValueNotifier<String> post = ValueNotifier<String>('');
  final ValueNotifier<String> remover = ValueNotifier<String>('');
  final ValueNotifier<String> adicionar = ValueNotifier<String>('');

  Future getItensVenda({required int id}) async {
    isLoading.value = true;
    try {
      final result = await repository.getItensVenda(idvenda: id);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future postItensVenda({required List<ItensVendaModel> dados}) async {
    isLoading.value = true;
    try {
      final result = await repository.postItemVenda(dados: dados);
      post.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future adicionaritem({required int idproduto, required int idvenda}) async {
    isLoading.value = true;
    try {
      final result = await repository.adicionaritem(
          idproduto: idproduto, idvenda: idvenda);
      adicionar.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future removeritem({required int idproduto, required int idvenda}) async {
    isLoading.value = true;
    try {
      final result =
          await repository.removeritem(idproduto: idproduto, idvenda: idvenda);
      remover.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
