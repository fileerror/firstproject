object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 399
  ClientWidth = 642
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 425
    Top = 21
    Width = 190
    Height = 13
    Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1072#1103' '#1076#1083#1080#1085#1072' '#1082#1086#1076#1086#1074#1086#1075#1086' '#1089#1083#1086#1074#1072
  end
  object SpinEdit1: TSpinEdit
    Left = 425
    Top = 40
    Width = 195
    Height = 22
    MaxValue = 100
    MinValue = 1
    TabOrder = 0
    Value = 10
  end
  object Button1: TButton
    Left = 481
    Top = 84
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 401
    Height = 281
    TabOrder = 2
  end
  object Button2: TButton
    Left = 481
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 481
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 4
    OnClick = Button3Click
  end
end
