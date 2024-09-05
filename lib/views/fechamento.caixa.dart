// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:gestorloja/componentes/botao.ligth.dart';

import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/caixa.model.dart';
import 'package:gestorloja/model/fechamento.caixa.model.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/repository/caixa.repository.dart';
import 'package:gestorloja/store/caixa.store.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FechamentoCaixa extends StatefulWidget {
  final CaixaModel caixa;

  const FechamentoCaixa({
    super.key,
    required this.caixa,
  });

  @override
  State<FechamentoCaixa> createState() => _FechamentoCaixaState();
}

class _FechamentoCaixaState extends State<FechamentoCaixa> {
  late CaixaStore store;
  bool? caixasemmovimentacao = false;
  var edtValorVendaAvista =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  var edtValorCartaoCredito =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  var edtValorVendaCartaoDebito =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  var edtValorVendaPix =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');

  @override
  void initState() {
    store = CaixaStore(
      repository: CaixaRepository(client: HttpClient(), url: server),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 21, 88, 143),
        title: Text(
          'Fechamento do Caixa: ${widget.caixa.id.toString().padLeft(3, '0')} do dia ${widget.caixa.data}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * .8,
          width: MediaQuery.of(context).size.width * .8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 300,
                    width: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                          controller: edtValorVendaAvista,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(PhosphorIconsRegular.coin),
                            border: OutlineInputBorder(),
                            label: Text('Entre com o valor das vendas à vista'),
                          ),
                        ),
                        TextFormField(
                          controller: edtValorCartaoCredito,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(PhosphorIconsRegular.cards),
                            border: OutlineInputBorder(),
                            label: Text(
                                'Entre com o valor das vendas no cartão de crédito'),
                          ),
                        ),
                        TextFormField(
                          controller: edtValorVendaCartaoDebito,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(PhosphorIconsRegular.creditCard),
                            border: OutlineInputBorder(),
                            label: Text(
                                'Entre com o valor das vendas no cartão de débito'),
                          ),
                        ),
                        TextFormField(
                          controller: edtValorVendaPix,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(PhosphorIconsRegular.pixLogo),
                            border: OutlineInputBorder(),
                            label: Text('Entre com o valor das vendas no pix'),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              activeColor:
                                  const Color.fromARGB(255, 21, 88, 143),
                              value: caixasemmovimentacao,
                              onChanged: (value) {
                                setState(() {
                                  caixasemmovimentacao = value;
                                });
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('Caixa sem movimentação?'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: BotaoLigth(
                    icone: const Icon(PhosphorIconsRegular.upload),
                    onClick: () async {
                      if (edtValorCartaoCredito.text == '0,00' &&
                          edtValorVendaAvista.text == '0,00' &&
                          edtValorVendaCartaoDebito.text == '0,00' &&
                          edtValorVendaPix.text == '0,00' &&
                          caixasemmovimentacao == false) {
                        SnackBar snac = const SnackBar(
                          content: Text('Informe os valores aputados hoje!'),
                          backgroundColor: Colors.blue,
                          showCloseIcon: true,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snac);
                      } else {
                        await store.postFecharCaixa(dados: [
                          FechamentoCaixaModel(
                              id: 0,
                              idcaixa: 0,
                              datafechamento: '',
                              valoravistainformado: double.parse(
                                  edtValorVendaAvista.text
                                      .replaceAll(',', '.')),
                              valoravistaregistrado: 0,
                              valorcartaocreditoinformado: double.parse(
                                  edtValorCartaoCredito.text
                                      .replaceAll(',', '.')),
                              valorcartaocreditoregistrado: 0,
                              valorcartaodebitoinformado: double.parse(
                                  edtValorVendaCartaoDebito.text
                                      .replaceAll(',', '.')),
                              valorcartaodebitoregistrado: 0,
                              valorpixinformado: double.parse(
                                  edtValorVendaPix.text.replaceAll(',', '.')),
                              valorpixregistrado: 0),
                        ]);
                        if (mounted) {
                          SnackBar snac = SnackBar(
                            content: Text(store.fecharcaixa.value),
                            backgroundColor: Colors.blue,
                            showCloseIcon: true,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snac);
                          Navigator.pop(context);
                        }
                      }
                    },
                    texto: const Text('Confirmar'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
