unit uMovimentacao.caixa;

interface
  uses System.JSON, Firedac.Comp.Client,Dataset.Serialize,uInterface.movimentacao.caixa, uInterface.Scrips, uScrips,System.SysUtils;

    type
      TMovimentacaoCaixaModel = class(TInterfacedObject,iMovimentacaoCaixa)
      private
          script : iScripts;
          function get(id:integer) : TJsonArray;
          function post(dados:String) : String;
      public
        constructor Create;
        destructor Destroy; override;
        class function New : iMovimentacaoCaixa;
      
      end;

implementation

{ TMovimentacaoCaixaModel }

constructor TMovimentacaoCaixaModel.Create;
begin
    script := TScripts.New;
end;

destructor TMovimentacaoCaixaModel.Destroy;
begin

  inherited;
end;

function TMovimentacaoCaixaModel.get(id: integer): TJsonArray;
begin
    result := script.sql('SELECT ID,IDCAIXA, '+
                         'DATE_FORMAT(data,'+quotedStr('%d/%m/%Y �s %H:%i:%s')+') as data,'+
                         'VALOR,TIPO,OBS,DESCRICAO '+
                         'FROM MOVIMENTACAO_CAIXA WHERE IDCAIXA = :ID')
                    .parametro('id',id)
                    .abrir
                    .retornoJson;
end;

class function TMovimentacaoCaixaModel.New: iMovimentacaoCaixa;
begin
    result := self.Create;
end;

function TMovimentacaoCaixaModel.post(dados: String): String;
begin
    if dados<>'' then
    begin
        var
            mDados : TFDmemtable;
            try
              mDados := TFDMemTable.Create(nil);
              mDados.LoadFromJSON(dados);
              var
                  id : integer;
                  id := 0;
                  id := script.geraCodigo('id','MOVIMENTACAO_CAIXA');

              var
                  idcaixa : integer;
                  idcaixa := 0;
                  idcaixa := script.sql('select * from caixa where status = :status')
                                   .parametro('status','Aberto')
                                   .abrir
                                   .retornoquery.FieldByName('id').AsInteger;

              script.sql('SELECT * FROM MOVIMENTACAO_CAIXA WHERE 1=2')
                    .abrir
                    .insert
                    .campo('id',id)
                    .campo('idcaixa',idcaixa)
                    .campo('data',datetimetostr(Now()))
                    .campo('valor',mDados.FieldByName('valor').AsCurrency)
                    .campo('TIPO',mDados.FieldByName('tipo').AsString)
                    .campo('obs',mDados.FieldByName('obs').AsString)
                    .campo('descricao',mDados.FieldByName('descricao').AsString)
                    .post;

              result := 'Movimenta��o inserida com sucesso;'

            finally
              mDados.DisposeOf;
            end;
    end;
end;

end.
