unit uCaixa.model;

interface
  uses uInterface.caixa, Dataset.Serialize, Firedac.Comp.Client, System.JSON, uInterface.Scrips, uScrips, System.SysUtils;

  type
    TCaixaModel = class(TInterfacedObject,iCaixa)
    private
        script : iScripts;
        function get(id : integer) : TJSonArray;
        function post(dados : String) : String;
        function fecharCaixa(dados:String):String;
        function status:String;
        function relatoriocaixa(idcaixa : integer) : TJsonArray;
    public
      constructor Create;
      destructor Destroy;override;
      class Function New : iCaixa;
    end;

implementation

{ TCaixaModel }

constructor TCaixaModel.Create;
begin
    script := TScripts.New;
end;

destructor TCaixaModel.Destroy;
begin

  inherited;
end;

function TCaixaModel.fecharCaixa(dados: String): String;
begin
    if dados<>'' then
    begin
        var
          mDados : TFDmemtable;
          try
            mDados := TFDmemtable.Create(nil);
            mDados.LoadFromJSON(dados);

            var
                id : integer;
                id := 0;
                id := script.geraCodigo('id','fechamentocaixa');

            var
                idcaixa : integer;
                idcaixa := 0;

                idcaixa := script.sql('SELECT * FROM CAIXA WHERE STATUS = :status')
                                 .parametro('status','Aberto')
                                 .abrir
                                 .retornoquery
                                 .FieldByName('id').AsInteger;

            var
                avista,credito,debito,pix : currency;
                avista    := 0;
                credito   := 0;
                debito    := 0;
                pix       := 0;

                script.sql('SELECT '+
                            'COALESCE(SUM(CASE WHEN formapagamento = '+quotedStr('À Vista')+' then valor end)) AS AVISTA, '+
                            'COALESCE(SUM(CASE WHEN formapagamento = '+quotedStr('PIX')+' then valor end)) AS PIX, '+
                            'COALESCE(SUM(CASE WHEN formapagamento = '+quotedStr('Cartão Crédito')+' then valor end)) AS CREDITO, '+
                            'COALESCE(SUM(CASE WHEN formapagamento = '+quotedStr('Cartão Débito')+' then valor end)) AS DEBITO '+
                            'FROM '+
                            'pagamentos_pedido where idcaixa = :id GROUP by(idcaixa)')
                      .parametro('id',idcaixa)
                      .abrir;



                avista    := script.retornoquery.FieldByName('AVISTA').AsCurrency;
                credito   := script.retornoquery.FieldByName('CREDITO').AsCurrency;
                debito    := script.retornoquery.FieldByName('DEBITO').AsCurrency;
                pix       := script.retornoquery.FieldByName('PIX').AsCurrency;


                script.sql('SELECT * FROM FECHAMENTOCAIXA WHERE 1=2')
                      .abrir
                      .insert
                      .campo('id',id)
                      .campo('idcaixa',idcaixa)
                      .campo('datafechamento',datetostr(Now()))
                      .campo('valoravistainformado',mDados.FieldByName('valoravistainformado').AsCurrency)
                      .campo('valoravistaregistrado',avista)
                      .campo('valorcartaocreditoinformado',mDados.FieldByName('valorcartaocreditoinformado').AsCurrency)
                      .campo('valorcartaocreditoregistrado',credito)
                      .campo('valorcartaodebitoinformado',mDados.FieldByName('valorcartaodebitoinformado').AsCurrency)
                      .campo('valorcartaodebitoregistrado',debito)
                      .campo('valorpixinformado',mDados.FieldByName('valorpixinformado').AsCurrency)
                      .campo('valorpixregistrado',pix)
                      .post;


              script.sql('SELECT * FROM CAIXA WHERE ID = :ID')
                    .parametro('id',idcaixa)
                    .abrir
                    .edit
                    .campo('status','Fechado')
                    .post;

              Result := 'Caixa fechado com sucesso!'

          finally
               mDados.disposeof;
          end;
    end;
end;

function TCaixaModel.get(id: integer): TJSonArray;
begin
    if id <> 0 then
    begin
        result := script.sql(
              'SELECT '+
                            'C.ID, '+
                              'C.IDCOLABORADOR, '+
                              'C.OBSERVACOES, '+
                              'C.STATUS, '+
                              'DATE_FORMAT(c.data,'+quotedStr('%d/%m/%Y às %H:%i:%s')+') as data, '+
                              'C.VALORABERTURA, '+
                                '(COALESCE(SUM(CASE WHEN M.tipo = '+quotedStr('E')+' THEN m.valor END),0)) AS ENTRADAS, '+
                                '(COALESCE(SUM(CASE WHEN M.tipo = '+quotedStr('S')+' THEN m.valor END),0)) AS SAIDAS, '+
                                '((COALESCE(SUM(CASE WHEN M.tipo = '+quotedStr('E')+' THEN m.valor END),0)+C.valorabertura) - COALESCE(SUM(CASE WHEN M.tipo = '+quotedStr('S')+' THEN m.valor END),0) ) as TOTAL '+
                          'FROM '+
                          'CAIXA AS C '+
                          'LEFT JOIN movimentacao_caixa AS M ON M.idcaixa = C.ID WHERE C.ID = :ID GROUP BY(m.idcaixa) '
              ).parametro('id',id).abrir.retornoJson
    end
    else
    begin
        result := script.sql(
                        'SELECT '+
                            'C.ID, '+
                              'C.IDCOLABORADOR, '+
                              'C.OBSERVACOES, '+
                              'C.STATUS, '+
                              'DATE_FORMAT(c.data,'+quotedStr('%d/%m/%Y às %H:%i:%s')+') as data, '+
                              'C.VALORABERTURA, '+
                                '(COALESCE(SUM(CASE WHEN M.tipo = '+quotedStr('E')+' THEN m.valor END),0)) AS ENTRADAS, '+
                                '(COALESCE(SUM(CASE WHEN M.tipo = '+quotedStr('S')+' THEN m.valor END),0)) AS SAIDAS, '+
                                '((COALESCE(SUM(CASE WHEN M.tipo = '+quotedStr('E')+' THEN m.valor END),0)+C.valorabertura) - COALESCE(SUM(CASE WHEN M.tipo = '+quotedStr('S')+' THEN m.valor END),0) ) as TOTAL '+
                          'FROM '+
                          'CAIXA AS C '+
                          'LEFT JOIN movimentacao_caixa AS M ON M.idcaixa = C.ID GROUP BY(c.id)').abrir.retornoJson;
    end;
end;

class function TCaixaModel.New: iCaixa;
begin
    Result := Self.Create;
end;

function TCaixaModel.post(dados: String): String;
begin
    if dados<>'' then
    begin
        var
          mDados : TFDmemtable;
          mDados := TFDmemtable.Create(nil);
          try
             mDados.LoadFromJSON(dados);
             if mDados.FieldByName('id').AsInteger <> 0 then
             begin
                script.sql('select * from caixa where id = :id').parametro('id',mDados.FieldByName('id').AsInteger)
                      .abrir
                      .edit
                      .campo('valor',mDados.FieldByName('valor').AsCurrency)
                      .campo('observacoes',mDados.FieldByName('observacoes').AsString)
                      .post;

                result := 'Caixa editado com sucesso';
             end
             else
             begin
                var
                  id : integer;
                  id := 0;

                  if script.sql('select * from caixa where status = :status').parametro('status','Aberto').abrir.retornoquery.RecordCount>0 then
                  begin
                    Result := 'Ja existe um caixa aberto. ';
                    exit
                  end;

                  id := script.geraCodigo('id','caixa');



                script.sql('select * from caixa where 1 = 2')
                      .abrir
                      .insert
                      .campo('id',id)
                      .campo('data',DateTimetostr(now()))
                      .campo('valorabertura',mDados.FieldByName('valorabertura').AsCurrency)
                      .campo('valor',mDados.FieldByName('valorabertura').AsCurrency)
                      .campo('idcolaborador',mDados.FieldByName('idcolaborador').AsInteger)
                      .campo('status',mDados.FieldByName('status').AsString)
                      .campo('observacoes',mDados.FieldByName('observacoes').AsString)
                      .post;
                result := 'Caixa inserido com sucesso!';
             end;
          finally
             mDados.DisposeOf;
          end;
    end;

end;

function TCaixaModel.relatoriocaixa(idcaixa: integer): TJsonArray;
begin
    Result := script.sql('select * from fechamentocaixa where idcaixa = :id').parametro('id',idcaixa).abrir.retornoJson;
end;

function TCaixaModel.status: String;
begin
  script.sql('select * from caixa where status = :status')
        .parametro('status','Aberto')
        .abrir;

  if script.retornoquery.RecordCount>0 then
  begin
      if script.retornoquery.FieldByName('data').AsDateTime < date() then
      begin
          Result := 'O caixa do dia anterior ainda nao foi fechado';
      end
      else
      begin
          Result := 'Caixa aberto';
      end;
  end
  else
  begin
      Result := 'Caixa fechado.'
  end;

end;

end.
