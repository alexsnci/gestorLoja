// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gestorloja/model/usuarios.model.dart';

class CardUsuarios extends StatelessWidget {
  final UsuariosModel usuario;
  final Color cor;
  const CardUsuarios({
    super.key,
    required this.usuario,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    List<PopupMenuEntry<dynamic>> bloqueado = [
      PopupMenuItem(
        height: 40,
        onTap: () {},
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
                'Alterar Senha',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      PopupMenuItem(
        height: 40,
        onTap: () {},
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
                'Bloquear',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ];
    List<PopupMenuEntry<dynamic>> ativo = [
      PopupMenuItem(
        height: 40,
        onTap: () {},
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
                'Excluir',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ];
    return Card(
      color: usuario.status == 'Bloqueado' ? Colors.red[50] : cor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15, top: 15),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 80,
                child: Text(usuario.id.toString().padLeft(4, '0')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 200,
                child: Text(usuario.nome),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 250,
                child: Text(usuario.username),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 100,
                child: Text(usuario.status),
              ),
            ),
            usuario.nome == 'SUPORTE'
                ? Container()
                : Expanded(
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
                              usuario.status == 'Bloqueado' ? bloqueado : ativo,
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
