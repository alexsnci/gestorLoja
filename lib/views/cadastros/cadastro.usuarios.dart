import 'package:flutter/material.dart';
import 'package:gestorloja/componentes/botao.ligth.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/model/usuarios.model.dart';
import 'package:gestorloja/repository/usuarios.repository.dart';
import 'package:gestorloja/store/usuarios.store.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CadastroUsuarios extends StatefulWidget {
  const CadastroUsuarios({super.key});

  @override
  State<CadastroUsuarios> createState() => _CadastroUsuariosState();
}

class _CadastroUsuariosState extends State<CadastroUsuarios> {
  var edtNome = TextEditingController();
  var edtNomeUser = TextEditingController();
  var edtPassword = TextEditingController();
  var edtNivelAcesso = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  late UsuariosStore store;

  @override
  void initState() {
    store = UsuariosStore(
      repository: UsuariosRepository(client: HttpClient(), url: server),
    );
    super.initState();
  }

  List<DropdownMenuEntry<String>> dropdownNivel = [
    const DropdownMenuEntry(
      value: '1',
      label: 'Administrador',
    ),
    const DropdownMenuEntry(
      value: '2',
      label: 'Caixa',
    ),
    const DropdownMenuEntry(
      value: '3',
      label: 'Vendedor',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 88, 143),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Cadastro de Usuarios',
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
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Dados do usuário',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .2,
                        child: TextFormField(
                          controller: edtNome,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campoobrigatório';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              label:
                                  Text('Entre com o nome completo do usuário'),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .2,
                        child: TextFormField(
                          controller: edtNomeUser,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              label:
                                  Text('Entre com o nome de acesso ao sistema'),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .2,
                        child: TextFormField(
                          obscureText: true,
                          controller: edtPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              label: Text('Entre com a senha'),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .2,
                        child: TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            } else if (value != edtPassword.text) {
                              return 'As senhas não conferem';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              label: Text('Repita a senha'),
                              border: OutlineInputBorder()),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .3,
                          child: DropdownMenu(
                            enableFilter: true,
                            controller: edtNivelAcesso,
                            width: MediaQuery.of(context).size.width * .3,
                            dropdownMenuEntries: dropdownNivel,
                            label: const Text(
                              'Permissão de acesso',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BotaoLigth(
                              icone: const Icon(PhosphorIconsRegular.upload),
                              texto: const Text('Salvar'),
                              onClick: () async {
                                if (_keyForm.currentState!.validate() &&
                                    edtNivelAcesso.text.isNotEmpty) {
                                  await store.postUsuario(dados: [
                                    UsuariosModel(
                                        id: 0,
                                        idcolaborador: 0,
                                        nome: edtNome.text,
                                        username: edtNomeUser.text,
                                        userpassword: edtPassword.text,
                                        status: 'Ativo',
                                        userpermissoes: edtNivelAcesso.text ==
                                                'Administrador'
                                            ? 1
                                            : edtNivelAcesso.text == 'Caixa'
                                                ? 2
                                                : 3)
                                  ]);

                                  if (mounted) {
                                    SnackBar snac = SnackBar(
                                      content: Text(store.post.value),
                                      backgroundColor: Colors.blue,
                                      showCloseIcon: true,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snac);
                                    Navigator.pop(context);
                                  }
                                }
                              })
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
