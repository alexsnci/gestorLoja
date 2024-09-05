unit uControler.estoque;

interface
  uses horse, uInterface.estoque,uEstoque.model;
  procedure Start;

implementation
  procedure onGetEstoque(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
    var
      estoque : IEstoque;
      estoque := TEstoque.New;

      aRes.Send(estoque.get(aReq.Query.Field('nome').AsString));
  end;

  procedure onPostEstoque(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
     var
      estoque : IEstoque;
      estoque := TEstoque.New;

      aRes.Send(estoque.post(aReq.Body));
  end;

  procedure onGetEstoquePorCategoria(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
     var
      estoque : IEstoque;
      estoque := TEstoque.New;

      aRes.Send(estoque.getEstoquePorCategoria(aReq.Query.Field('id').AsInteger));
  end;

  procedure onGetEstoqueProduto(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
     var
      estoque : IEstoque;
      estoque := TEstoque.New;

      aRes.Send(estoque.getProduto(aReq.Query.Field('valor').asstring));
  end;

  procedure onGetAtualizaEstoque(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
     var
      estoque : IEstoque;
      estoque := TEstoque.New;

      aRes.Send(estoque.entradademercadoria(aReq.Query.Field('id').AsInteger,aReq.Query.Field('qtd').AsInteger,
      aReq.Query.Field('iduser').AsInteger));
  end;
  procedure Start;
  begin
    Thorse.Get('Estoque',onGetEstoque);
    Thorse.Post('Estoque',onPostEstoque);
    Thorse.Get('Estoqueporcategoria',onGetEstoquePorCategoria);
    Thorse.Get('Estoqueproduto',onGetEstoqueProduto);
    Thorse.Get('AtualizaEstoque',onGetAtualizaEstoque);
  end;
end.
