// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:gestorloja/model/marcas.model.dart';

class CardProdutos extends StatelessWidget {
  final MarcasModel produto;
  final Color cor;
  const CardProdutos({
    super.key,
    required this.produto,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15, top: 15),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 80,
                child: Text(produto.id.toString().padLeft(4, '0')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 250,
                child: Text(produto.descricao),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 80,
                child: Text(produto.status),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
