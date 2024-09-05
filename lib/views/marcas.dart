import 'package:flutter/material.dart';
import 'package:gestorloja/componentes/botao.ligth.dart';
import 'package:gestorloja/componentes/card.Produto.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/repository/marcas.repository.dart';
import 'package:gestorloja/store/marcas.store.dart';
import 'package:gestorloja/views/cadastros/cadastro.marcas.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Produtos extends StatefulWidget {
  const Produtos({super.key});

  @override
  State<Produtos> createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
  late ProdutosStore store;

  @override
  void initState() {
    store = ProdutosStore(
      repository: ProdutosRepository(client: HttpClient(), url: server),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getProdutos();
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Produtos',
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
                      texto: const Text('Adicionar Novo Produto'),
                      onClick: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: const CadastroProdutos(),
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
                            width: 250,
                            child: Text('DESCRIÇÃO'),
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
                                return CardProdutos(
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
    );
  }

  _getProdutos() async {
    store.getProdutos(nome: '');
  }
}
