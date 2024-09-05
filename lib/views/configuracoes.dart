import 'package:flutter/material.dart';

import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/views/categorias.dart';
import 'package:gestorloja/views/promocoes.dart';
import 'package:gestorloja/views/setores.dart';
import 'package:gestorloja/views/usuarios.dart';
import 'package:page_transition/page_transition.dart';

class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Cores.fundoFormulario,
        title: const Text('Configurações'),
      ),
      backgroundColor: Cores.fundoFormulario,
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text('Produtos'),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Divider(
                            color: Color.fromRGBO(199, 200, 209, 1),
                          ),
                        ),
                        ListTile(
                          title: const Text('Categorias'),
                          onTap: () {
                            nivelacesso == 1
                                ? Navigator.push(
                                    context,
                                    PageTransition(
                                        child: const Categorias(),
                                        type: PageTransitionType.rightToLeft),
                                  )
                                : ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content: Text(
                                        'Usuário sem acesso a essa funcionalidade!'),
                                    backgroundColor: Colors.blue,
                                    showCloseIcon: true,
                                  ));
                          },
                        ),
                        ListTile(
                          title: const Text('Promoções'),
                          onTap: () {
                            nivelacesso == 1
                                ? Navigator.push(
                                    context,
                                    PageTransition(
                                        child: const Promocoes(),
                                        type: PageTransitionType.rightToLeft))
                                : ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content: Text(
                                        'Usuário sem acesso a essa funcionalidade!'),
                                    backgroundColor: Colors.blue,
                                    showCloseIcon: true,
                                  ));
                          },
                        ),
                        ListTile(
                          title: const Text('Setores'),
                          onTap: () {
                            nivelacesso == 1
                                ? Navigator.push(
                                    context,
                                    PageTransition(
                                        child: const Setores(),
                                        type: PageTransitionType.rightToLeft))
                                : ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content: Text(
                                        'Usuário sem acesso a essa funcionalidade!'),
                                    backgroundColor: Colors.blue,
                                    showCloseIcon: true,
                                  ));
                          },
                        )
                      ],
                    ),
                  )),
              SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text('Usuários'),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Divider(
                            color: Color.fromRGBO(199, 200, 209, 1),
                          ),
                        ),
                        ListTile(
                          title: const Text('Colaboradores'),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  child: const Categorias(),
                                  type: PageTransitionType.rightToLeft),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: ListTile(
                            title: const Text('Usuários'),
                            onTap: () {
                              nivelacesso == 1
                                  ? Navigator.push(
                                      context,
                                      PageTransition(
                                          child: const Usuarios(),
                                          type: PageTransitionType.rightToLeft))
                                  : ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content: Text(
                                          'Usuário sem acesso a essa funcionalidade!'),
                                      backgroundColor: Colors.blue,
                                      showCloseIcon: true,
                                    ));
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
