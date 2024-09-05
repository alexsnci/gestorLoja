// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gestorloja/componentes/botao.ligth.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/variaveis.dart';

import 'package:gestorloja/model/estoque.model.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/repository/estoque.repository.dart';
import 'package:gestorloja/store/estoque.store.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AtualizarEstoque extends StatefulWidget {
  final EstoqueModel produto;
  const AtualizarEstoque({
    super.key,
    required this.produto,
  });

  @override
  State<AtualizarEstoque> createState() => _AtualizarEstoqueState();
}

class _AtualizarEstoqueState extends State<AtualizarEstoque> {
  var edtQuantidade = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late EstoqueStore store;

  @override
  void initState() {
    store = EstoqueStore(
        repository: EstoqueRepository(client: HttpClient(), url: server));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 88, 143),
        title: const Text(
          'Atualizar a quantidade do produto',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * .8,
          width: MediaQuery.of(context).size.width * .9,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(PhosphorIconsRegular.shoppingBag),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                          '${widget.produto.descricao} ${widget.produto.produto} ${widget.produto.modelo} ${widget.produto.cor} ${widget.produto.tamanho} Estoque atual: ${widget.produto.quantidadeatual}'),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            onEditingComplete: () {
                              setState(() {});
                            },
                            controller: edtQuantidade,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo obrigatório';
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                                label: Text('Entre com a nova quantidade'),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                              'Quantidade após a atualização: ${widget.produto.quantidadeatual + (edtQuantidade.text.isEmpty ? 0 : int.parse(edtQuantidade.text))}'),
                        ),
                        SizedBox(
                          width: 130,
                          child: BotaoLigth(
                              icone: const Icon(PhosphorIconsRegular.upload),
                              texto: const Text('Atualizar'),
                              onClick: () async {
                                if (_formKey.currentState!.validate()) {
                                  await store.atualizaEstoque(
                                      idproduto: widget.produto.id,
                                      quantidade:
                                          (widget.produto.quantidadeatual +
                                              int.parse(edtQuantidade.text)));
                                  if (mounted) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          'Produto atualizado com sucesso'),
                                      backgroundColor: Colors.green,
                                      showCloseIcon: true,
                                    ));

                                    Navigator.pop(context);
                                  }
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
