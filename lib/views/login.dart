import 'package:flutter/material.dart';
import 'package:gestorloja/config/cores.dart';
import 'package:gestorloja/config/imagens.dart';
import 'package:gestorloja/config/variaveis.dart';
import 'package:gestorloja/model/http/http.client.dart';
import 'package:gestorloja/repository/login.repository.dart';
import 'package:gestorloja/store/login.store.dart';
import 'package:gestorloja/views/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var edtUser = TextEditingController();
  var edtPassword = TextEditingController();
  late LoginStore store;

  @override
  void initState() {
    store = LoginStore(
        repository: LoginRepository(client: HttpClient(), url: server));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.fundoFormulario,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width * .6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  spreadRadius: 2,
                  color: Color.fromRGBO(100, 105, 125, 1),
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ]),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .25,
                    height: MediaQuery.of(context).size.height * .7,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            Imagens.fundoLogo,
                          ),
                          fit: BoxFit.fitHeight),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(52, 55, 69, .95),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    width: MediaQuery.of(context).size.width * .25,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 96,
                            width: 96,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: SizedBox(
                              height: 32,
                              width: 32,
                              child: Image.asset(
                                Imagens.logoLogin,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'CENTRAL DEVS',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  decorationColor: Colors.cyan,
                                  decorationThickness: 2),
                            ),
                          ),
                          const Text(
                            'Gestor de lojas de calçados',
                            style: TextStyle(color: Colors.cyan),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .02,
                                right: MediaQuery.of(context).size.width * .03,
                                top: MediaQuery.of(context).size.height * .05),
                            child: Text(
                              'O nosso software é uma ferramenta completa para administrar estoques, fornecedores, '
                              'pedidos e clientes. Ele emite notas fiscais, integra meios de pagamento e oferece relatórios '
                              'detalhados sobre vendas e fluxo de caixa. Com uma interface intuitiva e suporte técnico especializado, '
                              'é ideal para otimizar operações e aumentar a produtividade de pequenas e médias empresas.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width == 1366
                                          ? 8
                                          : 14),
                            ),
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  'Versão: 1.0',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width ==
                                                  1366
                                              ? 8
                                              : 12),
                                ),
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: store.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .3,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width == 1366
                                          ? 0
                                          : 60),
                              child: const Text(
                                'Logar em Central Devs',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(52, 55, 69, 1),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .2,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width == 1366
                                          ? 0
                                          : 60),
                              child: const Text(
                                'Insira seus dados de login logo abaixo',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(100, 105, 125, 1),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * .2,
                              child: const Text(
                                'Entre com seu email.',
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .2,
                            child: TextFormField(
                              controller: edtUser,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  PhosphorIconsRegular.envelope,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromRGBO(199, 200, 209, 1),
                                      width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.cyan, width: 2),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * .2,
                              child: const Text(
                                'Entre com sua senha.',
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .2,
                            child: TextFormField(
                              obscureText: true,
                              controller: edtPassword,
                              decoration: InputDecoration(
                                prefixIcon:
                                    const Icon(PhosphorIconsRegular.lock),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromRGBO(199, 200, 209, 1),
                                      width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.cyan, width: 2),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50,
                                  width: 200,
                                  decoration: const BoxDecoration(
                                      color: Color.fromRGBO(52, 55, 69, 1)),
                                  child: InkWell(
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Entrar',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 2),
                                            ),
                                          ),
                                          Icon(
                                            PhosphorIconsRegular.uploadSimple,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () async {
                                      await store.getLogin(
                                          user: edtUser.text,
                                          password: edtPassword.text);
                                      if (store.state.value.isNotEmpty) {
                                        idUser =
                                            store.state.value[0].idcolaborador;
                                        nomeUser = store.state.value[0].nome;
                                        nivelacesso =
                                            store.state.value[0].userpermissoes;
                                        if (mounted) {
                                          Navigator.pushReplacement(
                                            context,
                                            PageTransition(
                                              child: const Home(),
                                              type: PageTransitionType
                                                  .bottomToTop,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                            ),
                                          );
                                        }
                                      } else {
                                        SnackBar snac = const SnackBar(
                                          showCloseIcon: true,
                                          dismissDirection:
                                              DismissDirection.startToEnd,
                                          content: Text(
                                            'Acesso Negado!',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Colors.red,
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snac);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
