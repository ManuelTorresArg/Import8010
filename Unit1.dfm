object Form1: TForm1
  Left = 0
  Top = 0
  Width = 1209
  Height = 449
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
  object StringGrid1: TStringGrid
    Left = 0
    Top = 80
    Width = 553
    Height = 305
    FixedColor = clActiveCaption
    FixedCols = 0
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 568
    Top = 80
    Width = 609
    Height = 313
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object OpenDialog1: TOpenDialog
    Left = 176
    Top = 16
  end
end
