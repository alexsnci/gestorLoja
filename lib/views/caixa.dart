import 'package:flutter/material.dart';
import 'package:gestorloja/componentes/botao.ligth.dart';
import 'package:gestorloja/componentes/card.caixa.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/repository/caixa.repository.dart';
import 'package:gestorloja/store/caixa.store.dart';
import 'package:gestorloja/views/cadastros/cadastro.caixa.dart';
import 'package:gestorloja/views/fechamento.caixa.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Caixa extends StatefulWidget {
  const Caixa({super.key});

  @override
  State<Caixa> createState() => _CaixaState();
}

class _CaixaState extends State<Caixa> {
  late CaixaStore store;

  @override
  void initState() {
    store = CaixaStore(
      repository: CaixaRepository(client: HttpClient(), url: server),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _listarCaixa();
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CAIXA',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BotaoLigth(
                    icone: const Icon(PhosphorIconsRegular.export),
                    texto: const Text('Exportar para PDF'),
                    onClick: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 50),
                    child: BotaoLigth(
                      icone: const Icon(PhosphorIconsRegular.plus),
                      texto: const Text('Adicionar Novo Caixa'),
                      onClick: () {
                        nivelacesso == 1 || nivelacesso == 2
                            ? Navigator.push(
                                context,
                                PageTransition(
                                  child: const CadastroCaixa(),
                                  type: PageTransitionType.rightToLeft,
                                  duration: const Duration(milliseconds: 500),
                                ),
                              ).whenComplete(
                                () {
                                  setState(() {});
                                },
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
                  )
                ],
              )
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: const Color.fromRGBO(199, 200, 209, 1), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 21, 88, 143),
                      ),
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: SizedBox(
                              width: 80,
                              child: Text(
                                'ID',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 200,
                              child: Text(
                                'DATA ABERTURA',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 150,
                              child: Text(
                                'VALOR ABERTURA',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 150,
                              child: Text(
                                'ETRADAS',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: SizedBox(
                              width: 150,
                              child: Text(
                                'SAIDAS',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 150,
                              child: Text(
                                'VALOR ATUAL',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 200,
                              child: Text(
                                'STATUS',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: AnimatedBuilder(
                        animation: Listenable.merge(
                            [store.isLoading, store.erro, store.state]),
                        builder: (context, child) {
                          if (store.isLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
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
                            return ListView.builder(
                              itemCount: store.state.value.length,
                              itemBuilder: (context, index) {
                                Color color = index.isOdd
                                    ? const Color.fromARGB(251, 240, 240, 228)
                                    : Colors.white;
                                return CardCaixa(
                                  cor: color,
                                  caixa: store.state.value[index],
                                  fecharcaixa: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        child: FechamentoCaixa(
                                          caixa: store.state.value[index],
                                        ),
                                        type: PageTransitionType.rightToLeft,
                                        duration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    ).whenComplete(
                                      () {
                                        _listarCaixa();
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _listarCaixa() async {
    store.getCaixa(id: 0);
  }
}
