import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:gestorloja/componentes/botao.ligth.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/model/promocoes.model.dart';
import 'package:gestorloja/repository/estoque.repository.dart';
import 'package:gestorloja/repository/fornecedores.repository.dart';
import 'package:gestorloja/repository/promocoes.repository.dart';
import 'package:gestorloja/store/estoque.store.dart';
import 'package:gestorloja/store/fornecedores.store.dart';
import 'package:gestorloja/store/promocoes.store.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CadastroPromocoes extends StatefulWidget {
  const CadastroPromocoes({super.key});

  @override
  State<CadastroPromocoes> createState() => _CadastroPromocoesState();
}

class _CadastroPromocoesState extends State<CadastroPromocoes> {
  final _formkey = GlobalKey<FormState>();
  var edtProduto = TextEditingController();
  var edtFornecedor = TextEditingController();
  var edtValorAquisicao =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  var edtMargemLucro = TextEditingController();
  var edtValorVenda =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  var edtQuantidadeAtual = TextEditingController();
  var edtQuantidadeMinima = TextEditingController();
  var edtPorcentagemDesconto = TextEditingController();
  var edtValorDesconto = TextEditingController();
  var edtNovoValor = TextEditingController();

  var formatoPorcentagem = NumberFormat('###.0#');
  var real = NumberFormat.currency(symbol: '');

  late DateTime dataInicio = DateTime.now();
  late DateTime dtEntrada = DateTime.now();

  var edtDataInicial = TextEditingController();
  var edtDataFinal = TextEditingController();

  List<DropdownMenuEntry<String>> dropdownProdutos = [];
  List<DropdownMenuEntry<String>> dropdownFornecedores = [];

  late EstoqueStore store;
  late PromocoesStore storePromocoes;

  late FornecedoresStore storeFornecedores;

  @override
  void initState() {
    store = EstoqueStore(
      repository: EstoqueRepository(client: HttpClient(), url: server),
    );

    storePromocoes = PromocoesStore(
        repository: PromocoesRepository(client: HttpClient(), url: server));
    storeFornecedores = FornecedoresStore(
      repository: FornecedoresRepository(client: HttpClient(), url: server),
    );
    _getListas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      appBar: AppBar(
        backgroundColor: Cores.fundoFormulario,
        title: const Text('Promoções'),
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
                          Icon(PhosphorIconsRegular.barcode),
                          Text('Dados do produto')
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .25,
                          child: DropdownMenu(
                            onSelected: _selecionarProduto,
                            enableFilter: true,
                            controller: edtProduto,
                            width: MediaQuery.of(context).size.width * .2,
                            dropdownMenuEntries: dropdownProdutos,
                            label: const Text(
                              'Escolha a produto',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .1,
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
                          width: MediaQuery.of(context).size.width * .1,
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
                                label: Text('Margem de lucro')),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .1,
                          child: TextFormField(
                            onChanged: (value) {
                              if (edtValorAquisicao.text.isNotEmpty) {
                                edtMargemLucro.text =
                                    '${formatoPorcentagem.format((double.parse(value.replaceAll(',', '.')) / double.parse(edtValorAquisicao.text.replaceAll(',', '.')) - 1) * 100)}%';
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
                                label: Text('Valor de venda')),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .1,
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
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Row(
                        children: [
                          Icon(PhosphorIconsRegular.currencyDollar),
                          Text('Valores'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .1,
                            child: TextFormField(
                              onChanged: (value) {
                                if (edtValorVenda.text.isNotEmpty) {
                                  edtNovoValor.text = real.format(double.parse(
                                          edtValorVenda.text
                                              .replaceAll(',', '.')) -
                                      ((double.parse(
                                                  value.replaceAll(',', '.')) /
                                              100) *
                                          double.parse(edtValorVenda.text
                                              .replaceAll(',', '.'))));
                                  edtValorDesconto.text = real.format(
                                      double.parse(edtValorVenda.text
                                              .replaceAll(',', '.')) -
                                          double.parse(edtNovoValor.text
                                              .replaceAll(',', '.')));
                                }
                              },
                              controller: edtPorcentagemDesconto,
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
                                label: Text('Desconto porcentagem'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * .1,
                              child: TextFormField(
                                controller: edtValorDesconto,
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
                                  label: Text('Valor desconto'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * .1,
                              child: TextFormField(
                                onChanged: (value) {
                                  if (edtValorVenda.text.isNotEmpty) {
                                    edtPorcentagemDesconto.text =
                                        '${formatoPorcentagem.format((double.parse(value.replaceAll(',', '.')) / double.parse(edtValorVenda.text.replaceAll(',', '.')) - 1).abs() * 100)}%';

                                    edtValorDesconto.text = real.format(
                                        double.parse(edtValorVenda.text
                                                .replaceAll(',', '.')) -
                                            double.parse(
                                                value.replaceAll(',', '.')));
                                  }
                                },
                                controller: edtNovoValor,
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
                                  label: Text('Novo valor de venda'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(PhosphorIconsRegular.calendar),
                            Text('Datas')
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .1,
                              child: TextFormField(
                                controller: edtDataInicial,
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
                                  label: Text('Data de início'),
                                ),
                                onTap: () async {
                                  final DateTime? dateTime =
                                      await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(3000),
                                    initialDate: dataInicio,
                                    builder: (context, child) => Theme(
                                        data: ThemeData().copyWith(
                                          colorScheme: const ColorScheme.dark(
                                            primary:
                                                Color.fromRGBO(0, 92, 141, 1),
                                          ),
                                        ),
                                        child: child!),
                                  );
                                  if (dateTime != null) {
                                    setState(() {
                                      late DateTime agora = DateTime.now();

                                      if (dateTime.compareTo(agora) < 0) {
                                        dataInicio = DateTime.now();
                                        dtEntrada = dataInicio;
                                      } else {
                                        dataInicio = dateTime;
                                        dtEntrada = dataInicio;
                                      }

                                      String dia = dataInicio.day.toString();
                                      String mes = dataInicio.month.toString();
                                      String ano = dataInicio.year.toString();
                                      edtDataInicial.text =
                                          '${dia.padLeft(2, '0')}/${mes.padLeft(2, '0')}/$ano';
                                    });
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .1,
                                child: TextFormField(
                                  controller: edtDataFinal,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(199, 200, 209, 1),
                                          width: 2),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    label: Text('Data de término'),
                                  ),
                                  onTap: () async {
                                    final DateTime? dateTime1 =
                                        await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(3000),
                                      initialDate: dataInicio,
                                      builder: (context, child) => Theme(
                                          data: ThemeData().copyWith(
                                            colorScheme: const ColorScheme.dark(
                                              primary:
                                                  Color.fromRGBO(0, 92, 141, 1),
                                            ),
                                          ),
                                          child: child!),
                                    );
                                    if (dateTime1 != null) {
                                      setState(() {
                                        late DateTime agora = DateTime.now();

                                        if (dateTime1.compareTo(agora) < 0) {
                                          dataInicio = DateTime.now();
                                          dtEntrada = dataInicio;
                                        } else {
                                          dataInicio = dateTime1;
                                          dtEntrada = dataInicio;
                                        }

                                        String dia = dataInicio.day.toString();
                                        String mes =
                                            dataInicio.month.toString();
                                        String ano = dataInicio.year.toString();
                                        edtDataFinal.text =
                                            '${dia.padLeft(2, '0')}/${mes.padLeft(2, '0')}/$ano';
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
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
                              await storePromocoes.postPromocoes(
                                dados: [
                                  PromocoesModel(
                                    id: 0,
                                    idestoque: idEstoque,
                                    datafim: edtDataFinal.text,
                                    datainicio: edtDataInicial.text,
                                    porcentagem: double.parse(
                                        edtPorcentagemDesconto.text
                                            .replaceAll(',', '.')),
                                    status: 'Ativa',
                                    valor: double.parse(
                                        edtNovoValor.text.replaceAll(',', '.')),
                                    valoratual: double.parse(edtValorVenda.text
                                        .replaceAll(',', '.')),
                                    valordesconto: double.parse(edtValorDesconto
                                        .text
                                        .replaceAll(',', '.')),
                                    cor: '',
                                    modelo: '',
                                    produto: '',
                                    setor: '',
                                    tamanho: '',
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
    await store.getEstoque(nome: '');
    if (mounted) {
      dropdownProdutos = List.generate(
        store.state.value.length,
        (index) => DropdownMenuEntry(
          value: store.state.value[index].id.toString(),
          label: store.state.value[index].produto,
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

  _selecionarProduto(value) async {
    await store.getEstoque(nome: edtProduto.text);
    if (store.state.value.isNotEmpty) {
      edtValorAquisicao.text = real.format(store.state.value[0].valoraquisicao);
      edtMargemLucro.text =
          formatoPorcentagem.format(store.state.value[0].margemlucro);
      edtValorVenda.text = real.format(store.state.value[0].valorvenda);
      edtQuantidadeAtual.text =
          formatoPorcentagem.format(store.state.value[0].quantidadeatual);
    }

    idEstoque = int.parse(value);
  }
}
