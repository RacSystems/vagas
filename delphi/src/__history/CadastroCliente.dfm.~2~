object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'FormCadastro'
  ClientHeight = 514
  ClientWidth = 888
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object FDConn: TFDConnection
    Params.Strings = (
      'Database=E:\Rac Sistema\vagas\delphi\data'
      'DriverID=ODBC_CSV')
    Connected = True
    Left = 24
    Top = 128
  end
  object ODBC_CSV: TFDPhysODBCDriverLink
    DriverID = 'ODBC_CSV'
    ODBCDriver = 'Microsoft Text Driver (*.txt; *.csv)'
    Left = 24
    Top = 184
  end
  object qryPrinc: TFDTable
    Connection = FDConn
    UpdateOptions.UpdateTableName = '`banco.csv`'
    TableName = '`banco.csv`'
    Left = 24
    Top = 72
    object qryPrincID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
    end
    object qryPrincNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Size = 255
    end
    object qryPrincEmail: TStringField
      FieldName = 'E-mail'
      Origin = '`E-mail`'
      Size = 255
    end
    object qryPrincDocumento: TFloatField
      FieldName = 'Documento'
      Origin = 'Documento'
    end
  end
  object DSPrinc: TDataSource
    DataSet = qryPrinc
    Left = 24
    Top = 16
  end
end
