// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gestorloja/model/categorias.model.dart';

class CardCategorias extends StatelessWidget {
  final CategoriasModel categoria;
  const CardCategorias({
    super.key,
    required this.categoria,
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
                child: Text(categoria.id.toString().padLeft(4, '0')),
              ),
            ),
            SizedBox(
              width: 250,
              child: Text(categoria.descricao),
            ),
            SizedBox(
              width: 150,
              child: Text(categoria.status),
            ),
          ],
        ),
      ),
    );
  }
}
