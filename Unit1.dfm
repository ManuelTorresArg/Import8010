object Form1: TForm1
  Left = 0
  Top = 0
  Width = 1042
  Height = 574
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 16
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Buscar 8010'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 568
    Top = 56
    Width = 441
    Height = 97
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object Memo2: TMemo
    Left = 0
    Top = 56
    Width = 553
    Height = 97
    Lines.Strings = (
      'Memo2')
    TabOrder = 2
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 168
    Width = 537
    Height = 353
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object OpenDialog1: TOpenDialog
    Left = 176
    Top = 16
  end
  object XMLTransformProvider1: TXMLTransformProvider
    Left = 688
    Top = 216
  end
  object DataSource1: TDataSource
    Left = 736
    Top = 216
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 784
    Top = 216
  end
end
