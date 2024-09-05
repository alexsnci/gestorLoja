unit uColaborador.model;

interface
  uses
    System.JSON, uInterface.colaboradores,uScrips, uInterface.Scrips, Dataset.Serialize, Firedac.Comp.Client,System.SysUtils;

  type
    TColaboradoresModel = class(TInterfacedObject,iColaboradores)
    private
        scripts : iScripts;
        function get(nome : String) : TJsonArray;
        function post(dados : String) : String;
    public
        constructor Create;
        destructor Destroy;override;
        class function New : iColaboradores;
    end;

implementation

{ TColaboradoresModel }

constructor TColaboradoresModel.Create;
begin
    scripts := TScripts.New;
end;

destructor TColaboradoresModel.Destroy;
begin

  inherited;
end;

function TColaboradoresModel.get(nome: String): TJsonArray;
begin
  result := scripts.sql('select c.*, f.descricao as funcao from colaboradores as c left join funcao as f on c.idfuncao = f.id where nome like :nome')
             .parametro('nome','%'+nome+'%')
             .abrir.retornoJson;
end;

class function TColaboradoresModel.New: iColaboradores;
begin
  result := Self.Create;
end;

function TColaboradoresModel.post(dados: String): String;
begin
    if dados <> '' then
    begin
        var
            mDados : TFDMemtable;;
            try
              mDados := TFDmemtable.Create(nil);
              mDados.LoadFromJSON(dados);

              if mDados.FieldByName('id').AsInteger <> 0 then
              begin
                  var
                      datanascimento : String;
                      datanascimento := copy(mDados.FieldByName('datanascimento').AsString,4,2)
                                          +'/'+
                                          copy(mDados.FieldByName('datanascimento').AsString,1,2)
                                          +'/'+
                                          copy(mDados.FieldByName('datanascimento').AsString,7,4);


                  scripts.sql('select * from colaboradores where id = :id')
                         .parametro('id',mDados.FieldByName('id').AsInteger)
                         .abrir
                         .edit
                         .campo('datanascimento',datanascimento)
                         .campo('contato',mDados.FieldByName('contato').AsString)
                         .campo('idfuncao',mDados.FieldByName('idfuncao').AsInteger)
                         .post;

                  result := 'Registro editado com sucesso';
              end
              else
              begin
                  var
                      id : integer;
                      id := 0;
                      id := scripts.geraCodigo('id','colaboradores');
                  var
                      datanascimento : String;
                      datanascimento := copy(mDados.FieldByName('datanascimento').AsString,4,2)
                                          +'/'+
                                          copy(mDados.FieldByName('datanascimento').AsString,1,2)
                                          +'/'+
                                          copy(mDados.FieldByName('datanascimento').AsString,7,4);
                  var
                      dataadimissao : String;
                      dataadimissao := datetostr(date());

                 var
                      idfuncao : integer;
                      idfuncao := scripts.sql('select * from funcao where descricao = :des')
                                         .parametro('des',mDados.FieldByName('funcao').AsString)
                                         .abrir
                                         .retornoquery
                                         .FieldByName('id').AsInteger;

                      scripts.sql('select * from colaboradores where 1=2')
                             .insert
                             .campo('id',id)
                             .campo('nome',mDados.FieldByName('nome').AsString)
                             .campo('datanascimento',datanascimento)
                             .campo('contato',mDados.FieldByName('contato').AsString)
                             .campo('dataadmissao',dataadimissao)
                             .campo('idfuncao',idfuncao)
                             .post;

                     result := 'Registro inserido com sucesso!';

              end;

            finally
              mDados.DisposeOf;
            end;
    end;
end;

end.
