// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:gestorloja/model/movimentacao.caixa.model.dart';
import 'package:intl/intl.dart';

class CardMovimentacaoCaixa extends StatelessWidget {
  final MovimentacaoCaixaModel movimentacao;
  final Color cor;
  const CardMovimentacaoCaixa({
    super.key,
    required this.movimentacao,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    var real = NumberFormat.currency(locale: 'pt-BR', symbol: 'R\$');
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
                child: Text(movimentacao.id.toString().padLeft(4, '0')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 100,
                child: Text(movimentacao.data),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 300,
                child: Text(movimentacao.descricao),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 80,
                child: Text(movimentacao.tipo),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 100,
                child: Text(real.format(movimentacao.valor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
