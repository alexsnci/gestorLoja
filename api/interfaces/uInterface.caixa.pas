unit uInterface.caixa;

interface
  uses System.JSON;
  type
    iCaixa = interface
         function get(id:integer):TJSonArray;
         function post(dados : String) : String;
         function status:String;
         function fecharCaixa(dados:String):String;
         function relatoriocaixa(idcaixa : integer) : TJsonArray;
    end;

implementation

end.
