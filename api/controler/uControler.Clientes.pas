unit uControler.Clientes;

interface
  uses horse, uInterface.CLientes,uClientes;

  procedure Start;

implementation
  procedure onGetClientes(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          cliente : iClientes;
          cliente := TClientes.New;

      aRes.Send(cliente.getEleitores(aReq.Query.Field('nome').AsString));

  end;

  procedure onPOstClientes(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          cliente : iClientes;
          cliente := TClientes.New;

          aRes.Send(cliente.insert(aReq.Body));
  end;
  procedure Start;
  begin
    Thorse.Get('clientes',onGetClientes);
    Thorse.Post('clientes',onPostClientes);
  end;
end.
