import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:gestorloja/componentes/botao.ligth.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/estoque.model.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/repository/categorias.repository.dart';
import 'package:gestorloja/repository/estoque.repository.dart';
import 'package:gestorloja/repository/fornecedores.repository.dart';
import 'package:gestorloja/repository/marcas.repository.dart';
import 'package:gestorloja/repository/setores.repository.dart';
import 'package:gestorloja/store/categorias.store.dart';
import 'package:gestorloja/store/estoque.store.dart';
import 'package:gestorloja/store/fornecedores.store.dart';
import 'package:gestorloja/store/marcas.store.dart';
import 'package:gestorloja/store/setores.store.dart';
import 'package:gestorloja/views/cadastros/cadastro.categorias.dart';
import 'package:gestorloja/views/cadastros/cadastro.marcas.dart';
import 'package:gestorloja/views/cadastros/cadastro.setor.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CadastroEstoque extends StatefulWidget {
  const CadastroEstoque({super.key});

  @override
  State<CadastroEstoque> createState() => _CadastroEstoqueState();
}

class _CadastroEstoqueState extends State<CadastroEstoque> {
  final _formkey = GlobalKey<FormState>();
  var edtProduto = TextEditingController();
  var edtFornecedor = TextEditingController();
  var edtValorAquisicao =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  var edtMargemLucro = TextEditingController();
  var edtValorVenda =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  var edtQuantidadeAtual = TextEditingController();
  var edtCodigobarras = TextEditingController();
  var edtQuantidadeMinima = TextEditingController();
  var edtCategoria = TextEditingController();
  var edtModelo = TextEditingController();
  var edtCor = TextEditingController();
  var edtTamanho = TextEditingController();
  var edtSetor = TextEditingController();
  var edtDescricao = TextEditingController();

  List<DropdownMenuEntry<String>> dropdownCategorias = [];
  List<DropdownMenuEntry<String>> dropdownSetores = [];

  var formatoPorcentagem = NumberFormat('###.0#');

  List<DropdownMenuEntry<String>> dropdownProdutos = [];
  List<DropdownMenuEntry<String>> dropdownFornecedores = [];

  late EstoqueStore store;

  @override
  void initState() {
    store = EstoqueStore(
      repository: EstoqueRepository(client: HttpClient(), url: server),
    );
    _getListas();
    _getCategorias();
    _getSetores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 21, 88, 143),
        title: const Text(
          'CADASTRO DE PRODUTOS',
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
                          Text('Dados do produto')
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .19,
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
                                label: Text('Descrição do produto')),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .2,
                          child: Row(
                            children: [
                              DropdownMenu(
                                enableFilter: true,
                                controller: edtProduto,
                                width: MediaQuery.of(context).size.width * .15,
                                dropdownMenuEntries: dropdownProdutos,
                                label: const Text(
                                  'Escolha a Marca do produto',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                          child: const CadastroProdutos(),
                                          type: PageTransitionType.rightToLeft),
                                    ).whenComplete(
                                      () async {
                                        await _getListas();
                                        setState(() {});
                                      },
                                    );
                                  },
                                  icon: const Icon(PhosphorIconsRegular.plus),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .19,
                          child: TextFormField(
                            controller: edtCodigobarras,
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
                                    'Entre com o código de barras do produto')),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .19,
                          child: DropdownMenu(
                            enableFilter: true,
                            controller: edtFornecedor,
                            width: MediaQuery.of(context).size.width * .2,
                            dropdownMenuEntries: dropdownFornecedores,
                            label: const Text(
                              'Escolha o fornecedor',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
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
                            controller: edtModelo,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(199, 200, 209, 1),
                                      width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                label: Text('Modelo do produto')),
                          ),
                        ),
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
                            controller: edtCor,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(199, 200, 209, 1),
                                      width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                label: Text('Cor do produto')),
                          ),
                        ),
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
                            controller: edtTamanho,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(199, 200, 209, 1),
                                      width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                label: Text('Tamanho do produto')),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .15,
                          child: TextFormField(
                            controller: edtQuantidadeAtual,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(199, 200, 209, 1),
                                      width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                label: Text('Quantidade Atual')),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .15,
                          child: TextFormField(
                            controller: edtQuantidadeMinima,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(199, 200, 209, 1),
                                      width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                label: Text('Quantidade mínima do produto')),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              children: [
                                DropdownMenu(
                                  enableFilter: true,
                                  controller: edtCategoria,
                                  width: MediaQuery.of(context).size.width * .2,
                                  dropdownMenuEntries: dropdownCategorias,
                                  label: const Text(
                                    'Escolha a categoria',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                            child: const CadastroCategorias(),
                                            type:
                                                PageTransitionType.rightToLeft),
                                      ).whenComplete(
                                        () async {
                                          await _getCategorias();
                                          setState(() {});
                                        },
                                      );
                                    },
                                    icon: const Icon(PhosphorIconsRegular.plus),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              children: [
                                DropdownMenu(
                                  enableFilter: true,
                                  controller: edtSetor,
                                  width: MediaQuery.of(context).size.width * .2,
                                  dropdownMenuEntries: dropdownSetores,
                                  label: const Text(
                                    'Escolha o Setor do produto',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                            child: const CadastroSetores(),
                                            type:
                                                PageTransitionType.rightToLeft),
                                      ).whenComplete(
                                        () async {
                                          await _getSetores();
                                          setState(() {});
                                        },
                                      );
                                    },
                                    icon: const Icon(PhosphorIconsRegular.plus),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(PhosphorIconsRegular.currencyDollar),
                            Text('Valores')
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .2,
                          child: TextFormField(
                            onChanged: (value) {
                              if (edtMargemLucro.text.isNotEmpty ||
                                  edtValorVenda.text != '0,00') {}
                            },
                            controller: edtValorAquisicao,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(199, 200, 209, 1),
                                      width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                label: Text('Valor de compra')),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .2,
                          child: TextFormField(
                            onChanged: (value) {
                              if (edtValorAquisicao.text != '0,00') {
                                double valorCompra = double.parse(
                                    edtValorAquisicao.text
                                        .replaceAll(',', '.'));
                                double porcentagem =
                                    double.parse(value.replaceAll(',', '.')) /
                                        100;
                                double valorVenda =
                                    ((valorCompra * porcentagem) +
                                            valorCompra) *
                                        100;
                                edtValorVenda.text = valorVenda.toString();
                              }
                            },
                            controller: edtMargemLucro,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(199, 200, 209, 1),
                                      width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                label: Text('entre com a margem de lucro')),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .2,
                          child: TextFormField(
                            onChanged: (value) {
                              if (edtValorAquisicao.text.isNotEmpty) {
                                edtMargemLucro.text = formatoPorcentagem.format(
                                    (double.parse(value.replaceAll(',', '.')) /
                                                double.parse(edtValorAquisicao
                                                    .text
                                                    .replaceAll(',', '.')) -
                                            1) *
                                        100);
                              }
                            },
                            controller: edtValorVenda,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(199, 200, 209, 1),
                                      width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                label: Text('Entre com o valor de venda')),
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
                              await store.postEstoque(
                                dados: [
                                  EstoqueModel(
                                    id: 0,
                                    idmarca: 0,
                                    idfornecedor: 0,
                                    produto: edtProduto.text,
                                    fornecedor: edtFornecedor.text,
                                    codigobarras: edtCodigobarras.text,
                                    valoraquisicao: double.parse(
                                        edtValorAquisicao.text
                                            .replaceAll(',', '.')),
                                    margemlucro: double.parse(edtMargemLucro
                                        .text
                                        .replaceAll(',', '.')),
                                    valorvenda: double.parse(edtValorVenda.text
                                        .replaceAll(',', '.')),
                                    quantidadeatual:
                                        double.parse(edtQuantidadeAtual.text),
                                    quantidademinima:
                                        double.parse(edtQuantidadeMinima.text),
                                    categoria: edtCategoria.text,
                                    cor: edtCor.text,
                                    modelo: edtModelo.text,
                                    tamanho: edtTamanho.text,
                                    setor: edtSetor.text,
                                    idcategoria: 0,
                                    descricao: edtDescricao.text,
                                    idusuario: idUser,
                                  )
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

  _getListas() async {
    ProdutosStore storeProdutos = ProdutosStore(
        repository: ProdutosRepository(client: HttpClient(), url: server));

    FornecedoresStore storeFornecedores = FornecedoresStore(
      repository: FornecedoresRepository(client: HttpClient(), url: server),
    );
    await storeProdutos.getProdutos(nome: '');
    if (mounted) {
      dropdownProdutos = List.generate(
        storeProdutos.state.value.length,
        (index) => DropdownMenuEntry(
          value: storeProdutos.state.value[index].id.toString(),
          label: storeProdutos.state.value[index].descricao,
        ),
      );
    }

    await storeFornecedores.getFornecedores(nome: '');

    if (mounted) {
      dropdownFornecedores = List.generate(
        storeFornecedores.state.value.length,
        (index) => DropdownMenuEntry(
          value: storeFornecedores.state.value[index].id.toString(),
          label: storeFornecedores.state.value[index].razaosocial,
        ),
      );
    }

    setState(() {});
  }

  _getCategorias() async {
    CategoriasStore store = CategoriasStore(
        repository: CategoriasRepository(client: HttpClient(), url: server));
    await store.getCategorias(nome: '');
    if (mounted) {
      dropdownCategorias = List.generate(
        store.state.value.length,
        (index) => DropdownMenuEntry(
          value: store.state.value[index].id.toString(),
          label: store.state.value[index].descricao,
        ),
      );
      setState(() {});
    }
  }

  _getSetores() async {
    SetoresStore storeSetor = SetoresStore(
        repository: SetoresRepository(client: HttpClient(), url: server));
    await storeSetor.getSetores(nome: '');
    if (mounted) {
      dropdownSetores = List.generate(
        storeSetor.state.value.length,
        (index) => DropdownMenuEntry(
          value: storeSetor.state.value[index].id.toString(),
          label: storeSetor.state.value[index].descricao,
        ),
      );
      setState(() {});
    }
  }
}
