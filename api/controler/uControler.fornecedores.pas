unit uControler.fornecedores;

interface
  uses uInterface.fornecedores, uFornecedores.model,horse;

  procedure Start;

implementation
  procedure onGetFornecedores(aReq : ThorseRequest; aRes : THorseResponse);
  begin
    var
        fornecedor : iFornecedores;
        fornecedor := TFornecedores.New;
        aRes.Send(fornecedor.get(aReq.Query.Field('nome').AsString));
  end;

  procedure onPostFornecedores(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
     var
        fornecedor : iFornecedores;
        fornecedor := TFornecedores.New;
        aRes.Send(fornecedor.post(aReq.Body));
  end;
  procedure Start;
  begin
      Thorse.Get('Fornecedores',onGetFornecedores);
      Thorse.Post('Fornecedores',onPostFornecedores);
  end;
end.
