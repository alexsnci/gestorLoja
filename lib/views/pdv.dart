import 'package:flutter/material.dart';
import 'package:gestorloja/componentes/botao.ligth.dart';
import 'package:gestorloja/componentes/card.itens.pedido.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/model/itens.venda.model.dart';
import 'package:gestorloja/model/venda.model.dart';
import 'package:gestorloja/repository/caixa.repository.dart';
import 'package:gestorloja/repository/categorias.repository.dart';
import 'package:gestorloja/repository/clientes.repository.dart';
import 'package:gestorloja/repository/estoque.repository.dart';
import 'package:gestorloja/repository/itens.venda.repository.dart';
import 'package:gestorloja/repository/marcas.repository.dart';
import 'package:gestorloja/repository/venda.repository.dart';
import 'package:gestorloja/store/caixa.store.dart';
import 'package:gestorloja/store/categorias.store.dart';
import 'package:gestorloja/store/clientes.store.dart';
import 'package:gestorloja/store/estoque.store.dart';
import 'package:gestorloja/store/itens.venda.store.dart';
import 'package:gestorloja/store/marcas.store.dart';
import 'package:gestorloja/store/venda.store.dart';
import 'package:gestorloja/views/finalizar.venda.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PDV extends StatefulWidget {
  const PDV({super.key});

  @override
  State<PDV> createState() => _PDVState();
}

class _PDVState extends State<PDV> {
  late CategoriasStore storecategorias;
  late ProdutosStore storeprodutos;
  late ClientesStore storeclientes;
  late CaixaStore storecaixa;
  late EstoqueStore storeestoque;
  late VendaStore storevenda;
  late ItensVendaStore storeitensvenda;
  var edtPesquisa = TextEditingController();

  var real = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  void initState() {
    storecategorias = CategoriasStore(
      repository: CategoriasRepository(client: HttpClient(), url: server),
    );
    storeprodutos = ProdutosStore(
      repository: ProdutosRepository(client: HttpClient(), url: server),
    );
    storeclientes = ClientesStore(
      repository: ClientesRepository(client: HttpClient(), url: server),
    );
    storecaixa = CaixaStore(
      repository: CaixaRepository(client: HttpClient(), url: server),
    );
    storeestoque = EstoqueStore(
        repository: EstoqueRepository(client: HttpClient(), url: server));

    storevenda = VendaStore(
      repository: VendaRepository(client: HttpClient(), url: server),
    );
    storeitensvenda = ItensVendaStore(
      repository: ItensVendaRepository(client: HttpClient(), url: server),
    );

    _getCategorias();
    _getProdutos();
    _getEstoque();
    _verificarStatusVenda();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromRGBO(51, 54, 69, 1),
        title: const Text(
          'Lynda Store - PDV',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                PhosphorIconsRegular.list,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: TextFormField(
                    onEditingComplete: () async {
                      await storeestoque.getEstoqueProduto(
                          valor: edtPesquisa.text);
                      setState(() {});
                    },
                    controller: edtPesquisa,
                    decoration: InputDecoration(
                      hintText: 'Entre com o nome do produto',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(199, 200, 209, 1), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(51, 53, 69, 1), width: 2),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: AnimatedBuilder(
                    animation: Listenable.merge([
                      storeestoque.erro,
                      storeestoque.isLoading,
                      storeestoque.state
                    ]),
                    builder: (context, child) {
                      if (storeestoque.isLoading.value) {
                        const CircularProgressIndicator();
                      }

                      if (storeestoque.erro.value.isNotEmpty) {
                        return Center(
                          child: Text(storeestoque.erro.value),
                        );
                      }

                      if (storeestoque.state.value.isEmpty) {
                        return const Center(
                          child: Text('Nenhum produto localizado'),
                        );
                      } else {
                        return GridView.builder(
                          padding: const EdgeInsets.all(5),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5),
                          itemCount: storeestoque.state.value.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () async {
                                  if (storeestoque
                                          .state.value[index].quantidadeatual ==
                                      0) {
                                    SnackBar snac = const SnackBar(
                                      content: Text(
                                          'Não é possível prosseguir com o pedido! Produto sem estoque!'),
                                      backgroundColor: Colors.red,
                                      showCloseIcon: true,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snac);
                                  } else {
                                    if (idpedido == 0) {
                                      await storevenda.postVenda(dados: [
                                        VendaModel(
                                            id: 0,
                                            idcliente: 1,
                                            idcolaborador: idUser,
                                            idloja: 1,
                                            data: '',
                                            status: 'Pendente',
                                            tipo: 'L',
                                            valorcompra: 0),
                                      ]);
                                      idpedido =
                                          int.parse(storevenda.post.value);
                                      await storeitensvenda
                                          .postItensVenda(dados: [
                                        ItensVendaModel(
                                          id: 0,
                                          idvenda: idpedido,
                                          idproduto: storeestoque
                                              .state.value[index].id,
                                          obs: '',
                                          valor: storeestoque
                                              .state.value[index].valorvenda,
                                          quantidade: 1,
                                          subtotal: storeestoque
                                              .state.value[index].valorvenda,
                                          produto: '',
                                          marca: '',
                                          cor: '',
                                          tamanho: '',
                                        )
                                      ]);
                                      await _getItensPedido(idPedido: idpedido);
                                      await _getEstoque();
                                      await storevenda.getVenda(id: idpedido);
                                    } else {
                                      await storeitensvenda
                                          .postItensVenda(dados: [
                                        ItensVendaModel(
                                          id: 0,
                                          idvenda: idpedido,
                                          idproduto: storeestoque
                                              .state.value[index].id,
                                          obs: '',
                                          valor: storeestoque
                                              .state.value[index].valorvenda,
                                          quantidade: 1,
                                          subtotal: storeestoque
                                              .state.value[index].valorvenda,
                                          produto: '',
                                          marca: '',
                                          cor: '',
                                          tamanho: '',
                                        )
                                      ]);

                                      await _getItensPedido(idPedido: idpedido);
                                      await _getEstoque();
                                      await storevenda.getVenda(id: idpedido);
                                    }
                                    setState(() {});
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            const Color.fromRGBO(52, 55, 69, 1),
                                        child: Text(
                                          '${storeestoque.state.value[index].quantidadeatual}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      Text(
                                        '${storeestoque.state.value[index].produto} ${storeestoque.state.value[index].modelo} ${storeestoque.state.value[index].cor} ${storeestoque.state.value[index].tamanho}',
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(real.format(storeestoque
                                          .state.value[index].valorvenda)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * .2,
                      child: AnimatedBuilder(
                        animation: Listenable.merge([
                          storecategorias.erro,
                          storecategorias.isLoading,
                          storecategorias.state,
                        ]),
                        builder: (context, child) {
                          if (storecategorias.isLoading.value) {
                            return const Center(
                              child: SizedBox(
                                height: 128,
                                width: 128,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          if (storecategorias.erro.value.isNotEmpty) {
                            return Center(
                              child: Text(storecategorias.erro.value),
                            );
                          }

                          if (storecategorias.state.value.isEmpty) {
                            return const Center(
                              child: Text('Nenhum registro localizado'),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: storecategorias.state.value.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .1,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      border: Border.all(
                                          color: Colors.blueGrey,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        await storeestoque
                                            .getEstoquePorCategoria(
                                                id: storecategorias
                                                    .state.value[index].id);
                                        setState(() {});
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            storecategorias
                                                .state.value[index].descricao,
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      )),
                )
              ],
            ),
          ),
          storeitensvenda.state.value.isNotEmpty
              ? Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  width: MediaQuery.of(context).size.width * .25,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Carrinho de compras',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width > 1366
                                  ? 150
                                  : 100,
                              child: Text(
                                'PRODUTO',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width > 1366
                                            ? 14
                                            : 8),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width > 1366
                                  ? 70
                                  : 40,
                              child: Text(
                                'QTD',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width > 1366
                                            ? 14
                                            : 8),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width > 1366
                                  ? 50
                                  : 40,
                              child: Text(
                                'V.UNIT',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width > 1366
                                            ? 14
                                            : 8),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width > 1366
                                  ? 100
                                  : 80,
                              child: Text(
                                'SUB. TOTAL',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width > 1366
                                            ? 14
                                            : 8),
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: AnimatedBuilder(
                          animation: Listenable.merge([
                            storeitensvenda.erro,
                            storeitensvenda.isLoading,
                            storeitensvenda.state
                          ]),
                          builder: (context, child) {
                            if (storeitensvenda.isLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (storeitensvenda.erro.value != '') {
                              return Center(
                                child: Text(storeitensvenda.erro.value),
                              );
                            }

                            if (storeitensvenda.state.value.isEmpty) {
                              return const Center(
                                child: Text('Nenhum registro localizado!'),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: storeitensvenda.state.value.length,
                                itemBuilder: (context, index) {
                                  Color color = index.isOdd
                                      ? const Color.fromARGB(251, 240, 240, 228)
                                      : Colors.white;
                                  return CardItensPedido(
                                    item: storeitensvenda.state.value[index],
                                    adicionar: () {
                                      _adicionartem(
                                          idproduto: storeitensvenda
                                              .state.value[index].idproduto,
                                          idvenda: storeitensvenda
                                              .state.value[index].idvenda);
                                    },
                                    remover: () {
                                      _removeritem(
                                          idproduto: storeitensvenda
                                              .state.value[index].idproduto,
                                          idvenda: storeitensvenda
                                              .state.value[index].idvenda);
                                    },
                                    cor: color,
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: BotaoLigth(
                            icone: const Icon(PhosphorIconsRegular.prohibit),
                            texto: const Text('Cancelar Pedido'),
                            onClick: () async {
                              AlertDialog aviso = AlertDialog(
                                title: const Text('Aviso!'),
                                content: const SizedBox(
                                  height: 150,
                                  width: 100,
                                  child: Center(
                                    child: Text(
                                        'Você deseja cancelar o pedido atual?'),
                                  ),
                                ),
                                actions: [
                                  TextButton.icon(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await storevenda.statusVenda(
                                          idcolaborador: idUser);
                                      await storevenda.cancelarVenda(
                                          idvenda: int.parse(
                                              storevenda.status.value));
                                      idpedido = 0;
                                      await _getEstoque();
                                      await _getItensPedido(
                                          idPedido: int.parse(
                                              storevenda.status.value));
                                      setState(() {});
                                    },
                                    label: const Text('Sim'),
                                    icon: const Icon(
                                        PhosphorIconsRegular.xCircle),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    label: const Text('Não'),
                                    icon:
                                        const Icon(PhosphorIconsRegular.check),
                                  )
                                ],
                              );

                              showDialog(
                                  context: context,
                                  builder: (context) => aviso);
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: FinalizarVenda(
                                    pedido: storevenda.state.value[0]),
                                type: PageTransitionType.rightToLeft,
                                duration: const Duration(milliseconds: 500),
                              ),
                            ).whenComplete(
                              () async {
                                await _getItensPedido(idPedido: idpedido);
                                setState(() {});
                              },
                            );
                          },
                          child: Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AnimatedBuilder(
                                animation: Listenable.merge([
                                  storevenda.isLoading,
                                  storevenda.erro,
                                  storevenda.state
                                ]),
                                builder: (context, child) {
                                  if (storevenda.isLoading.value) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (storevenda.state.value.isEmpty) {
                                    return const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Total do Pedido:'),
                                          Text('R\$ 0,00')
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Valor do Pedido:'),
                                          Text(real.format(storevenda
                                              .state.value[0].valorcompra))
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  _getCategorias() async {
    await storecategorias.getCategorias(nome: '');
  }

  _getProdutos() async {
    await storeprodutos.getProdutos(nome: '');
  }

  _getEstoque() async {
    await storeestoque.getEstoque(nome: '');
  }

  _getItensPedido({required int idPedido}) async {
    await storeitensvenda.getItensVenda(id: idPedido);
  }

  _removeritem({required int idproduto, required int idvenda}) async {
    await storeitensvenda.removeritem(idproduto: idproduto, idvenda: idvenda);
    if (mounted) {
      await _getItensPedido(idPedido: idvenda);
      await _getEstoque();
      await storevenda.getVenda(id: idvenda);
      setState(() {});
    }
  }

  _adicionartem({required int idproduto, required int idvenda}) async {
    await storeitensvenda.adicionaritem(idproduto: idproduto, idvenda: idvenda);
    if (mounted) {
      await _getItensPedido(idPedido: idvenda);
      await _getEstoque();
      await storevenda.getVenda(id: idvenda);
    }
  }

  _verificarStatusVenda() async {
    await storevenda.statusVenda(idcolaborador: idUser);
    if (storevenda.status.value != '0') {
      AlertDialog dialogF = AlertDialog(
        backgroundColor: Colors.cyan,
        title: const Center(
          child: Text(
            'Aviso',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(52, 55, 69, 1)),
          ),
        ),
        content: const SizedBox(
          height: 150,
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Existe um pedido que ainda não foi finalizado, o que deseja dazer com ele?',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(52, 55, 69, 1)),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await storevenda.cancelarVenda(
                  idvenda: int.parse(storevenda.status.value));
              idpedido = 0;
              await _getEstoque();
              await _getItensPedido(
                  idPedido: int.parse(storevenda.status.value));
              if (mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text(
              'Excluir',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              idpedido = int.parse(storevenda.status.value);
              await _getItensPedido(idPedido: idpedido);
              await storevenda.getVenda(id: idpedido);
              setState(() {});
            },
            child: const Text(
              'Continuar com o pedido',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
      showDialog(
        context: context,
        builder: (context) => dialogF,
      );
    }
  }
}
