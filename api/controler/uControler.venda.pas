unit uControler.venda;

interface
  uses horse, uInterface.venda, uVenda.model;

  procedure Start;

implementation
  procedure onGetVenda(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          venda : iVenda;
          venda := TVendaModel.New;

          aRes.Send(venda.get(aReq.Query.Field('id').asinteger));
  end;

  procedure onPostVenda(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          venda : iVenda;
          venda := TVendaModel.New;

          aRes.Send(venda.post(aReq.Body));
  end;

  procedure onGetStatusVenda(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          venda : iVenda;
          venda := TVendaModel.New;

          aRes.Send(venda.verificarvenda(aReq.Query.Field('idcolaborador').asinteger));
  end;

  procedure onCancelVenda(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          venda : iVenda;
          venda := TVendaModel.New;

          aRes.Send(venda.cancelarPedido(aReq.Query.Field('id').AsInteger));
  end;

  procedure onFinalizarPedido(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          venda : iVenda;
          venda := TVendaModel.New;

          aRes.Send(venda.finalizarPedido(aReq.Query.Field('id').AsInteger));
  end;

  procedure Start;
  begin
      Thorse.Get('Venda',onGetVenda);
      Thorse.Post('Venda',onPostVenda);
      Thorse.Get('Statusvenda',onGetStatusVenda);
      Thorse.Post('Cancelarvenda',onCancelVenda);
      Thorse.Get('Finalizarpedido',onFinalizarPedido) ;
  end;
end.
