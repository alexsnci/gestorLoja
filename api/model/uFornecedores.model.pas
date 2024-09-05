unit uFornecedores.model;

interface
  uses uInterface.fornecedores,System.JSON,uInterface.Scrips,uScrips, firedac.Comp.Client,dataset.Serialize;
  type
    TFornecedores = class(TInterfacedObject,IFornecedores)
    private
      script : iScripts;
      function get(valor : String) : TJsonArray;
      function post(dados : String): String;

    public
     constructor Create;
     destructor Destroy; override;
     class function New : IFornecedores;
    end;

implementation

{ TFornecedores }

constructor TFornecedores.Create;
begin
    script := TScripts.New;
end;

destructor TFornecedores.Destroy;
begin

  inherited;
end;

function TFornecedores.get(valor: String): TJsonArray;
begin
    if valor <> '' then
        result := script.sql('select * from fornecedores where razaosocial like :nome order by razaosocial').parametro('nome','%'+valor+'%').abrir.retornoJson
    else
        result := script.sql('select * from fornecedores order by razaosocial').abrir.retornoJson;
end;

class function TFornecedores.New: IFornecedores;
begin
    result  := self.Create;
end;

function TFornecedores.post(dados: String): String;
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
                    script.sql('select * from fornecedores where id = :id')
                        .parametro('id',mDados.FieldByName('id').AsInteger)
                        .abrir
                        .edit
                        .campo('razaosocial',mDados.FieldByName('razaosocial').AsString)
                        .campo('cnpj',mDados.FieldByName('cnpj').AsString)
                        .campo('contato',mDados.FieldByName('contato').AsString)
                        .campo('vendedor',mDados.FieldByName('vendedor').AsString)
                        .campo('contatovendedor',mDados.FieldByName('contatovendedor').AsString)
                        .campo('status',mDados.FieldByName('status').AsString)
                        .post;
                        Result := 'Fornecedor editado com sucesso!';
              end
              else
              begin

                var
                    id : integer;
                    id := script.geraCodigo('id','fornecedores');

                    script.sql('select * from fornecedores where 1=2')
                          .abrir
                          .insert
                          .campo('id',id)
                          .campo('razaosocial',mDados.FieldByName('razaosocial').AsString)
                          .campo('cnpj',mDados.FieldByName('cnpj').AsString)
                          .campo('contato',mDados.FieldByName('contato').AsString)
                          .campo('vendedor',mDados.FieldByName('vendedor').AsString)
                          .campo('contatovendedor',mDados.FieldByName('contatovendedor').AsString)
                          .campo('status',mDados.FieldByName('status').AsString)
                          .post;
                          Result := 'Fornecedor inserido com sucesso!';
              end;
            finally
              mDados.DisposeOf;
            end;
     end;
end;

end.
