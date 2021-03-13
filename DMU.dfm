object DM: TDM
  OldCreateOrder = False
  Height = 370
  Width = 551
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=dados'
      'User_Name=root'
      'Server=127.0.0.1'
      'DriverID=MySQL')
    Connected = True
    Left = 224
    Top = 160
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\projeto\PedidoVenda\Win32\Debug\libmysql.dll'
    Left = 104
    Top = 192
  end
end
