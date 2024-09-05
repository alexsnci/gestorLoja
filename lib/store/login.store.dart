// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/http/exceptions.custon.dart';
import 'package:gestorloja/model/login.model.dart';

class LoginStore {
  final ILogin repository;
  LoginStore({
    required this.repository,
  });
  final ValueNotifier<List<LoginModel>> state =
      ValueNotifier<List<LoginModel>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String> erro = ValueNotifier<String>('');
  final ValueNotifier<String> post = ValueNotifier<String>('');

  Future getLogin({required String user, required String password}) async {
    isLoading.value = true;
    try {
      final result = await repository.getLogin(user: user, password: password);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future postLogin({required List<LoginModel> dados}) async {
    isLoading.value = true;
    try {
      final result = await repository.postLogin(dados: dados);
      post.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.toString();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
