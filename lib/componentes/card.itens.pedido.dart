// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:gestorloja/model/itens.venda.model.dart';

class CardItensPedido extends StatefulWidget {
  final ItensVendaModel item;
  final void Function()? adicionar;
  final void Function()? remover;
  final Color cor;
  const CardItensPedido({
    super.key,
    required this.item,
    required this.adicionar,
    required this.remover,
    required this.cor,
  });

  @override
  State<CardItensPedido> createState() => _CardItensPedidoState();
}

class _CardItensPedidoState extends State<CardItensPedido> {
  var real = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: widget.cor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width > 1366 ? 150 : 100,
              child: Text(
                '${widget.item.produto} ${widget.item.marca} ${widget.item.cor} ${widget.item.tamanho}',
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.width > 1366 ? 14 : 8),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width > 1366 ? 50 : 40,
              child: Text(
                widget.item.quantidade.toString().padLeft(2, '0'),
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.width > 1366 ? 14 : 8),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width > 1366 ? 70 : 40,
              child: Text(
                real.format(widget.item.valor),
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.width > 1366 ? 14 : 8),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width > 1366 ? 100 : 80,
              child: Text(
                real.format(widget.item.subtotal),
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.width > 1366 ? 14 : 8),
              ),
            ),
            Column(
              children: [
                InkWell(
                  onTap: widget.remover,
                  child: const CircleAvatar(
                    backgroundColor: Colors.amber,
                    radius: 15,
                    child: Icon(
                      PhosphorIconsRegular.minus,
                      size: 10,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: widget.adicionar,
                    child: const CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 15,
                      child: Icon(
                        PhosphorIconsRegular.plus,
                        size: 10,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
