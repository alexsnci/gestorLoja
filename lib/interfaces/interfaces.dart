import 'dart:io';

import 'package:gestorloja/model/caixa.model.dart';
import 'package:gestorloja/model/categorias.model.dart';
import 'package:gestorloja/model/cep.model.dart';
import 'package:gestorloja/model/clilentes.model.dart';
import 'package:gestorloja/model/estoque.model.dart';
import 'package:gestorloja/model/fechamento.caixa.model.dart';
import 'package:gestorloja/model/fornecedores.model.dart';
import 'package:gestorloja/model/itens.venda.model.dart';
import 'package:gestorloja/model/login.model.dart';
import 'package:gestorloja/model/marcas.model.dart';
import 'package:gestorloja/model/movimentacao.caixa.model.dart';
import 'package:gestorloja/model/pagamentos.pedidos.model.dart';
import 'package:gestorloja/model/promocoes.model.dart';
import 'package:gestorloja/model/setores.model.dart';
import 'package:gestorloja/model/usuarios.model.dart';
import 'package:gestorloja/model/venda.model.dart';

abstract class IHttpClient {
  Future get({required String url, required String endpoint});
  Future post(
      {required String url, required String data, required String endpoint});
  Future delete({required String url, required String endpoint});
  Future put(
      {required String url, required String data, required String endpoint});
  Future upload({required url, required String endpoint, required File img});
}

abstract class IClientes {
  Future<List<ClientesModel>> getClientes({required String valor});
  Future<String> postCliente({required List<ClientesModel> dados});
}

abstract class ICepRepository {
  Future<List<CepModel>> getCep();
}

abstract class IFornecedores {
  Future<List<FornecedoresModel>> getFornecedores({required String valor});
  Future<String> postFornecedor({required List<FornecedoresModel> dados});
}

abstract class ICategorias {
  Future<List<CategoriasModel>> getCategorias({required String valor});
  Future<String> postCategorias({required List<CategoriasModel> dados});
}

abstract class IProdutos {
  Future<List<MarcasModel>> getProdutos({required String valor});
  Future<String> postProdutos({required List<MarcasModel> dados});
}

abstract class IEstoque {
  Future<List<EstoqueModel>> getEstoque({required String valor});
  Future<String> postEstoque({required List<EstoqueModel> dados});
  Future<List<EstoqueModel>> getEstoquePorCategoria({required int id});
  Future<List<EstoqueModel>> getEstoqueProduto({required String valor});
  Future<String> atualizaEstoque(
      {required int idproduto,
      required double quantidade,
      required int iduser});
}

abstract class ISetores {
  Future<List<SetoresModel>> getSetores({required String valor});
  Future<String> postSetor({required List<SetoresModel> dados});
}

abstract class ILogin {
  Future<List<LoginModel>> getLogin(
      {required String user, required String password});
  Future<String> postLogin({required List<LoginModel> dados});
}

abstract class IPromocoes {
  Future<List<PromocoesModel>> getPromocoes({required String produto});
  Future<String> postPromocao({required List<PromocoesModel> dados});
}

abstract class ICaixas {
  Future<List<CaixaModel>> getCaixa({required int idcaixa});
  Future<String> postCaixa({required List<CaixaModel> dados});
  Future<String> statusCaixa();
  Future<String> postFecharCaixa({required List<FechamentoCaixaModel> dados});
  Future<List<FechamentoCaixaModel>> getRelatorioCaixa({required int idcaixa});
}

abstract class IItensVenda {
  Future<List<ItensVendaModel>> getItensVenda({required int idvenda});
  Future<String> postItemVenda({required List<ItensVendaModel> dados});
  Future<String> adicionaritem({required int idproduto, required int idvenda});
  Future<String> removeritem({required int idproduto, required int idvenda});
}

abstract class IVenda {
  Future<List<VendaModel>> getVenda({required int idvenda});
  Future<String> postVenda({required List<VendaModel> dados});
  Future<String> statusVenda({required int idcolaborador});
  Future<String> cancelarVenda({required int idvenda});
  Future<String> finalizarvenda({required int idvenda});
  Future<String> passarcliente({required int idvenda, required String nome});
  Future<String> passartipo({required int idvenda, required String tipo});
}

abstract class IPagamentosPedido {
  Future<List<PagamentosPedidosModel>> getPagamentos({required int idvenda});
  Future<String> postPagamentos({required List<PagamentosPedidosModel> dados});
  Future<String> deletePagamento({required int id});
}

abstract class IMovimentacaoCaixa {
  Future<List<MovimentacaoCaixaModel>> getMovimentacao({required int idcaixa});
  Future<String> postMovimentacao(
      {required List<MovimentacaoCaixaModel> dados});
}

abstract class IUsuarios {
  Future<List<UsuariosModel>> getUsuarios({required String nome});
  Future<String> postUsuario({required List<UsuariosModel> dados});
}
