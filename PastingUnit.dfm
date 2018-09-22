object PastingForm: TPastingForm
  Left = -7
  Top = 15
  BorderStyle = bsSizeToolWin
  Caption = 'Pasting from spreadsheet'
  ClientHeight = 691
  ClientWidth = 1024
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Calibri'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 18
  object DBGrid1: TDBGrid
    Left = 0
    Top = 145
    Width = 1024
    Height = 527
    Align = alClient
    DataSource = DataSource1
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = 'Calibri'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    OnColEnter = DBGrid1ColEnter
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnTitleClick = DBGrid1TitleClick
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'Paste'
        PickList.Strings = (
          'Yes'
          'No')
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Process'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taLeftJustify
        DropDownRows = 10
        Expanded = False
        FieldName = 'Type'
        PickList.Strings = (
          'Salary'
          'Refund'
          'Deposit'
          'Other credits'
          'Expenses'
          'Payment'
          'Withdrawall'
          'Outgoing transfer'
          'Other debits')
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 140
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'Date'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Description'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 340
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Amount'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TargetName'
        Title.Alignment = taCenter
        Title.Caption = 'Target account'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 240
        Visible = True
      end
      item
        ButtonStyle = cbsNone
        DropDownRows = 20
        Expanded = False
        FieldName = 'Bill'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 240
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Notes'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 240
        Visible = True
      end>
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 672
    Width = 1024
    Height = 19
    Panels = <>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1024
    Height = 145
    Align = alTop
    TabOrder = 2
    DesignSize = (
      1024
      145)
    object Label1: TLabel
      Left = 8
      Top = 17
      Width = 106
      Height = 18
      Caption = 'Running balance:'
    end
    object Label2: TLabel
      Left = 8
      Top = 49
      Width = 85
      Height = 18
      Caption = 'Final balance:'
    end
    object Label3: TLabel
      Left = 8
      Top = 81
      Width = 112
      Height = 18
      Caption = 'Expected balance:'
    end
    object Label4: TLabel
      Left = 8
      Top = 113
      Width = 69
      Height = 18
      Caption = 'Difference:'
    end
    object Label5: TLabel
      Left = 456
      Top = 56
      Width = 40
      Height = 18
      Caption = 'Label5'
    end
    object Button1: TButton
      Left = 908
      Top = 16
      Width = 105
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Clear && Paste'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 128
      Top = 14
      Width = 73
      Height = 26
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 1
    end
    object Edit2: TEdit
      Left = 128
      Top = 46
      Width = 73
      Height = 26
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 2
    end
    object Button2: TButton
      Left = 207
      Top = 47
      Width = 75
      Height = 25
      Caption = 'Calculate'
      TabOrder = 5
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 908
      Top = 47
      Width = 105
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Process'
      Enabled = False
      TabOrder = 7
      OnClick = Button3Click
    end
    object Edit3: TEdit
      Left = 128
      Top = 78
      Width = 73
      Height = 26
      Alignment = taRightJustify
      TabOrder = 3
    end
    object Edit4: TEdit
      Left = 128
      Top = 110
      Width = 73
      Height = 26
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 4
    end
    object Button4: TButton
      Left = 797
      Top = 16
      Width = 105
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Batch process'
      TabOrder = 6
      OnClick = Button4Click
    end
  end
  object DataSource1: TDataSource
    DataSet = DM.PastingDS
    Left = 24
    Top = 216
  end
end
