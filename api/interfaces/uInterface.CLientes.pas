unit uInterface.CLientes;

interface

uses
  System.JSON;
  type
    iClientes = interface
        function insert(dados:String):String;
        function delete(id:integer):String;
        function getEleitores(nome : String):TJsonArray;
    end;

implementation

end.
