import 'package:flutter/material.dart';
import 'package:gestorloja/componentes/botao.ligth.dart';
import 'package:gestorloja/componentes/card.usuarios.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/repository/usuarios.repository.dart';
import 'package:gestorloja/store/usuarios.store.dart';
import 'package:gestorloja/views/cadastros/cadastro.usuarios.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Usuarios extends StatefulWidget {
  const Usuarios({super.key});

  @override
  State<Usuarios> createState() => _UsuariosState();
}

class _UsuariosState extends State<Usuarios> {
  late UsuariosStore store;

  @override
  void initState() {
    store = UsuariosStore(
        repository: UsuariosRepository(client: HttpClient(), url: server));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getUsuarios();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 88, 143),
        title: const Text(
          'Usuários Cadastrados',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * .8,
          width: MediaQuery.of(context).size.width * .9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: BotaoLigth(
                          icone: const Icon(PhosphorIconsRegular.export),
                          texto: const Text('Exportar PDF'),
                          onClick: () {}),
                    ),
                    BotaoLigth(
                        icone: const Icon(PhosphorIconsRegular.plus),
                        texto: const Text('Novo Usuário'),
                        onClick: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: const CadastroUsuarios(),
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 500),
                            ),
                          ).whenComplete(
                            () {
                              _getUsuarios();
                            },
                          );
                        }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 21, 88, 143)),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'ID',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            'NOME',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SizedBox(
                          width: 250,
                          child: Text(
                            'NOME DE ACESSO',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SizedBox(
                          width: 100,
                          child: Text(
                            'STATUS',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Divider(),
              ),
              Expanded(
                child: AnimatedBuilder(
                  animation: Listenable.merge(
                      [store.erro, store.isLoading, store.state]),
                  builder: (context, child) {
                    if (store.isLoading.value) {
                      return const Center(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: CircularProgressIndicator(
                            color: Colors.green,
                          ),
                        ),
                      );
                    }

                    if (store.erro.value.isNotEmpty) {
                      return Center(
                        child: Text(store.erro.value),
                      );
                    }

                    if (store.state.value.isEmpty) {
                      return const Center(
                        child: Text('Nenhum registro encontrado!'),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: ListView.builder(
                          itemCount: store.state.value.length,
                          itemBuilder: (context, index) {
                            Color color = index.isOdd
                                ? const Color.fromARGB(251, 240, 240, 228)
                                : Colors.white;
                            return CardUsuarios(
                                usuario: store.state.value[index], cor: color);
                          },
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getUsuarios() async {
    await store.getUsuarios(nome: '');
  }
}
