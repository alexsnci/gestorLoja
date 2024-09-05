unit uControler.movimentacao.caixa;

interface
  uses horse, uInterface.movimentacao.caixa,uMovimentacao.caixa;

  procedure Start;

implementation
  procedure onGetMovimentacaocaixa(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          movimentacao : iMovimentacaoCaixa;
          movimentacao := TMovimentacaoCaixaModel.New;

      aRes.Send(movimentacao.get(aReq.Query.Field('id').AsInteger));
  end;

  procedure onPostMovimentacaocaixa(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          movimentacao : iMovimentacaoCaixa;
          movimentacao := TMovimentacaoCaixaModel.New;

      aRes.Send(movimentacao.post(aReq.Body));
  end;

  procedure Start;
  begin
    Thorse.Get('Movimentacaocaixa',onGetMovimentacaocaixa);
    Thorse.Post('Movimentacaocaixa',onPostMovimentacaocaixa);
  end;
end.
