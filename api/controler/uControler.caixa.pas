unit uControler.caixa;

interface
  uses
      uInterface.caixa, uCaixa.model, horse;

  procedure Start;

implementation
  procedure onGetCaixa(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          caixa : iCaixa;
          caixa := TCaixaModel.New;

      aRes.Send(caixa.get(aReq.Query.Field('id').AsInteger));
  end;

  procedure onPostCaixa(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          caixa : iCaixa;
          caixa := TCaixaModel.New;

      aRes.Send(caixa.post(aReq.Body));
  end;

  procedure onGetStatus(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          caixa : iCaixa;
          caixa := TCaixaModel.New;

      aRes.Send(caixa.status);
  end;

  procedure onGetFecharCaixa(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          caixa : iCaixa;
          caixa := TCaixaModel.New;

      aRes.Send(caixa.fecharCaixa(aReq.Body));
  end;

  procedure onGetRelatorioCaixa(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          caixa : iCaixa;
          caixa := TCaixaModel.New;

      aRes.Send(caixa.relatoriocaixa(aReq.Query.Field('id').AsInteger));
  end;


  procedure Start;
  begin
      THorse.Get('Caixa',onGetCaixa);
      Thorse.Post('Caixa',onPostCaixa);
      Thorse.Get('statuscaixa', onGetStatus);
      Thorse.Post('Fecharcaixa', onGetFecharCaixa);
      Thorse.Get('RelatorioCaixa',onGetRelatorioCaixa);
  end;
end.
