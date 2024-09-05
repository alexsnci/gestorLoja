import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:gestorloja/componentes/botao.ligth.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/caixa.model.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/repository/caixa.repository.dart';
import 'package:gestorloja/store/caixa.store.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CadastroCaixa extends StatefulWidget {
  const CadastroCaixa({super.key});

  @override
  State<CadastroCaixa> createState() => _CadastroCaixaState();
}

class _CadastroCaixaState extends State<CadastroCaixa> {
  final _formkey = GlobalKey<FormState>();
  var edtValorAbertura =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  var edtObservecoes = TextEditingController();

  late CaixaStore store;

  @override
  void initState() {
    store = CaixaStore(
        repository: CaixaRepository(client: HttpClient(), url: server));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      appBar: AppBar(
        backgroundColor: Cores.fundoFormulario,
        title: const Text('Caixas'),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * .8,
          width: MediaQuery.of(context).size.width * .8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromRGBO(199, 200, 209, 1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formkey,
              child: Column(children: [
                const Column(
                  children: [
                    Row(
                      children: [
                        Icon(PhosphorIconsRegular.codesandboxLogo),
                        Text('Dados do Caixa Atual')
                      ],
                    ),
                    Divider(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .1,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo abrigatório';
                            } else {
                              return null;
                            }
                          },
                          controller: edtValorAbertura,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(199, 200, 209, 1),
                                    width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              label: Text('Entre com o valor de Abertura')),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .4,
                          child: TextFormField(
                            controller: edtObservecoes,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(199, 200, 209, 1),
                                      width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                label: Text('Alguma observações')),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            BotaoLigth(
                              icone: const Icon(PhosphorIconsRegular.upload),
                              texto: const Text('Salvar'),
                              onClick: () async {
                                if (_formkey.currentState!.validate()) {
                                  await store.postCaixa(
                                    dados: [
                                      CaixaModel(
                                          id: 0,
                                          data: '',
                                          idcolaborador: idUser,
                                          observacoes: edtObservecoes.text,
                                          valorabertura: double.parse(
                                              edtValorAbertura.text
                                                  .replaceAll(',', '.')),
                                          total: 0,
                                          entradas: 0,
                                          saidas: 0,
                                          status: 'Aberto'),
                                    ],
                                  );

                                  if (mounted) {
                                    SnackBar snack = SnackBar(
                                      content: Text(store.post.value),
                                      backgroundColor: Colors.blue,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snack);
                                    Navigator.pop(context);
                                  }
                                }
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
