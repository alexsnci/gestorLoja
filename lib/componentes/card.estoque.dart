// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:gestorloja/model/estoque.model.dart';

class CardEstoque extends StatelessWidget {
  final EstoqueModel estoque;
  final Color cor;
  final void Function()? atualizar;
  const CardEstoque({
    super.key,
    required this.estoque,
    required this.cor,
    this.atualizar,
  });

  @override
  Widget build(BuildContext context) {
    var real = NumberFormat.currency(locale: 'pt_BR', customPattern: 'R\$ ');
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
                child: Text(estoque.id.toString().padLeft(4, '0')),
              ),
            ),
            SizedBox(
              width: 250,
              child: Text(estoque.descricao),
            ),
            SizedBox(
              width: 100,
              child: Text(estoque.produto),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                width: 100,
                child: Text(estoque.modelo),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                width: 150,
                child: Text(estoque.cor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                width: 100,
                child: Text(estoque.tamanho),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                width: 100,
                child: Text(estoque.setor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                width: 70,
                child: Text(estoque.quantidadeatual.toString()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                width: 70,
                child: Text(real.format(estoque.valorvenda)),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PopupMenuButton(
                    position: PopupMenuPosition.over,
                    tooltip: 'Opções do produto',
                    color: const Color.fromRGBO(0, 92, 141, 1),
                    icon: const Icon(
                      Icons.more_vert,
                      color: Color.fromRGBO(0, 92, 141, 1),
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        height: 40,
                        onTap: atualizar,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              PhosphorIconsRegular.pencilSimple,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            Text(
                              'Entrada de produto',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        height: 40,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              PhosphorIconsRegular.prohibit,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            Text(
                              'Desativar produto',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        height: 40,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              PhosphorIconsRegular.fileMagnifyingGlass,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            Text(
                              'Movimentação',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
