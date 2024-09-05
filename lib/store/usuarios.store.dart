import 'package:flutter/material.dart';
import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';
import 'package:gestorloja/model/usuarios.model.dart';

class UsuariosStore {
  final IUsuarios repository;
  UsuariosStore({
    required this.repository,
  });
  final ValueNotifier<List<UsuariosModel>> state =
      ValueNotifier<List<UsuariosModel>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String> erro = ValueNotifier<String>('');
  final ValueNotifier<String> post = ValueNotifier<String>('');

  Future getUsuarios({required String nome}) async {
    isLoading.value = true;
    try {
      final result = await repository.getUsuarios(nome: nome);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future postUsuario({required List<UsuariosModel> dados}) async {
    isLoading.value = true;
    try {
      final result = await repository.postUsuario(dados: dados);
      post.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
