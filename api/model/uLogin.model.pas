unit uLogin.model;

interface
  uses
      Dataset.Serialize, uScrips,uInterface.Scrips,System.JSON,uInterface.login,Firedac.Comp.Client;
type
  TLoginModel = class(TInterfacedObject,iLogin)
  private
      script : iScripts;
      function get(user,password:String):TJsonArray;
      function post(dados:String):String;
  public
      constructor Create;
      destructor Destroy;override;
      class function New:iLogin;
  end;

implementation

{ TLoginModel }

constructor TLoginModel.Create;
begin
    script := TScripts.New;
end;

destructor TLoginModel.Destroy;
begin

  inherited;
end;

function TLoginModel.get(user, password: String): TJsonArray;
begin
    result := script.sql('select l.*,c.nome from login as l join colaboradores as c on l.idcolaborador = c.id where BINARY l.username = :user and BINARY l.userpassword = :password and status <> :status')
                    .parametro('user',user)
                    .parametro('password',password)
                    .parametro('status','Bloqueado')
                    .abrir
                    .retornoJson;
end;

class function TLoginModel.New: iLogin;
begin
    Result := self.Create;
end;

function TLoginModel.post(dados: String): String;
begin
   if dados<>'' then
   begin
        var 
          mDados : TFDmemtable;
          mDados := TFDmemtable.Create(nil);
          try
              var
                  id : integer;
                  id := 0;
                  id := script.geraCodigo('id','login');

              var
                  idcolaborador : integer;
                  idcolaborador := script.sql('select id,nome from colaboradores where nome = :nome')
                                         .parametro('nome',mDados.FieldByName('nome').AsString)
                                         .abrir
                                         .retornoquery.FieldByName('id').AsInteger;

                  script.sql('select * from login where 1=2')
                        .abrir
                        .insert
                        .campo('id',id)
                        .campo('idcolaborador',idcolaborador)
                        .campo('username',mDados.FieldByName('username').AsString)
                        .campo('userpasword',mDados.FieldByName('userpasword').AsString)
                        .campo('userpermissoes',mDados.FieldByName('userpermissoes').AsInteger)
                        .campo('status','Ativo')
                        .post;
                Result := 'Usu�rio inserido com sucesso!';
          finally
              mDados.DisposeOf
          end;
   end;
end;

end.
