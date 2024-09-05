// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/model/pagamentos.pedidos.model.dart';
import 'package:gestorloja/model/venda.model.dart';
import 'package:gestorloja/repository/pagamentos.pedido.repository.dart';
import 'package:gestorloja/repository/venda.repository.dart';
import 'package:gestorloja/store/pagamentos.pedido.store.dart';
import 'package:gestorloja/store/venda.store.dart';
import 'package:gestorloja/views/inserir.valor.pagamento.pedido.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FinalizarVenda extends StatefulWidget {
  final VendaModel pedido;
  const FinalizarVenda({
    super.key,
    required this.pedido,
  });

  @override
  State<FinalizarVenda> createState() => _FinalizarVendaState();
}

class _FinalizarVendaState extends State<FinalizarVenda> {
  var real = NumberFormat.currency(locale: 'pt_BR', customPattern: 'R\$ ');
  late PagamentosPedidosStore store;
  double valorRestante = 0;
  double valorPago = 0;

  @override
  void initState() {
    store = PagamentosPedidosStore(
      repository:
          PagamentosPedidosRepository(client: HttpClient(), url: server),
    );
    _getPagamentos();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Finalizar Pedido',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(70),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(PhosphorIconsRegular.shoppingCartSimple,
                    size: 24, color: Colors.green),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Pedido nº. ${widget.pedido.id.toString().padLeft(3, '0')}',
                    style: const TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: Text(
                    'Valor: ${real.format(
                      widget.pedido.valorcompra,
                    )}',
                    style: const TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Text(
                    'Valor Restante: ${real.format(widget.pedido.valorcompra - valorPago)}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.green,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .43,
                    height: MediaQuery.of(context).size.height * .58,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: GridView(
                      padding: const EdgeInsets.all(15),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15),
                      children: [
                        InkWell(
                          onTap: () => _efetuarPagamento(forma: 'À Vista'),
                          child: const Card(
                            color: Colors.white,
                            elevation: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(PhosphorIconsRegular.moneyWavy),
                                Text('À Vista')
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => _efetuarPagamento(forma: 'PIX'),
                          child: const Card(
                            color: Colors.white,
                            elevation: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(PhosphorIconsRegular.pixLogo),
                                Text('PIX')
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              _efetuarPagamento(forma: 'Cartão Crédito'),
                          child: const Card(
                            color: Colors.white,
                            elevation: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(PhosphorIconsRegular.creditCard),
                                Text('Cartão Crédito')
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              _efetuarPagamento(forma: 'Cartão Débito'),
                          child: const Card(
                            color: Colors.white,
                            elevation: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(PhosphorIconsRegular.cards),
                                Text('Cartão Débito')
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .43,
                    height: MediaQuery.of(context).size.height * .58,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              SizedBox(
                                width: 300,
                                child: Text(
                                  'Forma Escolhida',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.green),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  'Valor',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.green),
                                ),
                              )
                            ],
                          ),
                          const Divider(
                            color: Colors.green,
                          ),
                          Expanded(
                            child: AnimatedBuilder(
                              animation: Listenable.merge(
                                  [store.erro, store.state, store.isLoading]),
                              builder: (context, child) {
                                if (store.isLoading.value) {
                                  return const Center(
                                      child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: CircularProgressIndicator(
                                            color: Colors.green,
                                          )));
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
                                      return ListTile(
                                        trailing: IconButton(
                                            onPressed: () async {
                                              await store.apagarPagamentos(
                                                  id: store
                                                      .state.value[index].id);

                                              if (mounted) {
                                                _getPagamentos();
                                              }
                                            },
                                            icon: const Icon(
                                                PhosphorIconsRegular.trash)),
                                        title: Row(
                                          children: [
                                            SizedBox(
                                              width: 300,
                                              child: Text(store.state
                                                  .value[index].formapagamento),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                real.format(store
                                                    .state.value[index].valor),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (valorPago < widget.pedido.valorcompra) {
                                    SnackBar snac = const SnackBar(
                                      content: Text('Pedido ainda não pago!'),
                                      backgroundColor: Colors.blue,
                                      showCloseIcon: true,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snac);
                                  } else {
                                    VendaStore venda = VendaStore(
                                        repository: VendaRepository(
                                            client: HttpClient(), url: server));
                                    await venda.finalizarpedido(
                                        idvenda: widget.pedido.id);
                                    if (mounted) {
                                      SnackBar snacv = SnackBar(
                                        content: Text(venda.finalizar.value),
                                        backgroundColor: Colors.blue,
                                        showCloseIcon: true,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snacv);

                                      Navigator.pop(context);

                                      idpedido = 0;
                                    }
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green),
                                  child: const Center(
                                    child: Text(
                                      'Finalizar Pedido',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _efetuarPagamento({required String forma}) {
    if (valorPago >= widget.pedido.valorcompra) {
      SnackBar snac = const SnackBar(
        content: Text('Valor do pedido já pago!'),
        backgroundColor: Colors.blue,
        showCloseIcon: true,
      );
      ScaffoldMessenger.of(context).showSnackBar(snac);
    } else {
      Navigator.push(
              context,
              PageTransition(
                  child: InserirValorVenda(tipo: forma, pedido: widget.pedido),
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 500)))
          .whenComplete(
        () async {
          await store.getPagamentos(idpedido: idpedido);
          valorPago = 0;
          for (PagamentosPedidosModel pag in store.state.value) {
            valorPago = valorPago + pag.valor;
          }
          setState(() {});
        },
      );
    }
  }

  _getPagamentos() async {
    await store.getPagamentos(idpedido: idpedido);
    valorPago = 0;
    for (PagamentosPedidosModel pag in store.state.value) {
      valorPago = valorPago + pag.valor;
    }
    setState(() {});
  }
}
