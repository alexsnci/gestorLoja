object Dm: TDm
  OnCreate = DataModuleCreate
  Height = 1080
  Width = 1440
  PixelsPerInch = 144
  object cursor: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 488
    Top = 324
  end
  object libmyql: TFDPhysMySQLDriverLink
    Left = 880
    Top = 224
  end
  object conexao: TFDConnection
    Params.Strings = (
      'Database=centraldevs_loja'
      'User_Name=centraldevs_loja'
      'Password=2a5L9e4x@1010'
      'DriverID=MySQL')
    TxOptions.StopOptions = [xoIfCmdsInactive, xoIfAutoStarted, xoFinishRetaining]
    LoginPrompt = False
    Left = 776
    Top = 440
  end
end
