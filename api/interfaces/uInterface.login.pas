unit uInterface.login;

interface
  uses System.JSON;
  type
    iLogin = interface
      function get(user,password:String):TJsonArray;
      function post(dados:String):String;
    end;

implementation

end.
