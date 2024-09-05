// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gestorloja/model/setores.model.dart';

class CardSetor extends StatelessWidget {
  final SetoresModel setor;
  const CardSetor({
    super.key,
    required this.setor,
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
                child: Text(setor.id.toString().padLeft(4, '0')),
              ),
            ),
            SizedBox(
              width: 250,
              child: Text(setor.descricao),
            ),
          ],
        ),
      ),
    );
  }
}
