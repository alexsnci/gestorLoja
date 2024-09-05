// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:gestorloja/model/clilentes.model.dart';

class CardClientes extends StatelessWidget {
  final ClientesModel cliente;
  const CardClientes({
    super.key,
    required this.cliente,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15, top: 15),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 80,
                child: Text(cliente.id.toString().padLeft(4, '0')),
              ),
            ),
            SizedBox(
              width: 250,
              child: Text(cliente.nome),
            ),
            SizedBox(
              width: 150,
              child: Text(cliente.contato),
            ),
            SizedBox(
              width: 200,
              child: Text(cliente.logradouro),
            ),
            SizedBox(
              width: 200,
              child: Text(cliente.bairro),
            ),
            SizedBox(
              width: 100,
              child: Text(cliente.cidade),
            ),
            SizedBox(
              width: 50,
              child: Text(cliente.uf),
            ),
            SizedBox(
              width: 80,
              child: Text(cliente.status),
            ),
          ],
        ),
      ),
    );
  }
}
