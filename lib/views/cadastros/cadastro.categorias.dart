import 'package:flutter/material.dart';
import 'package:gestorloja/componentes/botao.ligth.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/categorias.model.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/repository/categorias.repository.dart';
import 'package:gestorloja/store/categorias.store.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

class CadastroCategorias extends StatefulWidget {
  const CadastroCategorias({super.key});

  @override
  State<CadastroCategorias> createState() => _CadastroCategoriasState();
}

class _CadastroCategoriasState extends State<CadastroCategorias> {
  final _formkey = GlobalKey<FormState>();
  var edtDescricao = TextEditingController();
  var edtStatus = TextEditingController();

  late CategoriasStore store;

  @override
  void initState() {
    store = CategoriasStore(
        repository: CategoriasRepository(client: HttpClient(), url: server));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      appBar: AppBar(
        backgroundColor: Cores.fundoFormulario,
        title: const Text('Cadastro de Categorias'),
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
                        Text('Dados da Categoria')
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
                        width: MediaQuery.of(context).size.width * .5,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo abrigatório';
                            } else {
                              return null;
                            }
                          },
                          controller: edtDescricao,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(199, 200, 209, 1),
                                    width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              label: Text('Entre com o nome da categoria')),
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
                                  await store.postCategorias(
                                    dados: [
                                      CategoriasModel(
                                          id: 0,
                                          descricao: edtDescricao.text,
                                          status: 'Ativa'),
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
