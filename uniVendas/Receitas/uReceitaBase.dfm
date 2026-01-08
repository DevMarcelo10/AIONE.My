object FrmReceitaBase: TFrmReceitaBase
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FrmReceitaBase'
  ClientHeight = 288
  ClientWidth = 423
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object cdArqSngpcLot: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 140
    Top = 28
    object cdArqSngpcLotIDInvIni: TIntegerField
      FieldName = 'IDInvIni'
    end
    object cdArqSngpcLotIDProd: TIntegerField
      FieldName = 'IDProd'
    end
    object cdArqSngpcLotIDPess: TIntegerField
      FieldName = 'IDPess'
    end
    object cdArqSngpcLotNrolot: TWideStringField
      FieldName = 'Nrolot'
    end
    object cdArqSngpcLotDatven: TDateTimeField
      FieldName = 'Datven'
    end
    object cdArqSngpcLotQtdest: TFloatField
      FieldName = 'Qtdest'
    end
    object cdArqSngpcLotQtdSel: TFloatField
      FieldName = 'QtdSel'
    end
  end
  object dsArqSngpcLot: TDataSource
    DataSet = cdArqSngpcLot
    Left = 44
    Top = 29
  end
end
