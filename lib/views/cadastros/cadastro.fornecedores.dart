import 'package:flutter/material.dart';
import 'package:gestorloja/componentes/botao.ligth.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/mascaras.de.entrada.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/fornecedores.model.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/repository/fornecedores.repository.dart';
import 'package:gestorloja/store/fornecedores.store.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CadastroFornecedor extends StatefulWidget {
  const CadastroFornecedor({super.key});

  @override
  State<CadastroFornecedor> createState() => _CadastroFornecedorState();
}

class _CadastroFornecedorState extends State<CadastroFornecedor> {
  final _formkey = GlobalKey<FormState>();
  var edtRazaoSocial = TextEditingController();
  var edtVendedor = TextEditingController();
  var edtContatovendedor = TextEditingController();
  var edtContato = TextEditingController();
  var edtCNPJ = TextEditingController();

  late FornecedoresStore store;

  @override
  void initState() {
    store = FornecedoresStore(
      repository: FornecedoresRepository(client: HttpClient(), url: server),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      appBar: AppBar(
        backgroundColor: Cores.fundoFormulario,
        title: const Text('Cadastro de Fornecedores'),
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
              child: Column(
                children: [
                  const Column(
                    children: [
                      Row(
                        children: [
                          Icon(PhosphorIconsRegular.buildings),
                          Text('Dados da empresa')
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .4,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo abrigatório';
                              } else {
                                return null;
                              }
                            },
                            controller: edtRazaoSocial,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(199, 200, 209, 1),
                                      width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                label: Text(
                                    'Entre com a razão social do fornecedor')),
                          ),
                        ),
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
                            controller: edtCNPJ,
                            inputFormatters: [maskCNPJ],
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(199, 200, 209, 1),
                                      width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                label: Text('Entre com o CNPJ do fornecedor')),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .2,
                          child: TextFormField(
                            inputFormatters: [maskCelular],
                            controller: edtContato,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(199, 200, 209, 1),
                                    width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              label: Text('Entre com o contato do fornecedor'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(PhosphorIconsRegular.addressBook),
                            Text('Contatos')
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .5,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo obrigatorio';
                              } else {
                                return null;
                              }
                            },
                            controller: edtVendedor,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(199, 200, 209, 1),
                                      width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                label: Text(
                                    'Entre com o nome do representante da empresa')),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .2,
                          child: TextFormField(
                            inputFormatters: [maskCelular],
                            controller: edtContatovendedor,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(199, 200, 209, 1),
                                    width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              label:
                                  Text('Entre com o contato do representante'),
                            ),
                          ),
                        ),
                      ],
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
                              await store.postFornecedores(
                                dados: [
                                  FornecedoresModel(
                                    id: 0,
                                    cnpj: edtCNPJ.text,
                                    contato: edtContato.text,
                                    contatovendedor: edtContatovendedor.text,
                                    razaosocial: edtRazaoSocial.text,
                                    status: 'Ativo',
                                    vendedor: edtVendedor.text,
                                  ),
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
          ),
        ),
      ),
    );
  }
}
