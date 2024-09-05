unit uInterface.marcas;

interface
  uses System.JSON;
  type
    IMarcas = interface
      function get(valor : String) : TjsonArray;
      function post(dados : String) : String;
    end;

implementation

end.
