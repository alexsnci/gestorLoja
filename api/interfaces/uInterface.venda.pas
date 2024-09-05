unit uInterface.venda;

interface
  uses System.JSON;

  type
    iVenda = interface
        function get(idvenda : integer) : TJSonArray;
        function post(dados : String) : String;
        function verificarvenda(idcolaborador:integer):String;
        function cancelarPedido(id:integer):String;
        function finalizarPedido(id:integer):String;
    end;

implementation

end.
