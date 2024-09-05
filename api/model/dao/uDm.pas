unit uDm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.ConsoleUI.Wait, FireDAC.Phys.MySQLDef, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.UI;

type
  TDm = class(TDataModule)
    cursor: TFDGUIxWaitCursor;
    libmyql: TFDPhysMySQLDriverLink;
    conexao: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dm: TDm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDm.DataModuleCreate(Sender: TObject);
begin
    libmyql.VendorHome := 'C:\GestorLoja\API';
end;

end.
