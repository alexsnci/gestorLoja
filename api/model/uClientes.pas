unit uClientes;

interface
  uses uInterface.CLientes, uInterface.Scrips, uScrips, Firedac.Comp.Client, Dataset.Serialize,System.SysUtils,
  System.JSON;
  type
    TClientes = class(TInterfacedObject,iClientes)
    private
      script : IScripts;
      function insert(dados:String):String;
      function delete(id:integer):String;
      function getEleitores(nome : String):TJsonArray;

    public
      { public declarations }

    constructor Create;
    destructor Destroy; override;
    class function New : iClientes;
    end;

implementation

{ TClientes }

constructor TClientes.Create;
begin
    script := TScripts.New;
end;

function TClientes.delete(id: integer): String;
begin
    script.sql('delete from contato_clientes where id_cliente = :id').parametro('id',id).exec;
    script.sql('delete from endereco_clientes where id_cliente = :id').parametro('id',id).exec;
    script.sql('delete from clientes where id = :id').parametro('id',id).exec;

    result := 'Cliente excluido com sucesso!';
end;

destructor TClientes.Destroy;
begin

  inherited;
end;

function TClientes.getEleitores(nome : String): TJsonArray;
begin
  if nome <> '' then
  begin
      Result := script.sql('select * from clientes where nome like :nome order by nome')
                      .parametro('nome','%'+nome+'%')
                      .abrir.retornoJson;
  end
  else
  begin
     Result := script.sql('select * from clientes order by nome')
                     .abrir.retornoJson;
  end;
end;

function TClientes.insert(dados: String): String;
var
    dataNascimento : String;
begin
    if dados <> '' then
    begin
      var
          mDados : TFDmemtable;
       try
          mDados := TFDmemtable.Create(nil);
          mDados.LoadFromJSON(dados);

          if mDados.FieldByName('id').AsString <> '0' then
          begin
             dataNascimento := copy(mDados.FieldByName('datanascimento').AsString,4,2)
                            +'/'+
                            copy(mDados.FieldByName('datanascimento').AsString,1,2)
                           +'/'+
                           copy(mDados.FieldByName('datanascimento').AsString,7,4);

             script.sql('select * from clientes where id = :id')
                    .parametro('id',mDados.FieldByName('id').AsInteger)
                    .abrir
                    .edit
                    .campo('nome',mDados.FieldByName('nome').AsString)
                    .campo('contato',mdados.FieldByName('contato').AsString)
                    .campo('status',mDados.FieldByName('status').AsString)
                    .campo('datanascimento',dataNascimento)
                    .campo('cep',mDados.FieldByName('cep').AsString)
                    .campo('logradouro',mDados.FieldByName('logradouro').AsString)
                    .campo('numero',mDados.FieldByName('numero').AsString)
                    .campo('bairro',mDados.FieldByName('bairro').AsString)
                    .campo('cidade',mDados.FieldByName('cidade').AsString)
                    .campo('uf',mDados.FieldByName('uf').AsString)
                    .campo('email',mDados.FieldByName('email').AsString)
                    .post;
             Result := mDados.FieldByName('id').AsString;
          end
          else
          begin
             var
              id : integer;
              id := 0;

              id := script.geraCodigo('id','clientes');

              dataNascimento := copy(mDados.FieldByName('datanascimento').AsString,4,2)
                            +'/'+
                            copy(mDados.FieldByName('datanascimento').AsString,1,2)
                           +'/'+
                           copy(mDados.FieldByName('datanascimento').AsString,7,4);

              script.sql('select * from clientes where 1 = 2')
                    .abrir
                    .insert
                    .campo('id',id)
                    .campo('nome',mDados.FieldByName('nome').AsString)
                    .campo('contato',mdados.FieldByName('contato').AsString)
                    .campo('status',mDados.FieldByName('status').AsString)
                    .campo('datanascimento',dataNascimento)
                     .campo('cep',mDados.FieldByName('cep').AsString)
                    .campo('logradouro',mDados.FieldByName('logradouro').AsString)
                    .campo('numero',mDados.FieldByName('numero').AsString)
                    .campo('bairro',mDados.FieldByName('bairro').AsString)
                    .campo('cidade',mDados.FieldByName('cidade').AsString)
                    .campo('uf',mDados.FieldByName('uf').AsString)
                    .campo('email',mDados.FieldByName('email').AsString)
                    .post;
              Result := id.tostring;
          end;

      finally
          mDados.DisposeOf;
      end;
    end
    else
      Result := 'Dados não recebido!';

end;

class function TClientes.New: iClientes;
begin
   result := self.Create;
end;

end.
