import 'package:flutter/material.dart';
import 'package:gestorloja/componentes/botao.ligth.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/mascaras.de.entrada.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/cep.model.dart';
import 'package:gestorloja/model/clilentes.model.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/repository/cep.repository.dart';
import 'package:gestorloja/repository/clientes.repository.dart';
import 'package:gestorloja/store/cep.store.dart';
import 'package:gestorloja/store/clientes.store.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CadastroClientes extends StatefulWidget {
  const CadastroClientes({super.key});

  @override
  State<CadastroClientes> createState() => _CadastroClientesState();
}

class _CadastroClientesState extends State<CadastroClientes> {
  final _formkey = GlobalKey<FormState>();
  var edtNome = TextEditingController();
  var edtDataNascimento = TextEditingController();
  var edtContato = TextEditingController();
  var edtLogradouro = TextEditingController();
  var edtBairro = TextEditingController();
  var edtCidade = TextEditingController();
  var edtUf = TextEditingController();
  var edtEmail = TextEditingController();
  var edtNumero = TextEditingController();
  var edtCEP = TextEditingController();
  late ClientesStore store;

  @override
  void initState() {
    store = ClientesStore(
      repository: ClientesRepository(client: HttpClient(), url: server),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      appBar: AppBar(
        backgroundColor: Cores.fundoFormulario,
        title: const Text('Cadastro de Clientes'),
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
                          Icon(PhosphorIconsRegular.user),
                          Text('Dados Pessoais')
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
                          width: MediaQuery.of(context).size.width * .45,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo abrigatório';
                              } else {
                                return null;
                              }
                            },
                            controller: edtNome,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(199, 200, 209, 1),
                                      width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                label: Text('Entre com o nome do cliente')),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .3,
                          child: TextFormField(
                            inputFormatters: [maskData],
                            controller: edtDataNascimento,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(199, 200, 209, 1),
                                    width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              label: Text('Entre com a data de nascimento'),
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
                          width: MediaQuery.of(context).size.width * .3,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo obrigatorio';
                              } else {
                                return null;
                              }
                            },
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
                                label: Text(
                                    'Entre com o melhor contato do cliente')),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .45,
                          child: TextFormField(
                            controller: edtEmail,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(199, 200, 209, 1),
                                    width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              label: Text('Entre com o email do cliente'),
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
                            Icon(PhosphorIconsRegular.mapPinArea),
                            Text('Endereço')
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
                          width: MediaQuery.of(context).size.width * .22,
                          child: TextFormField(
                            inputFormatters: [maskCEP],
                            controller: edtCEP,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      if (edtCEP.text.length < 9) {
                                        var snackbar = const SnackBar(
                                          content: Text('CEP inválido!'),
                                          backgroundColor: Colors.amber,
                                        );

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar);
                                      } else {
                                        late CepStore storecep;
                                        late List<CepModel> cep = [];
                                        storecep = CepStore(
                                          repository: CepRepository(
                                              client: HttpClient(),
                                              cep: edtCEP.text),
                                        );

                                        cep = await storecep.getCep();

                                        if (cep.isNotEmpty) {
                                          edtBairro.text = cep[0].bairro;
                                          edtCidade.text = cep[0].localidade;
                                          edtUf.text = cep[0].uf;
                                          edtLogradouro.text =
                                              cep[0].logradouro;
                                        }
                                      }
                                    },
                                    icon: const Icon(
                                        PhosphorIconsRegular.magnifyingGlass)),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(199, 200, 209, 1),
                                      width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                label: const Text('CEP')),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .4,
                          child: TextFormField(
                            controller: edtLogradouro,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(199, 200, 209, 1),
                                    width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              label: Text('Logradouro'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .1,
                          child: TextFormField(
                            controller: edtNumero,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(199, 200, 209, 1),
                                    width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              label: Text('Numero'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .32,
                          child: TextFormField(
                            controller: edtCidade,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(199, 200, 209, 1),
                                      width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                label: Text('Bairro')),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .3,
                          child: TextFormField(
                            controller: edtUf,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(199, 200, 209, 1),
                                      width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                label: Text('Cidade')),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .1,
                          child: TextFormField(
                            controller: edtUf,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(199, 200, 209, 1),
                                    width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              label: Text('UF'),
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
                              await store.postClientes(
                                dados: [
                                  ClientesModel(
                                      id: 0,
                                      nome: edtNome.text,
                                      datanascimento: edtDataNascimento.text,
                                      contato: edtContato.text,
                                      logradouro: edtLogradouro.text,
                                      numero: edtNumero.text,
                                      bairro: edtBairro.text,
                                      cidade: edtCidade.text,
                                      uf: edtUf.text,
                                      email: edtEmail.text,
                                      cep: edtCEP.text,
                                      status: 'Ativo'),
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
