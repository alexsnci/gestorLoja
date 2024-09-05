// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/imagens.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/repository/caixa.repository.dart';
import 'package:gestorloja/store/caixa.store.dart';
import 'package:gestorloja/views/caixa.dart';
import 'package:gestorloja/views/clientes.dart';
import 'package:gestorloja/views/configuracoes.dart';
import 'package:gestorloja/views/contas.a.pagar.dart';
import 'package:gestorloja/views/contas.a.receber.dart';
import 'package:gestorloja/views/dashboard.dart';
import 'package:gestorloja/views/estoque.dart';
import 'package:gestorloja/views/fornecedores.dart';
import 'package:gestorloja/views/pdv.dart';
import 'package:gestorloja/views/marcas.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int paginaAtual = 0;
  double espacamento = 20;
  late PageController pc;
  late CaixaStore storecaixa;

  @override
  void initState() {
    storecaixa = CaixaStore(
      repository: CaixaRepository(client: HttpClient(), url: server),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pc = PageController(initialPage: paginaAtual);
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      body: Row(
        children: [
          Container(
            width: 70,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Cores.barraLaterel),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.asset(Imagens.logo),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: espacamento),
                  child: IconButton(
                      tooltip: 'Dashiboard',
                      onPressed: () {
                        pc.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.ease,
                        );
                      },
                      icon: const Icon(PhosphorIconsRegular.houseLine)),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: espacamento),
                  child: IconButton(
                    tooltip: 'Clientes',
                    onPressed: () {
                      pc.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease,
                      );
                    },
                    icon: const Icon(PhosphorIconsRegular.user),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: espacamento),
                  child: IconButton(
                    tooltip: 'Fornecedores',
                    onPressed: () {
                      pc.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease,
                      );
                    },
                    icon: const Icon(PhosphorIconsRegular.buildingOffice),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: espacamento),
                  child: IconButton(
                    tooltip: 'Estoque',
                    onPressed: () {
                      pc.animateToPage(
                        3,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease,
                      );
                    },
                    icon: const Icon(PhosphorIconsRegular.stack),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: espacamento),
                  child: IconButton(
                    tooltip: 'Caixa',
                    onPressed: () {
                      pc.animateToPage(
                        5,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease,
                      );
                    },
                    icon: const Icon(PhosphorIconsRegular.currencyCircleDollar),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: espacamento),
                  child: IconButton(
                    tooltip: 'PDV',
                    onPressed: () async {
                      await storecaixa.statuscaixa();
                      if (mounted) {
                        if (storecaixa.status.value == 'Caixa aberto') {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: const PDV(),
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 500),
                            ),
                          );
                        } else {
                          AlertDialog dialogF = AlertDialog(
                            backgroundColor: Colors.cyan,
                            title: const Center(
                              child: Text(
                                'Aviso',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                            content: SizedBox(
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      storecaixa.status.value,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ],
                          );
                          showDialog(
                            context: context,
                            builder: (context) => dialogF,
                          );
                        }
                      }
                    },
                    icon: const Icon(PhosphorIconsRegular.shoppingCartSimple),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: espacamento),
                  child: IconButton(
                    tooltip: 'Contas a receber',
                    onPressed: () {
                      pc.animateToPage(
                        6,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease,
                      );
                    },
                    icon: const Icon(PhosphorIconsRegular.coins),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: espacamento),
                  child: IconButton(
                    tooltip: 'Contas a pagar',
                    onPressed: () {
                      pc.animateToPage(
                        7,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease,
                      );
                    },
                    icon: const Icon(PhosphorIconsRegular.handCoins),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: espacamento),
                  child: IconButton(
                    tooltip: 'Configurações',
                    onPressed: () {
                      pc.animateToPage(
                        8,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease,
                      );
                    },
                    icon: const Icon(PhosphorIconsRegular.gear),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: Cores.fundoFormulario),
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Olá $nomeUser '),
                          Row(
                            children: [
                              Stack(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        PhosphorIconsRegular.bellSimple),
                                  )
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: CircleAvatar(
                                  child: Icon(PhosphorIconsRegular.user),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: PageView(
                        controller: pc,
                        onPageChanged: setPaginaAtual,
                        allowImplicitScrolling: true,
                        children: const [
                          Dashboard(),
                          Clientes(),
                          Fornecedores(),
                          Estoque(),
                          Produtos(),
                          Caixa(),
                          ContasAReceber(),
                          ContasAPagar(),
                          Configuracoes(),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }
}
