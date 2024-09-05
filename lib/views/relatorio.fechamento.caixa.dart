// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/variaveis.dart';

import 'package:gestorloja/model/caixa.model.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/repository/caixa.repository.dart';
import 'package:gestorloja/store/caixa.store.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RelatorioFechamentoCaixa extends StatefulWidget {
  final CaixaModel caixa;
  const RelatorioFechamentoCaixa({
    super.key,
    required this.caixa,
  });

  @override
  State<RelatorioFechamentoCaixa> createState() =>
      _RelatorioFechamentoCaixaState();
}

class _RelatorioFechamentoCaixaState extends State<RelatorioFechamentoCaixa> {
  late CaixaStore store;
  var real = NumberFormat.currency(locale: 'pt-BR', symbol: 'R\$');

  @override
  void initState() {
    store = CaixaStore(
        repository: CaixaRepository(client: HttpClient(), url: server));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getRelatorio();
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Relatório do caixa do dia: ${widget.caixa.data}',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 21, 88, 143),
      ),
      body: Center(
        child: Container(
            height: MediaQuery.of(context).size.height * .8,
            width: MediaQuery.of(context).size.width * .9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
                color: Colors.white),
            child: AnimatedBuilder(
              animation: Listenable.merge(
                  [store.erro, store.isLoading, store.stateRelatorio]),
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

                if (store.stateRelatorio.value.isEmpty) {
                  return const Center(
                    child: Text('Nenhum registro localizado!'),
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 300,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 21, 88, 143),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.blue)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      PhosphorIconsRegular.coin,
                                      color: Colors.white,
                                    ),
                                    Center(
                                      child: Text(
                                          'Total à vista registrado: ${real.format(store.stateRelatorio.value[0].valoravistaregistrado)}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 300,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 21, 88, 143),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.blue)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      PhosphorIconsRegular.cards,
                                      color: Colors.white,
                                    ),
                                    Center(
                                      child: Text(
                                        'Total crédito registrado: ${real.format(store.stateRelatorio.value[0].valorcartaocreditoregistrado)}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 300,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 21, 88, 143),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.blue)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      PhosphorIconsRegular.creditCard,
                                      color: Colors.white,
                                    ),
                                    Center(
                                      child: Text(
                                          'Total débito registrado: ${real.format(store.stateRelatorio.value[0].valorcartaodebitoregistrado)}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 300,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 21, 88, 143),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.blue)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      PhosphorIconsRegular.pixLogo,
                                      color: Colors.white,
                                    ),
                                    Center(
                                      child: Text(
                                          'Total pix registrado: ${real.format(store.stateRelatorio.value[0].valorpixregistrado)}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 300,
                              height: 60,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 236, 232, 201),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          100, 105, 125, 1))),
                              child: Center(
                                child: Text(
                                  'Total à vista informado: ${real.format(store.stateRelatorio.value[0].valoravistainformado)}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            Container(
                              width: 300,
                              height: 60,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 236, 232, 201),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          100, 105, 125, 1))),
                              child: Center(
                                child: Text(
                                  'Total crédito informado: ${real.format(store.stateRelatorio.value[0].valorcartaocreditoinformado)}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            Container(
                              width: 300,
                              height: 60,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 236, 232, 201),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          100, 105, 125, 1))),
                              child: Center(
                                child: Text(
                                  'Total débito informado: ${real.format(store.stateRelatorio.value[0].valorcartaodebitoinformado)}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            Container(
                              width: 300,
                              height: 60,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 236, 232, 201),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          100, 105, 125, 1))),
                              child: Center(
                                child: Text(
                                  'Total pix informado: ${real.format(store.stateRelatorio.value[0].valorpixinformado)}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            )),
      ),
    );
  }

  _getRelatorio() async {
    await store.getRelatorioCaixa(idcaixa: widget.caixa.id);
  }
}
