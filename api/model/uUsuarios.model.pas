unit uUsuarios.model;

interface
  uses System.JSON, uInterface.Scrips,uScrips,Dataset.Serialize, Firedac.Comp.Client, System.SysUtils,uInterface.usuarios;

  type
    TUsuariosModeel = class(TInterfacedObject,iUsuarios)
    private
        script : iScripts;
       function get(nome:String):TJSonArray;
       function post(dados : String) : String;
    public
       constructor Create;
       destructor Destroy;override;
       class function New:iUsuarios;
    end;

implementation

{ TUsuariosModeel }

constructor TUsuariosModeel.Create;
begin
    script := TScripts.New;
end;

destructor TUsuariosModeel.Destroy;
begin

  inherited;
end;

function TUsuariosModeel.get(nome: String): TJSonArray;
begin
    if nome<>'' then
    begin
      result := script.sql('select l.id, l.idcolaborador, l.status, l.username, l.userpermissoes, '+
                           'c.nome from login as l left join colaboradores as c on l.idcolaborador = c.id where l.username = :nome')
                      .parametro('nome','nome')
                      .abrir.retornoJson
    end
    else
    begin
        result := script.sql('select l.id, l.idcolaborador, l.status, l.username, l.userpermissoes, c.nome from login as l left join colaboradores as c on l.idcolaborador = c.id order by c.nome')
                        .abrir.retornoJson;
    end;
end;

class function TUsuariosModeel.New: iUsuarios;
begin
    Result := self.Create;
end;

function TUsuariosModeel.post(dados: String): String;
begin
   if dados<>'' then
   begin
      var
          mDados : TFDmemtable;
          try
            mDados := TFDmemtable.Create(nil);
            mDados.LoadFromJSON(dados);

            script.sql('select * from login where username = :user')
                  .parametro('user',mDados.FieldByName('username').AsString)
                  .abrir;

                  if script.retornoquery.RecordCount>0 then
                  begin
                      Result := 'Já existe um usuário cadastrado com esse nome de acesso!' ;
                  end
                  else
                  begin
                      var
                          id : integer;
                          id := 0;
                          id := script.geraCodigo('id','login');
                      var
                          idcolaborador : integer;
                          idcolaborador := 0;
                          idcolaborador := script.geraCodigo('id','colaboradores');

                          script.sql('select * from colaboradores where 1=2')
                                .abrir
                                .insert
                                .campo('id',idcolaborador)
                                .campo('nome',mDados.FieldByName('nome').AsString)
                                .post
                                .sql('select * from login where 1=2')
                                .abrir
                                .insert
                                .campo('id',id)
                                .campo('idcolaborador',idcolaborador)
                                .campo('username',mDados.FieldByName('username').AsString)
                                .campo('userpassword',mdados.FieldByName('userPassword').AsString)
                                .campo('userpermissoes',mDados.FieldByName('userpermissoes').AsString)
                                .campo('status',mDados.FieldByName('status').AsString)
                                .post;

                          Result := 'Registro inserido com sucesso!';
                  end;

          finally
            mDados.DisposeOf
          end;
   end;
end;

end.
