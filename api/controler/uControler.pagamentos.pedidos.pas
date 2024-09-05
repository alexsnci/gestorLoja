unit uControler.pagamentos.pedidos;

interface
  uses
    uInterface.pagamentos.pedidos, uPagamentos.pedidos,horse;

    procedure Start;

implementation

   procedure onGetPagamentosPedido(aReq : ThorseRequest; aRes : ThorseResponse);
   begin
      var
        pagamento : iPagamentosPedidos;
        pagamento := TPagamentosPedidosModel.New;

        aRes.Send(pagamento.get(aReq.Query.Field('idvenda').AsInteger));
   end;

   procedure onPostPagamentosPedido(aReq : ThorseRequest; aRes : ThorseResponse);
   begin
      var
        pagamento : iPagamentosPedidos;
        pagamento := TPagamentosPedidosModel.New;

        aRes.Send(pagamento.post(aReq.Body));
   end;

   procedure onDeletePagamentosPedido(aReq : ThorseRequest; aRes : ThorseResponse);
   begin
      var
        pagamento : iPagamentosPedidos;
        pagamento := TPagamentosPedidosModel.New;

        aRes.Send(pagamento.removerpagamento(aReq.Query.Field('id').AsInteger));
   end;

   procedure Start;
   begin
      Thorse.Get('PagamentosPedido',onGetPagamentosPedido);
      Thorse.Post('PagamentosPedido',onPostPagamentosPedido);
      Thorse.Get('Apagarpagamento',onDeletePagamentosPedido);
   end;
end.
