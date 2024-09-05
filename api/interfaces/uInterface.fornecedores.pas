unit uInterface.fornecedores;

interface
  uses System.JSON;
  type
    IFornecedores = interface
      function get(valor : String) : TJsonArray;
      function post(dados : String): String;
    end;

implementation

end.
