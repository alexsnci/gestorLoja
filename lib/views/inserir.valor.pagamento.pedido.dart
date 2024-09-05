// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/model/pagamentos.pedidos.model.dart';

import 'package:gestorloja/model/venda.model.dart';
import 'package:gestorloja/repository/pagamentos.pedido.repository.dart';
import 'package:gestorloja/store/pagamentos.pedido.store.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InserirValorVenda extends StatefulWidget {
  final String tipo;
  final VendaModel pedido;
  const InserirValorVenda({
    super.key,
    required this.tipo,
    required this.pedido,
  });

  @override
  State<InserirValorVenda> createState() => _InserirValorVendaState();
}

class _InserirValorVendaState extends State<InserirValorVenda> {
  var edtValor =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  late PagamentosPedidosStore store;

  @override
  void initState() {
    store = PagamentosPedidosStore(
      repository:
          PagamentosPedidosRepository(client: HttpClient(), url: server),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width * .6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Tipo selecionado: ${widget.tipo}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: edtValor,
                  decoration: const InputDecoration(
                    label: Text('Informe o valor do pagamentos'),
                    prefixIcon: Icon(PhosphorIconsRegular.currencyCircleDollar),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () async {
                    await store.postPagamentos(dados: [
                      PagamentosPedidosModel(
                          data: '',
                          formapagamento: widget.tipo,
                          id: 0,
                          idcaixa: 0,
                          idpedido: idpedido,
                          totalpago: 0,
                          valor:
                              double.parse(edtValor.text.replaceAll(',', '.')))
                    ]);

                    if (mounted) {
                      Navigator.pop(context);
                      SnackBar snac = SnackBar(
                        content: Text(store.post.value),
                        backgroundColor: Colors.green,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snac);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Confirmar'),
                        Icon(PhosphorIconsRegular.upload)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
