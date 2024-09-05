unit uVenda.model;

interface
  uses
  uInterface.venda, uScrips, uInterface.Scrips, Dataset.Serialize, System.JSON, firedac.Comp.Client,System.SysUtils,
  FireDAC.Comp.DataSet;
  type
    TVendaModel = class(TInterfacedObject, iVenda)
    private
        script : iScripts;
        function get(idvenda : integer) : TJSonArray;
        function post(dados : String) : String;
        function verificarvenda(idcolaborador:integer):String;
        function cancelarPedido(id:integer):String;
        function finalizarPedido(id:integer):String;

    public
      constructor Create;
      destructor Destroy; override;
      class function New : iVenda;
    end;

implementation

{ TVendaModel }

function TVendaModel.cancelarPedido(id: integer): String;
begin
    script.sql('select * from venda where id = :id')
          .parametro('id',id)
          .abrir
          .edit
          .campo('status','Cancelado')
          .post;

    script.sql('select * from itens_venda where idvenda = :id')
          .parametro('id',id)
          .abrir;

    if script.retornoquery.RecordCount>0 then
    begin
        var
            dados : TFDmemtable;
            dados := TFDmemtable.Create(nil);
            try
               dados.CopyDataSet(script.retornoquery,[coRestart,coStructure,coAppend]);
               while not dados.eof do
               begin
                  script.sql('select * from estoque where id = :id')
                        .parametro('id',dados.FieldByName('idproduto').AsInteger)
                        .abrir
                        .edit;
                  var
                      qtd : Double;
                      qtd := 0;
                      qtd := script.retornoquery.FieldByName('quantidadeatual').AsFloat + dados.FieldByName('quantidade').AsFloat;

                      script.campo('quantidadeatual',qtd).post;
                  dados.Next;
               end;
               script.sql('delete from itens_venda where idvenda = :id').parametro('id',id).exec;
            finally
               dados.DisposeOf;
            end;
    end;
end;

constructor TVendaModel.Create;
begin
   script := TScripts.New;
end;

destructor TVendaModel.Destroy;
begin

  inherited;
end;

function TVendaModel.finalizarPedido(id: integer): String;
begin
  var
      valorpedido : Currency;
      valorpedido := 0;

  script.sql('select * from venda where id = :id')
        .parametro('id',id)
        .abrir;

        valorpedido := script.retornoquery.FieldByName('valorcompra').AsCurrency;

  script.edit
        .campo('status','Efetivado')
        .post;

  var
      idcaixa : integer;
      idcaixa := 0;

      script.sql('select * from caixa where status = :status')
            .parametro('status','Aberto')
            .abrir;

      idcaixa := script.retornoquery.FieldByName('id').AsInteger;

  var
      idlancamento : integer;
      idlancamento := 0;
      idlancamento := script.geraCodigo('id','movimentacao_caixa');

  var
      idpedido : String;
      idpedido := Formatfloat('000',id);
  script.sql('select * from movimentacao_caixa where 1 = 2')
        .abrir
        .insert
        .campo('id',id)
        .campo('idcaixa',idcaixa)
        .campo('data',datetostr(Now()))
        .campo('valor',valorpedido)
        .campo('descricao','Pagamento referente ao pedido de número: '+ idpedido)
        .campo('tipo','E')
        .campo('obs','')
        .post;

  result := 'Pedido finalizado com sucesso!'


end;

function TVendaModel.get(idvenda: integer): TJSonArray;
begin
    if idvenda <> 0  then
    begin
        Result := script.sql('select * from venda where id = :id order by data')
                        .parametro('id',idvenda)
                        .abrir.retornoJson;
    end
    else
       Result := script.sql('select * from venda order by data')
                        .abrir.retornoJson;
end;

class function TVendaModel.New: iVenda;
begin
    Result := self.Create;
end;

function TVendaModel.post(dados: String): String;
begin
      if dados <> '' then
      begin
          var mDados : TFDmemtable;
              mDados := TFDmemtable.Create(nil);
              try
                  mDados.LoadFromJSON(dados);

                  if mDados.FieldByName('id').AsInteger <> 0 then
                  begin
                      var
                          valor : Currency;
                          valor := 0;

                          valor := script.sql('select COALESCE(sum(subtotal),0) as total from itens_venda where idvenda = :id')
                                         .parametro('id',mDados.FieldByName('id').AsInteger)
                                         .abrir
                                         .retornoquery.FieldByName('total').AsCurrency;

                      script.sql('select * from venda id = :id')
                            .parametro('id',mDados.FieldByName('id').AsInteger)
                            .abrir
                            .edit
                            .campo('idcliente',mDados.FieldByName('idcliente').AsInteger)
                            .campo('idcolaborador',mDados.FieldByName('idcolaborador').AsInteger)
                            .campo('idloja',mdados.FieldByName('idloja').AsInteger)
                            .campo('valorcompra',valor)
                            .campo('tipo',mDados.FieldByName('tipo').AsString)
                            .campo('status',mDados.FieldByName('status').AsString)
                            .post;

                      Result :=  mDados.FieldByName('id').ToString;
                  end
                  else
                  begin

                  var
                      id : integer;
                      id := 0;

                      id := script.geraCodigo('id','venda');

                      script.sql('select * from venda where 1 = 2')
                            .abrir
                            .insert
                            .campo('id',id)
                            .campo('idcliente',mDados.FieldByName('idcliente').AsInteger)
                            .campo('idcolaborador',mDados.FieldByName('idcolaborador').AsInteger)
                            .campo('idloja',mdados.FieldByName('idloja').AsInteger)
                            .campo('valorcompra',mDados.FieldByName('valorcompra').AsCurrency)
                            .campo('tipo',mDados.FieldByName('tipo').AsString)
                            .campo('data',DateTimetostr(now()))
                            .campo('status',mDados.FieldByName('status').AsString)
                            .post;

                      result := id.ToString;
                  end;
              finally
                mDados.DisposeOf;
              end;

      end;
end;

function TVendaModel.verificarvenda(idcolaborador:integer): String;
begin
     script.sql('select * from venda where status = :status and idcolaborador = :idcolaborador')
           .parametro('status','Pendente')
           .parametro('idcolaborador',idcolaborador)
           .abrir;

     if script.retornoquery.RecordCount>0 then
     begin
        Result := script.retornoquery.FieldByName('id').AsString;
     end
     else
        Result := '0';
end;

end.
