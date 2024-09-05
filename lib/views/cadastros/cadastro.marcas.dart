import 'package:flutter/material.dart';
import 'package:gestorloja/componentes/botao.ligth.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/model/marcas.model.dart';
import 'package:gestorloja/repository/marcas.repository.dart';
import 'package:gestorloja/store/marcas.store.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CadastroProdutos extends StatefulWidget {
  const CadastroProdutos({super.key});

  @override
  State<CadastroProdutos> createState() => _CadastroProdutosState();
}

class _CadastroProdutosState extends State<CadastroProdutos> {
  final _formkey = GlobalKey<FormState>();
  var edtDescricao = TextEditingController();

  late ProdutosStore store;

  @override
  void initState() {
    store = ProdutosStore(
      repository: ProdutosRepository(client: HttpClient(), url: server),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 88, 143),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Cores.fundoFormulario,
        title: const Text(
          'Cadastro da Marca',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * .8,
          width: MediaQuery.of(context).size.width * .9,
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
                          Icon(PhosphorIconsRegular.barcode),
                          Text('Dados da Marca')
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
                          width: MediaQuery.of(context).size.width * .15,
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
                                label: Text('Nome da Marca')),
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
                              await store.postProdutos(
                                dados: [
                                  MarcasModel(
                                    id: 0,
                                    descricao: edtDescricao.text,
                                    status: 'Ativo',
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
