unit uInterface.movimentacao.caixa;

interface
  uses System.JSON;
  type
    iMovimentacaoCaixa = interface
      function get(id:integer) : TJsonArray;
      function post(dados:String) : String;
    end;

implementation

end.
