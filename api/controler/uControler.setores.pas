unit uControler.setores;

interface
  uses uInterface.setores, uSetores, horse;

  procedure Start;

implementation
  procedure onGetSetores(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
       var
          setor : ISetores;
          setor := TSetoresModel.New;
          aRes.Send(setor.get(aReq.Query.Field('nome').AsString));
  end;
  procedure onPostSetores(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          setor : ISetores;
          setor := TSetoresModel.New;
          aRes.Send(setor.post(aReq.Body));
  end;
  procedure Start;
  begin
      Thorse.Get('Setores',onGetSetores);
      Thorse.Post('Setores',onPostSetores);
  end;
end.
