unit uInterface.promocoes;

interface
  uses System.JSON;
  type
    iPromocoes = interface
      function get(produto : String):TJsonArray;
      function post(dados : String):String;
    end;

implementation

end.
