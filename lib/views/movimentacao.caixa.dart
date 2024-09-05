// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gestorloja/componentes/card.movimentacao.caixa.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/variaveis.dart';

import 'package:gestorloja/model/caixa.model.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/repository/movimentacao.caixa.repository.dart';
import 'package:gestorloja/store/movimentacao.caixa.store.dart';
import 'package:intl/intl.dart';

class MovimentacaoCaixa extends StatefulWidget {
  final CaixaModel caixa;
  const MovimentacaoCaixa({
    super.key,
    required this.caixa,
  });

  @override
  State<MovimentacaoCaixa> createState() => _MovimentacaoCaixaState();
}

class _MovimentacaoCaixaState extends State<MovimentacaoCaixa> {
  var real = NumberFormat.currency(locale: 'pt-BR', symbol: 'R\$');
  late MovimentacaoCaixaStore store;

  @override
  void initState() {
    store = MovimentacaoCaixaStore(
      repository:
          Movimentacaocaixarepository(client: HttpClient(), url: server),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getMovimentacao();
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 21, 88, 143),
        title: Text(
          'Relatório das movimentações financeiras do caixa: ${widget.caixa.id.toString().padLeft(4, '0')}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color.fromRGBO(100, 105, 125, 1)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Center(
                                child: Text(
                              'Saidas: ${real.format(widget.caixa.saidas)}',
                              style: const TextStyle(color: Colors.black54),
                            )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color.fromRGBO(100, 105, 125, 1)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Center(
                                child: Text(
                                    'Entradas: ${real.format(widget.caixa.entradas)}',
                                    style: const TextStyle(
                                        color: Colors.black54))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color.fromRGBO(100, 105, 125, 1)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Center(
                                child: Text(
                                    'Total Caixa: ${real.format(widget.caixa.total)}',
                                    style: const TextStyle(
                                        color: Colors.black54))),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 21, 88, 143)),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: Text('ID',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: SizedBox(
                                    width: 100,
                                    child: Text('DATA',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: SizedBox(
                                    width: 300,
                                    child: Text('DESCRIÇÃO',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: SizedBox(
                                    width: 100,
                                    child: Text('TIPO',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: SizedBox(
                                    width: 100,
                                    child: Text('VALOR',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: AnimatedBuilder(
                            animation: Listenable.merge(
                                [store.erro, store.isLoading, store.state]),
                            builder: (context, child) {
                              if (store.isLoading.value) {
                                return const Center(
                                  child: SizedBox(
                                    width: 100,
                                    height: 100,
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
                                  child: Text('Nenhum valor encontrado!'),
                                );
                              } else {
                                return ListView.builder(
                                  itemCount: store.state.value.length,
                                  itemBuilder: (context, index) {
                                    Color color = index.isOdd
                                        ? const Color.fromARGB(
                                            251, 240, 240, 228)
                                        : Colors.white;
                                    return CardMovimentacaoCaixa(
                                        movimentacao: store.state.value[index],
                                        cor: color);
                                  },
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getMovimentacao() async {
    await store.getMovimentacaoCaixa(idcaixa: widget.caixa.id);
  }
}
