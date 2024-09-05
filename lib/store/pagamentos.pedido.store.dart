// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';
import 'package:gestorloja/model/pagamentos.pedidos.model.dart';

class PagamentosPedidosStore {
  final IPagamentosPedido repository;
  PagamentosPedidosStore({
    required this.repository,
  });
  final ValueNotifier<List<PagamentosPedidosModel>> state =
      ValueNotifier<List<PagamentosPedidosModel>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String> erro = ValueNotifier<String>('');
  final ValueNotifier<String> post = ValueNotifier<String>('');
  final ValueNotifier<String> delete = ValueNotifier<String>('');

  Future getPagamentos({required int idpedido}) async {
    isLoading.value = true;
    try {
      final result = await repository.getPagamentos(idvenda: idpedido);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future postPagamentos({required List<PagamentosPedidosModel> dados}) async {
    isLoading.value = true;
    try {
      final result = await repository.postPagamentos(dados: dados);
      post.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future apagarPagamentos({required int id}) async {
    isLoading.value = true;
    try {
      final result = await repository.deletePagamento(id: id);
      delete.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
