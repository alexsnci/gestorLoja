unit uInterface.itens.venda;

interface
  uses System.JSON;
  type
    iItensVenda = interface
        function get(idvenda : integer):TJSonArray;
        function post(dados : String):String;
        function removerumiten(idproduto, idvenda: integer): String;
        function adicionarumitem(idproduto, idvenda: integer): String;
    end;

implementation

end.
