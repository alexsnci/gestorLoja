// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gestorloja/views/movimentacao.caixa.dart';
import 'package:gestorloja/views/relatorio.fechamento.caixa.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:gestorloja/model/caixa.model.dart';

class CardCaixa extends StatelessWidget {
  final CaixaModel caixa;
  final Color cor;
  final void Function()? fecharcaixa;
  const CardCaixa({
    super.key,
    required this.caixa,
    required this.cor,
    this.fecharcaixa,
  });

  @override
  Widget build(BuildContext context) {
    var real = NumberFormat.currency(locale: 'pt-BR', symbol: 'R\$');
    List<PopupMenuEntry<dynamic>> fechado = [
      PopupMenuItem(
        height: 40,
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              child: MovimentacaoCaixa(
                caixa: caixa,
              ),
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 500),
            ),
          );
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.bar_chart_rounded,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Movimentação',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      PopupMenuItem(
        height: 40,
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              child: RelatorioFechamentoCaixa(
                caixa: caixa,
              ),
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 500),
            ),
          );
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.bar_chart_rounded,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Relatório',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ];
    List<PopupMenuEntry<dynamic>> aberto = [
      PopupMenuItem(
        height: 40,
        onTap: fecharcaixa,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.cancel_presentation_rounded,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Fechar Caixa',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      PopupMenuItem(
        height: 40,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              PhosphorIconsRegular.plusSquare,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Lançamento',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        onTap: () {},
      ),
      PopupMenuItem(
        height: 40,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              PhosphorIconsRegular.handWithdraw,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Sangria',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        onTap: () {},
      ),
      PopupMenuItem(
        height: 40,
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              child: MovimentacaoCaixa(
                caixa: caixa,
              ),
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 500),
            ),
          );
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.bar_chart_rounded,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Movimentação',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ];
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
                child: Text(caixa.id.toString().padLeft(4, '0')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 200,
                child: Text(caixa.data),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 150,
                child: Text(real.format(caixa.valorabertura)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 150,
                child: Text(real.format(caixa.entradas)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 150,
                child: Text(real.format(caixa.saidas)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 150,
                child: Text(real.format(caixa.total)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 150,
                child: Text(caixa.status),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PopupMenuButton(
                    tooltip: 'Opções',
                    color: const Color.fromRGBO(0, 92, 141, 1),
                    icon: const Icon(
                      Icons.more_vert,
                      color: Color.fromRGBO(0, 92, 141, 1),
                    ),
                    itemBuilder: (context) =>
                        caixa.status == 'Aberto' ? aberto : fechado,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
