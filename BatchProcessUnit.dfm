object BatchProcessForm: TBatchProcessForm
  Left = 382
  Top = 215
  BorderStyle = bsDialog
  Caption = 'Batch process'
  ClientHeight = 264
  ClientWidth = 661
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Calibri'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 18
  object Label1: TLabel
    Left = 24
    Top = 206
    Width = 316
    Height = 18
    Caption = 'Check the fields to be applied to the selected rows.'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object chkType: TCheckBox
    Left = 24
    Top = 16
    Width = 109
    Height = 17
    Caption = 'Type:'
    TabOrder = 0
    OnClick = CheckBoxClick
  end
  object chkDescription: TCheckBox
    Left = 24
    Top = 49
    Width = 109
    Height = 17
    Caption = 'Description'
    TabOrder = 1
    OnClick = CheckBoxClick
  end
  object chkTargetAcc: TCheckBox
    Left = 24
    Top = 82
    Width = 109
    Height = 17
    Caption = 'Target account'
    Enabled = False
    TabOrder = 2
    OnClick = CheckBoxClick
  end
  object chkBill: TCheckBox
    Left = 24
    Top = 115
    Width = 109
    Height = 17
    Caption = 'Bill'
    Enabled = False
    TabOrder = 3
    OnClick = CheckBoxClick
  end
  object chkNotes: TCheckBox
    Left = 24
    Top = 148
    Width = 109
    Height = 17
    Caption = 'Notes:'
    TabOrder = 4
    OnClick = CheckBoxClick
  end
  object Button1: TButton
    Left = 566
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 6
  end
  object Button2: TButton
    Left = 464
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object cbbType: TDBComboBox
    Left = 139
    Top = 12
    Width = 167
    Height = 26
    DataField = 'Type'
    DataSource = DataSource1
    Items.Strings = (
      'Salary'
      'Refund'
      'Deposit'
      'Other credits'
      'Expenses'
      'Payment'
      'Withdrawall'
      'Outgoing transfer'
      'Other debits')
    TabOrder = 7
    OnChange = cbbTypeChange
  end
  object edtDescription: TDBEdit
    Left = 139
    Top = 45
    Width = 313
    Height = 26
    DataField = 'Description'
    DataSource = DataSource1
    TabOrder = 8
  end
  object edtNotes: TDBEdit
    Left = 139
    Top = 144
    Width = 502
    Height = 26
    DataField = 'Notes'
    DataSource = DataSource1
    TabOrder = 9
  end
  object cbbTargetAcc: TDBLookupComboBox
    Left = 139
    Top = 78
    Width = 313
    Height = 26
    DataField = 'TargetName'
    DataSource = DataSource1
    TabOrder = 10
  end
  object cbbBill: TDBLookupComboBox
    Left = 139
    Top = 111
    Width = 502
    Height = 26
    DataField = 'Bill'
    DataSource = DataSource1
    TabOrder = 11
  end
  object chkInclude: TCheckBox
    Left = 24
    Top = 179
    Width = 109
    Height = 17
    Caption = 'Include'
    Checked = True
    State = cbChecked
    TabOrder = 12
    OnClick = CheckBoxClick
  end
  object DataSource1: TDataSource
    DataSet = DM.PastingDS
    Left = 560
    Top = 8
  end
end
