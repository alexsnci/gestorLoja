unit uCOntroler.itens.venda;

interface
  uses horse, uInterface.itens.venda, uItens.venda.model;

  procedure Start;

implementation
  procedure onGetItensvenda(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          itens : iItensVenda;
          itens := TItensVendaModel.New;
          aRes.Send(itens.get(aReq.Query.Field('pedido').AsInteger));
  end;
  procedure onPostItensvenda(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          itens : iItensVenda;
          itens := TItensVendaModel.New;
          aRes.Send(itens.post(aReq.body));
  end;
  procedure onAddItem(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          itens : iItensVenda;
          itens := TItensVendaModel.New;
          aRes.Send(itens.adicionarumitem(aReq.Query.Field('idproduto').AsInteger,aReq.Query.Field('idvenda').AsInteger));
  end;
  procedure onRemoveItem(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          itens : iItensVenda;
          itens := TItensVendaModel.New;
          aRes.Send(itens.removerumiten(aReq.Query.Field('idproduto').AsInteger,aReq.Query.Field('idvenda').AsInteger));
  end;

  procedure Start;
  begin
    Thorse.Get('Itensvenda',onGetItensvenda);
    Thorse.Post('Itensvenda',onPostItensVenda);
    Thorse.Post('Adicionaritemvenda',onAddItem);
    Thorse.Post('Apagaritemvenda',onRemoveItem)
  end;
end.
