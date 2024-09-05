import 'dart:io';

import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:http/http.dart' as http;

class HttpClient implements IHttpClient {
  final client = http.Client();

  @override
  Future get({required String url, required String endpoint}) async {
    try {
      return await client.get(
        Uri.parse('$url$endpoint'),
        headers: _cabecalho(),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future post(
      {required String url,
      required String data,
      required String endpoint}) async {
    return await client.post(
      Uri.parse('$url$endpoint'),
      body: data,
      headers: _cabecalho(),
    );
  }

  _cabecalho() => {HttpHeaders.authorizationHeader: 'Bearer $token'};

  @override
  Future delete({required String url, required String endpoint}) async {
    try {
      return await client.delete(
        Uri.parse('$url$endpoint'),
        headers: _cabecalho(),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future put(
      {required String url,
      required String data,
      required String endpoint}) async {
    return await client.post(
      Uri.parse('$url$endpoint'),
      body: data,
      headers: _cabecalho(),
    );
  }

  @override
  Future upload({required url, required String endpoint, required img}) async {
    return await client.post(
      body: img,
      Uri.parse('$url$endpoint'),
      headers: _cabecalho(),
    );
  }
}
