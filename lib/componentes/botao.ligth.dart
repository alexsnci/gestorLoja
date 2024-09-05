// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BotaoLigth extends StatefulWidget {
  final Icon icone;
  final Widget texto;
  final void Function() onClick;
  const BotaoLigth({
    super.key,
    required this.icone,
    required this.texto,
    required this.onClick,
  });

  @override
  State<BotaoLigth> createState() => _BotaoLigthState();
}

class _BotaoLigthState extends State<BotaoLigth> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onClick,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.blue,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: widget.icone,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: widget.texto,
              )
            ],
          ),
        ));
  }
}
