// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gestorloja/model/fornecedores.model.dart';

class CardFornecedores extends StatelessWidget {
  final FornecedoresModel fornecedor;
  const CardFornecedores({
    super.key,
    required this.fornecedor,
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
                child: Text(fornecedor.id.toString().padLeft(4, '0')),
              ),
            ),
            SizedBox(
              width: 250,
              child: Text(fornecedor.razaosocial),
            ),
            SizedBox(
              width: 150,
              child: Text(fornecedor.cnpj),
            ),
            SizedBox(
              width: 150,
              child: Text(fornecedor.contato),
            ),
            SizedBox(
              width: 250,
              child: Text(fornecedor.vendedor),
            ),
            SizedBox(
              width: 150,
              child: Text(fornecedor.contatovendedor),
            ),
            SizedBox(
              width: 80,
              child: Text(fornecedor.status),
            ),
          ],
        ),
      ),
    );
  }
}
