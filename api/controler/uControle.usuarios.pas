unit uControle.usuarios;

interface
  uses horse, uInterface.usuarios,uUsuarios.model;

  procedure Start;

implementation

  procedure onGetUsuarios(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
     var
        usuario : iUsuarios;
        usuario := TUsuariosModeel.New;
        aRes.Send(usuario.get(aReq.Query.Field('nome').AsString));
  end;
  procedure onPostUsuarios(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
     var
        usuario : iUsuarios;
        usuario := TUsuariosModeel.New;
        aRes.Send(usuario.post(aReq.Body));
  end;
  procedure Start;
  begin
      Thorse.Get('Usuarios',onGetUsuarios);
      Thorse.Post('Usuarios',onPostUsuarios);
  end;
end.
