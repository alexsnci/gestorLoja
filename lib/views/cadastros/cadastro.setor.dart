import 'package:flutter/material.dart';
import 'package:gestorloja/componentes/botao.ligth.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/model/setores.model.dart';
import 'package:gestorloja/repository/setores.repository.dart';

import 'package:gestorloja/store/setores.store.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

class CadastroSetores extends StatefulWidget {
  const CadastroSetores({super.key});

  @override
  State<CadastroSetores> createState() => _CadastroSetoresState();
}

class _CadastroSetoresState extends State<CadastroSetores> {
  final _formkey = GlobalKey<FormState>();
  var edtDescricao = TextEditingController();

  late SetoresStore store;

  @override
  void initState() {
    store = SetoresStore(
        repository: SetoresRepository(client: HttpClient(), url: server));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      appBar: AppBar(
        backgroundColor: Cores.fundoFormulario,
        title: const Text('Cadastro de Setores'),
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
                        Icon(PhosphorIconsRegular.selection),
                        Text('Dados da Setor')
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
                                  await store.postSetor(
                                    dados: [
                                      SetoresModel(
                                        id: 0,
                                        descricao: edtDescricao.text,
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
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
