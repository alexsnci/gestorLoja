unit uPromocao.model;

interface
  uses uInterface.promocoes,Dataset.Serialize,Firedac.Comp.Client,uScrips,uInterface.Scrips, System.JSON;

implementation
  type
    TPromocaoModel = class(TInterfacedObject,iPromocoes)
    private
      script : iScripts;
      function get(id:integer):TJSonArray;
      function post(dados : String) : String;
    public
        constructor Create;
        destructor Destroy; override;
        class function New : iPromocoes;
    end;

{ TPromocaoModedel }

constructor TPromocaoModel.Create;
begin
    script := TScripts.New;
end;

destructor TPromocaoModel.Destroy;
begin

  inherited;
end;

function TPromocaoModel.get(id: integer): TJSonArray;
begin
    if id <> 0 then
    begin
        result := script.sql('select * from promocoes where idestoque = :id').parametro('idestoque',id).abrir.retornoJson;
    end
    else
    begin
        result := script.sql('select * from promocoes').abrir.retornoJson;
    end;
end;

class function TPromocaoModel.New: iPromocoes;
begin
   result := Self.Create;
end;

function TPromocaoModel.post(dados: String): String;
var
    datainicio, datafim : String;
begin
    if dados <> '' then
    begin
        var
            mDados : TFDmemtable;
            mDados := TFDmemtable.Create(nil);
            try
                mDados.LoadFromJSON(dados);

                if mDados.FieldByName('id').AsInteger <> 0 then
                begin
                  script.sql('select * from promocoes where id = :id')
                        .parametro('id',mDados.FieldByName('id').AsInteger)
                        .abrir
                        .edit
                        .campo('idestoque',mDados.FieldByName('idestoque').AsInteger)
                        .campo('datainicio',datainicio)
                        .campo('datafim',datafim)
                        .campo('status',mDados.FieldByName('status').asString)
                        .campo('valor',mDados.FieldByName('valor').AsCurrency)
                        .campo('valoratual',mDados.FieldByName('valoratual').AsCurrency)
                        .campo('valordesconto',mDados.FieldByName('valordesconto').AsCurrency)
                        .campo('porcentagem',mDados.FieldByName('porcentagem').AsCurrency)
                        .post;

                  Result := 'Promo��o editada com sucesso!';
                end
                else
                begin
                var
                  id : integer;
                  id := 0;

                  id := script.geraCodigo('id', 'promocoes');

                  datainicio := copy(mDados.FieldByName('datainicio').AsString,4,2)
                            +'/'+
                            copy(mDados.FieldByName('datainicio').AsString,1,2)
                           +'/'+
                           copy(mDados.FieldByName('datainicio').AsString,7,4);

                  datafim  := copy(mDados.FieldByName('datafim').AsString,4,2)
                            +'/'+
                            copy(mDados.FieldByName('datafim').AsString,1,2)
                           +'/'+
                           copy(mDados.FieldByName('datafim').AsString,7,4);

                  script.sql('select * from promocoes where i = 2')
                        .abrir
                        .insert
                        .campo('id',id)
                        .campo('idestoque',mDados.FieldByName('idestoque').AsInteger)
                        .campo('datainicio',datainicio)
                        .campo('datafim',datafim)
                        .campo('status',mDados.FieldByName('status').asString)
                        .campo('valor',mDados.FieldByName('valor').AsCurrency)
                        .campo('valoratual',mDados.FieldByName('valoratual').AsCurrency)
                        .campo('valordesconto',mDados.FieldByName('valordesconto').AsCurrency)
                        .campo('porcentagem',mDados.FieldByName('porcentagem').AsCurrency)
                        .post;

                  Result := 'Promo��o inserida com sucesso!';
                end;

            finally
                mDados.DisposeOf;
            end;

    end;

end;

end.
