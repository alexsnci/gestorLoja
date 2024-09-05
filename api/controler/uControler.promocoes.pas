unit uControler.promocoes;

interface
  uses uInterface.promocoes,horse,uPromocoes.model;
  procedure Start;

implementation
  procedure onGetPromocoes(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
      var
          promo : iPromocoes;
          promo := TPromocoesModel.New;

          aRes.Send(promo.get(aReq.Query.Field('produto').asString));
  end;

  procedure onPostPromocoes(aReq : ThorseRequest; aRes : ThorseResponse);
  begin
     var
          promo : iPromocoes;
          promo := TPromocoesModel.New;

          aRes.Send(promo.post(aReq.Body));
  end;

  procedure Start;
  begin
      Thorse.Get('Promocoes',onGetPromocoes);
      Thorse.Post('Promocoes',onPostPromocoes);
  end;

end.
