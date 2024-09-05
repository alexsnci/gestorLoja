// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';
import 'package:gestorloja/model/venda.model.dart';

class VendaStore {
  final IVenda repository;
  VendaStore({
    required this.repository,
  });
  final ValueNotifier<List<VendaModel>> state =
      ValueNotifier<List<VendaModel>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String> erro = ValueNotifier<String>('');
  final ValueNotifier<String> post = ValueNotifier<String>('');
  final ValueNotifier<String> status = ValueNotifier<String>('');
  final ValueNotifier<String> finalizar = ValueNotifier<String>('');

  Future getVenda({required int id}) async {
    isLoading.value = true;
    try {
      final result = await repository.getVenda(idvenda: id);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future postVenda({required List<VendaModel> dados}) async {
    isLoading.value = true;
    try {
      final result = await repository.postVenda(dados: dados);
      post.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future statusVenda({required int idcolaborador}) async {
    isLoading.value = true;
    try {
      final result = await repository.statusVenda(idcolaborador: idcolaborador);
      status.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future cancelarVenda({required int idvenda}) async {
    isLoading.value = true;
    try {
      final result = await repository.cancelarVenda(idvenda: idvenda);
      post.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future finalizarpedido({required int idvenda}) async {
    isLoading.value = true;
    try {
      final result = await repository.finalizarvenda(idvenda: idvenda);
      finalizar.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future passarcliente({required int idvenda, required String nome}) async {
    isLoading.value = true;
    try {
      final result =
          await repository.passarcliente(idvenda: idvenda, nome: nome);
      finalizar.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future passartipo({required int idvenda, required String tipo}) async {
    isLoading.value = true;
    try {
      final result = await repository.passartipo(idvenda: idvenda, tipo: tipo);
      finalizar.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
