unit uControler.categorias;

interface
  uses horse,uInterface.categorias,uCategorias.model;
  procedure Start;

implementation
  procedure onGetCategorias(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
    var
        categoria : ICategorias;
        categoria := TCategoriasModel.New;
        aRes.Send(categoria.get(aReq.Query.Field('nome').AsString));
  end;

  procedure onPostCategorias(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
    var
        categoria : ICategorias;
        categoria := TCategoriasModel.New;
        aRes.Send(categoria.post(aReq.Body));

  end;
  procedure Start;
  begin
    Thorse.Get('Categorias',onGetCategorias);
    Thorse.Post('Categorias',onPostCategorias);
  end;
end.
