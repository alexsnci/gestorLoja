unit uInterface.colaboradores;

interface
  uses System.JSON;

  type
    iColaboradores = interface
      function get(nome : String) : TJsonArray;
      function post(dados : String) : String;
    end;
implementation

end.
