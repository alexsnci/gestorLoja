import 'package:flutter/material.dart';
import 'package:gestorloja/componentes/botao.ligth.dart';
import 'package:gestorloja/componentes/card.promocoes.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/repository/promocoes.repository.dart';
import 'package:gestorloja/store/promocoes.store.dart';
import 'package:gestorloja/views/cadastros/cadastro.promocoes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Promocoes extends StatefulWidget {
  const Promocoes({super.key});

  @override
  State<Promocoes> createState() => _PromocoesState();
}

class _PromocoesState extends State<Promocoes> {
  late PromocoesStore store;

  @override
  void initState() {
    store = PromocoesStore(
      repository: PromocoesRepository(client: HttpClient(), url: server),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listarFornecedores();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Cores.fundoFormulario,
      ),
      backgroundColor: Cores.fundoFormulario,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categorias',
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
                        texto: const Text('Adicionar nova Promoção'),
                        onClick: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: const CadastroPromocoes(),
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 500),
                            ),
                          ).whenComplete(
                            () {
                              setState(() {});
                            },
                          );
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
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: SizedBox(
                              width: 80,
                              child: Text('ID'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 200,
                              child: Text('PRODUTO'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 100,
                              child: Text('MODELO'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 100,
                              child: Text('COR'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 100,
                              child: Text('TAMANHO'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 100,
                              child: Text('SETOR'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 100,
                              child: Text('DATA INÍCIO'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 100,
                              child: Text('DATA FIM'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 80,
                              child: Text('STATUS'),
                            ),
                          ),
                        ],
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
                                  return CardPromocoes(
                                      cor: color,
                                      produto: store.state.value[index]);
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
      ),
    );
  }

  listarFornecedores() async {
    await store.getPromocoes(produto: '');
  }
}
