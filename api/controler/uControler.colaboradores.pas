unit uControler.colaboradores;

interface
  uses horse, uInterface.colaboradores,uColaborador.model;

  procedure Start;

implementation
  procedure onGetColaboradores(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          colaborador : iColaboradores;
          colaborador := TColaboradoresModel.New;

          aRes.Send(colaborador.get(aReq.Query.Field('nome').AsString));
  end;
  procedure onPostColaboradores(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          colaborador : iColaboradores;
          colaborador := TColaboradoresModel.New;

          aRes.Send(colaborador.post(aReq.Body));
  end;
  procedure Start;
  begin
      Thorse.Get('Colaboradores',onGetColaboradores);
      Thorse.Post('Colaboradores',onPostColaboradores);
  end;
end.
