unit uMarcas.model;

interface
  uses uInterface.marcas,uInterface.Scrips, System.JSON,uScrips,Firedac.Comp.Client, dataset.Serialize,System.SysUtils;

  type
      TMarcasModel = class(TInterfacedObject,IMarcas)
      private
          script : iScripts;
          function get(valor : String) : TjsonArray;
          function post(dados : String) : String;
      public
        constructor Create;
        destructor Destroy; override;
        class function New:IMarcas;
      end;

implementation

{ TMarcasModel }

constructor TMarcasModel.Create;
begin
    script := TScripts.New;
end;

destructor TMarcasModel.Destroy;
begin

  inherited;
end;

function TMarcasModel.get(valor: String): TjsonArray;
begin
    if valor <> '' then
        result := script.sql('select * from marcas where descricao like :nome order by descricao').parametro('nome','%'+valor+'%').abrir.retornoJson
    else
        result := script.sql('select * from marcas order by descricao').abrir.retornoJson;
end;

class function TMarcasModel.New: IMarcas;
begin
    Result := self.Create;
end;

function TMarcasModel.post(dados: String): String;
begin
    if dados <> '' then
     begin
        var
            mDados : TFDmemtable;
            mDados := TFDmemtable.Create(nil);
            try
              mDados.LoadFromJSON(dados);
              if mDados.FieldByName('id').asinteger <> 0 then
              begin


                    script.sql('select * from marcas where id = :id')
                        .parametro('id',mDados.FieldByName('id').AsInteger)
                        .abrir
                        .edit
                        .campo('descricao',mDados.FieldByName('descricao').AsString)
                        .campo('status',mDados.FieldByName('status').AsString)
                        .post;
                        Result := 'Marca inserida com sucesso!';
              end
              else
              begin

                var
                    id : integer;
                    id := script.geraCodigo('id','marcas');
                    script.sql('select * from marcas where 1=2')
                          .abrir
                          .insert
                          .campo('id',id)
                          .campo('descricao',mDados.FieldByName('descricao').AsString)
                          .campo('status',mDados.FieldByName('status').AsString)
                          .post;
                          Result := 'Marca inserida com sucesso!';
              end;
            finally
              mDados.DisposeOf;
            end;
     end;
end;

end.
