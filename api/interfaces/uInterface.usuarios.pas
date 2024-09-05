unit uInterface.usuarios;

interface
  uses System.JSON;

  type
    iUsuarios = interface
      function get(nome:String):TJSonArray;
      function post(dados : String) : String;
    end;

implementation

end.
