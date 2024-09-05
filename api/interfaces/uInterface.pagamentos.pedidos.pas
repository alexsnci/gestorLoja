unit uInterface.pagamentos.pedidos;

interface
  uses System.JSON;
  type
    iPagamentosPedidos = interface
        function get(idpedido:integer):TJSonArray;
        function post(dados : String):String;
        function removerpagamento(id : integer) : String;
    end;

implementation

end.
