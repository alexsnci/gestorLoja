// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/caixa.model.dart';
import 'package:gestorloja/model/fechamento.caixa.model.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';

class CaixaStore {
  final ICaixas repository;
  CaixaStore({
    required this.repository,
  });
  final ValueNotifier<List<CaixaModel>> state =
      ValueNotifier<List<CaixaModel>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String> erro = ValueNotifier<String>('');
  final ValueNotifier<String> post = ValueNotifier<String>('');
  final ValueNotifier<String> status = ValueNotifier<String>('');
  final ValueNotifier<String> fecharcaixa = ValueNotifier<String>('');
  final ValueNotifier<List<FechamentoCaixaModel>> stateRelatorio =
      ValueNotifier<List<FechamentoCaixaModel>>([]);

  Future getCaixa({required int id}) async {
    isLoading.value = true;
    try {
      final result = await repository.getCaixa(idcaixa: id);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future postCaixa({required List<CaixaModel> dados}) async {
    isLoading.value = true;
    try {
      final result = await repository.postCaixa(dados: dados);
      post.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future statuscaixa() async {
    isLoading.value = true;
    try {
      final result = await repository.statusCaixa();
      status.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future postFecharCaixa({required List<FechamentoCaixaModel> dados}) async {
    isLoading.value = true;
    try {
      final result = await repository.postFecharCaixa(dados: dados);
      fecharcaixa.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future getRelatorioCaixa({required int idcaixa}) async {
    isLoading.value = true;
    try {
      final result = await repository.getRelatorioCaixa(idcaixa: idcaixa);
      stateRelatorio.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
