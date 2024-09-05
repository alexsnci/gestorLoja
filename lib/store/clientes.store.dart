// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/clilentes.model.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';

class ClientesStore {
  final IClientes repository;
  ClientesStore({
    required this.repository,
  });
  final ValueNotifier<List<ClientesModel>> state =
      ValueNotifier<List<ClientesModel>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String> erro = ValueNotifier<String>('');
  final ValueNotifier<String> post = ValueNotifier<String>('');

  Future getClientes({required String nome}) async {
    isLoading.value = true;
    try {
      final result = await repository.getClientes(valor: nome);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future postClientes({required List<ClientesModel> dados}) async {
    isLoading.value = true;
    try {
      final result = await repository.postCliente(dados: dados);
      post.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
