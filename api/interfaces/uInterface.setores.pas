unit uInterface.setores;

interface
  uses System.JSON;
  type
    ISetores = interface
      function get(setor : String) : TJSonArray;
      function post(dados : String) : String;
    end;

implementation

end.
