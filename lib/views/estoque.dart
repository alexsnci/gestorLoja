import 'package:flutter/material.dart';
import 'package:gestorloja/componentes/botao.ligth.dart';
import 'package:gestorloja/componentes/card.estoque.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/repository/estoque.repository.dart';
import 'package:gestorloja/store/estoque.store.dart';
import 'package:gestorloja/views/atualizar.estoque.dart';
import 'package:gestorloja/views/cadastros/cadastro.estoque.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Estoque extends StatefulWidget {
  const Estoque({super.key});

  @override
  State<Estoque> createState() => _EstoqueState();
}

class _EstoqueState extends State<Estoque> {
  late EstoqueStore store;
  var edtBusca = TextEditingController();

  @override
  void initState() {
    store = EstoqueStore(
      repository: EstoqueRepository(client: HttpClient(), url: server),
    );
    store.getEstoque(nome: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'PRODUTOS',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color.fromARGB(255, 21, 88, 143),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 10),
                  child: SearchBar(
                    onSubmitted: (value) {
                      _getProdutos(valor: value);
                    },
                    textCapitalization: TextCapitalization.characters,
                    leading: const Icon(PhosphorIconsRegular.magnifyingGlass),
                    hintText:
                        'Entre com o nome do produto, código de barras, modelo, cor ou descrição do produto',
                    controller: edtBusca,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BotaoLigth(
                    icone: const Icon(PhosphorIconsRegular.export),
                    texto: const Text('Exportar para PDF'),
                    onClick: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: BotaoLigth(
                      icone: const Icon(PhosphorIconsRegular.plus),
                      texto: const Text('Adicionar Novo Produto'),
                      onClick: () {
                        nivelacesso == 1
                            ? Navigator.push(
                                context,
                                PageTransition(
                                  child: const CadastroEstoque(),
                                  type: PageTransitionType.rightToLeft,
                                  duration: const Duration(milliseconds: 500),
                                ),
                              ).whenComplete(
                                () {
                                  store.getEstoque(nome: '');
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
                          color: Color.fromARGB(255, 21, 88, 143)),
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
                          SizedBox(
                            width: 250,
                            child: Text(
                              'PRODUTO',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Text(
                              'MARCA',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: SizedBox(
                              width: 100,
                              child: Text(
                                'MODELO',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: SizedBox(
                              width: 150,
                              child: Text(
                                'COR',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: SizedBox(
                              width: 100,
                              child: Text(
                                'TAMANHO',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: SizedBox(
                              width: 100,
                              child: Text(
                                'SETOR',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: SizedBox(
                              width: 70,
                              child: Text(
                                'QTD',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: SizedBox(
                              width: 100,
                              child: Text(
                                'VALOR',
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
                                return CardEstoque(
                                  estoque: store.state.value[index],
                                  cor: color,
                                  atualizar: () {
                                    nivelacesso == 1
                                        ? Navigator.push(
                                                context,
                                                PageTransition(
                                                    child: AtualizarEstoque(
                                                        produto: store.state
                                                            .value[index]),
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    duration: const Duration(
                                                        milliseconds: 500)))
                                            .whenComplete(
                                            () async {
                                              await store.getEstoque(nome: '');
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

  _getProdutos({required String valor}) async {
    await store.getEstoqueProduto(valor: valor);
  }
}
