library gestorApiLoja;

uses
  System.SysUtils,
  System.Classes,
  Web.HTTPD24Impl,
  horse,
  Horse.Jhonson,
  Horse.JWT,
  Horse.OctetStream,
  Horse.CORS,
  uDm in 'model\dao\uDm.pas' {Dm: TDataModule},
  uScrips in 'model\uScrips.pas',
  uInterface.Scrips in 'interfaces\uInterface.Scrips.pas',
  uClientes in 'model\uClientes.pas',
  uInterface.CLientes in 'interfaces\uInterface.CLientes.pas',
  uControler.Clientes in 'controler\uControler.Clientes.pas',
  uFornecedores.model in 'model\uFornecedores.model.pas',
  uInterface.fornecedores in 'interfaces\uInterface.fornecedores.pas',
  uInterface.categorias in 'interfaces\uInterface.categorias.pas',
  uCategorias.model in 'model\uCategorias.model.pas',
  uInterface.marcas in 'interfaces\uInterface.marcas.pas',
  uMarcas.model in 'model\uMarcas.model.pas',
  uInterface.estoque in 'interfaces\uInterface.estoque.pas',
  uEstoque.model in 'model\uEstoque.model.pas',
  uControler.fornecedores in 'controler\uControler.fornecedores.pas',
  uControler.categorias in 'controler\uControler.categorias.pas',
  uControler.marcas in 'controler\uControler.marcas.pas',
  uControler.estoque in 'controler\uControler.estoque.pas',
  uSetores in 'model\uSetores.pas',
  uInterface.setores in 'interfaces\uInterface.setores.pas',
  uControler.setores in 'controler\uControler.setores.pas',
  uInterface.login in 'interfaces\uInterface.login.pas',
  uLogin.model in 'model\uLogin.model.pas',
  uControler.login in 'controler\uControler.login.pas',
  uInterface.promocoes in 'interfaces\uInterface.promocoes.pas',
  uPromocoes.model in 'model\uPromocoes.model.pas',
  uControler.promocoes in 'controler\uControler.promocoes.pas',
  uInterface.caixa in 'interfaces\uInterface.caixa.pas',
  uCaixa.model in 'model\uCaixa.model.pas',
  uControler.caixa in 'controler\uControler.caixa.pas',
  uVenda.model in 'model\uVenda.model.pas',
  uInterface.venda in 'interfaces\uInterface.venda.pas',
  uControler.venda in 'controler\uControler.venda.pas',
  uInterface.itens.venda in 'interfaces\uInterface.itens.venda.pas',
  uItens.venda.model in 'model\uItens.venda.model.pas',
  uCOntroler.itens.venda in 'controler\uCOntroler.itens.venda.pas',
  uPagamentos.pedidos in 'model\uPagamentos.pedidos.pas',
  uInterface.pagamentos.pedidos in 'interfaces\uInterface.pagamentos.pedidos.pas',
  uControler.pagamentos.pedidos in 'controler\uControler.pagamentos.pedidos.pas',
  uInterface.movimentacao.caixa in 'interfaces\uInterface.movimentacao.caixa.pas',
  uMovimentacao.caixa in 'model\uMovimentacao.caixa.pas',
  uControler.movimentacao.caixa in 'controler\uControler.movimentacao.caixa.pas',
  uInterface.colaboradores in 'interfaces\uInterface.colaboradores.pas',
  uColaborador.model in 'model\uColaborador.model.pas',
  uControler.colaboradores in 'controler\uControler.colaboradores.pas',
  uUsuarios.model in 'model\uUsuarios.model.pas',
  uInterface.usuarios in 'interfaces\uInterface.usuarios.pas',
  uControle.usuarios in 'controler\uControle.usuarios.pas';

var
    ApacheModuleData: TApacheModuleData;
  exports
    ApacheModuleData name 'apiloja';

{$R *.res}

begin
   THorse.DefaultModule := @ApacheModuleData;
   THorse.HandlerName := 'gestor_loja_handler';

   THorse
      .Use(Jhonson)
      .Use(octetstream)
      .use(cors);
      uControler.Clientes.Start;
      uControler.fornecedores.Start;
      uControler.categorias.Start;
      uControler.marcas.Start;
      uControler.estoque.Start;
      uControler.setores.Start;
      uControler.login.Start;
      uControler.promocoes.Start;
      uControler.caixa.Start;
      uControler.venda.Start;
      uControler.itens.venda.Start;
      uControler.pagamentos.pedidos.Start;
      uControler.movimentacao.caixa.Start;
      uControler.colaboradores.Start;
      uControle.usuarios.Start;

      THorse.Listen;
end.
