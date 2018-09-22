object MainForm: TMainForm
  Left = -7
  Top = 107
  Caption = 'My Finances'
  ClientHeight = 599
  ClientWidth = 1261
  Color = clBtnFace
  Constraints.MinWidth = 1000
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Calibri'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 18
  object pgcMain: TPageControl
    Left = 0
    Top = 29
    Width = 1261
    Height = 570
    ActivePage = tsMovements
    Align = alClient
    TabOrder = 0
    object Summary: TTabSheet
      Caption = 'Summary'
      ImageIndex = 4
      OnShow = SummaryShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Splitter1: TSplitter
        Left = 0
        Top = 352
        Width = 1253
        Height = 8
        Cursor = crVSplit
        Align = alBottom
        Beveled = True
        ExplicitTop = 350
      end
      object pnlMostTop: TPanel
        Left = 0
        Top = 0
        Width = 1253
        Height = 41
        Align = alTop
        TabOrder = 0
        object Label4: TLabel
          Left = 303
          Top = 7
          Width = 120
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Show from:'
        end
        object DBNavigator5: TDBNavigator
          Left = 7
          Top = 4
          Width = 280
          Height = 26
          DataSource = Summary_DS
          VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object DateTimePicker1: TDateTimePicker
          Left = 429
          Top = 4
          Width = 124
          Height = 26
          Date = 43225.724270798610000000
          Time = 43225.724270798610000000
          TabOrder = 1
          OnChange = DateTimePicker1Change
        end
      end
      object pnlMostBottom: TPanel
        Left = 0
        Top = 360
        Width = 1253
        Height = 177
        Align = alBottom
        TabOrder = 1
        object splLeft: TSplitter
          Left = 433
          Top = 1
          Width = 8
          Height = 175
          Beveled = True
          ExplicitLeft = 413
          ExplicitHeight = 119
        end
        object pnlLeftBottom: TPanel
          Left = 1
          Top = 1
          Width = 432
          Height = 175
          Align = alLeft
          BevelOuter = bvNone
          Caption = 'pnlLeftBottom'
          TabOrder = 0
          object dbgrdAccountPayments: TDBGridEasy
            Left = 0
            Top = 25
            Width = 432
            Height = 150
            Align = alClient
            DataSource = ACCOUNTPAYMENTS_DS
            DefaultDrawing = True
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -15
            TitleFont.Name = 'Calibri'
            TitleFont.Style = []
            AltColor = 15792629
            Columns = <
              item
                Expanded = False
                FieldName = 'FROMACCOUNT'
                Title.Alignment = taCenter
                Title.Caption = 'Account'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clWindowText
                Title.Font.Height = -15
                Title.Font.Name = 'Calibri'
                Title.Font.Style = [fsBold]
                Width = 200
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'MOVSTATUS'
                Title.Alignment = taCenter
                Title.Caption = 'Status'
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
                FieldName = 'TOTALPAYMENT'
                Title.Alignment = taCenter
                Title.Caption = 'Total Paymnt.'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clWindowText
                Title.Font.Height = -15
                Title.Font.Name = 'Calibri'
                Title.Font.Style = [fsBold]
                Width = 100
                Visible = True
              end>
          end
          object pnlAPTitle: TPanel
            Left = 0
            Top = 0
            Width = 432
            Height = 25
            Align = alTop
            BevelKind = bkSoft
            BevelOuter = bvNone
            Caption = 'Total payments by status and by account'
            TabOrder = 1
          end
        end
        object pnlRightBottom: TPanel
          Left = 441
          Top = 1
          Width = 811
          Height = 175
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object Splitter3: TSplitter
            Left = 416
            Top = 0
            Width = 8
            Height = 175
            Align = alRight
            Beveled = True
            ExplicitLeft = 504
            ExplicitTop = 1
            ExplicitHeight = 117
          end
          object pnlRightMostBottom: TPanel
            Left = 424
            Top = 0
            Width = 387
            Height = 175
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 0
            object dbgrdAccountBalances: TDBGridEasy
              Left = 0
              Top = 25
              Width = 387
              Height = 150
              Align = alClient
              DataSource = ACCOUNTBALANCES_DS
              DefaultDrawing = True
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -15
              TitleFont.Name = 'Calibri'
              TitleFont.Style = []
              AltColor = 15792629
              Columns = <
                item
                  Expanded = False
                  FieldName = 'NAME'
                  Title.Alignment = taCenter
                  Title.Caption = 'Account'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clWindowText
                  Title.Font.Height = -15
                  Title.Font.Name = 'Calibri'
                  Title.Font.Style = [fsBold]
                  Width = 200
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'BALANCE'
                  Title.Alignment = taCenter
                  Title.Caption = 'Balance'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clWindowText
                  Title.Font.Height = -15
                  Title.Font.Name = 'Calibri'
                  Title.Font.Style = [fsBold]
                  Width = 100
                  Visible = True
                end>
            end
            object Panel5: TPanel
              Left = 0
              Top = 0
              Width = 387
              Height = 25
              Align = alTop
              BevelKind = bkSoft
              BevelOuter = bvNone
              Caption = 'Accounts balances'
              TabOrder = 1
            end
          end
          object pnlMiddleBottom: TPanel
            Left = 0
            Top = 0
            Width = 416
            Height = 175
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object dbgrdAccountTotals: TDBGridEasy
              Left = 0
              Top = 25
              Width = 416
              Height = 150
              Align = alClient
              DataSource = ACCOUNTTOTALS_DS
              DefaultDrawing = True
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -15
              TitleFont.Name = 'Calibri'
              TitleFont.Style = []
              AltColor = 15792629
              Columns = <
                item
                  Expanded = False
                  FieldName = 'FROMACCOUNT'
                  Title.Alignment = taCenter
                  Title.Caption = 'Account'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clWindowText
                  Title.Font.Height = -15
                  Title.Font.Name = 'Calibri'
                  Title.Font.Style = [fsBold]
                  Width = 200
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'TOTALPAYMENT'
                  Title.Alignment = taCenter
                  Title.Caption = 'Total Paymnt.'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clWindowText
                  Title.Font.Height = -15
                  Title.Font.Name = 'Calibri'
                  Title.Font.Style = [fsBold]
                  Width = 100
                  Visible = True
                end>
            end
            object Panel6: TPanel
              Left = 0
              Top = 0
              Width = 416
              Height = 25
              Align = alTop
              BevelKind = bkSoft
              BevelOuter = bvNone
              Caption = 'Total payments by accounts'
              TabOrder = 1
            end
          end
        end
      end
      object pnlTop: TPanel
        Left = 0
        Top = 41
        Width = 1253
        Height = 311
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        TabOrder = 2
        object dbgrdSummary: TDBGridEasy
          Left = 0
          Top = 25
          Width = 1249
          Height = 263
          Align = alClient
          DataSource = Summary_DS
          DefaultDrawing = True
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
          PopupMenu = pmSummary
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -15
          TitleFont.Name = 'Calibri'
          TitleFont.Style = []
          OnCellClick = dbgrdSummaryCellClick
          OnDrawColumnCell = DrawColumnCell
          OnKeyUp = dbgrdSummaryKeyUp
          OnTitleClick = dbgrdSummaryTitleClick
          AltColor = 15792629
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'BILLERTYPE'
              Title.Alignment = taCenter
              Title.Caption = 'BT'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -15
              Title.Font.Name = 'Calibri'
              Title.Font.Style = [fsBold]
              Width = 20
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'BILLERNAME'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 3289650
              Font.Height = -15
              Font.Name = 'Calibri'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'Biller name'
              Title.Color = clGray
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -15
              Title.Font.Name = 'Calibri'
              Title.Font.Style = [fsBold]
              Width = 240
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'DUEDATE'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 3289650
              Font.Height = -15
              Font.Name = 'Calibri'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'Due date'
              Title.Color = clGray
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -15
              Title.Font.Name = 'Calibri'
              Title.Font.Style = [fsBold]
              Width = 75
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'DAYSLEFT'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 3289650
              Font.Height = -15
              Font.Name = 'Calibri'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'Days'
              Title.Color = clGray
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -15
              Title.Font.Name = 'Calibri'
              Title.Font.Style = [fsBold]
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PAYMENTDUE'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 3289650
              Font.Height = -15
              Font.Name = 'Calibri'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'Bill amount'
              Title.Color = clGray
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -15
              Title.Font.Name = 'Calibri'
              Title.Font.Style = [fsBold]
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'PAYDATE'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 3289650
              Font.Height = -15
              Font.Name = 'Calibri'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'Pay Date'
              Title.Color = clGray
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
              FieldName = 'PAYAMOUNT'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 3289650
              Font.Height = -15
              Font.Name = 'Calibri'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'Pay Amount'
              Title.Color = clGray
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -15
              Title.Font.Name = 'Calibri'
              Title.Font.Style = [fsBold]
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'BALANCE'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 3289650
              Font.Height = -15
              Font.Name = 'Calibri'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'Balance'
              Title.Color = clGray
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
              FieldName = 'FROMACCOUNT'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 3289650
              Font.Height = -15
              Font.Name = 'Calibri'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'Source'
              Title.Color = clGray
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -15
              Title.Font.Name = 'Calibri'
              Title.Font.Style = [fsBold]
              Width = 200
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'MOVSTATUS'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 3289650
              Font.Height = -15
              Font.Name = 'Calibri'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'Status'
              Title.Color = clGray
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -15
              Title.Font.Name = 'Calibri'
              Title.Font.Style = [fsBold]
              Width = 75
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'MOVCHECKED'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 3289650
              Font.Height = -15
              Font.Name = 'Calibri'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'Checked'
              Title.Color = clGray
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -15
              Title.Font.Name = 'Calibri'
              Title.Font.Style = [fsBold]
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'BILLSNOTES'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 3289650
              Font.Height = -15
              Font.Name = 'Calibri'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'Bill notes'
              Title.Color = clGray
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -15
              Title.Font.Name = 'Calibri'
              Title.Font.Style = [fsBold]
              Width = 240
              Visible = True
            end>
        end
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 1249
          Height = 25
          Align = alTop
          BevelKind = bkSoft
          BevelOuter = bvNone
          Caption = 'Summary of movements/bills per biller since selected date'
          TabOrder = 1
        end
        object StatusBar4: TStatusBar
          Left = 0
          Top = 288
          Width = 1249
          Height = 19
          BorderWidth = 1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Calibri'
          Font.Style = []
          Panels = <
            item
              Text = 'Total bill amount:'
              Width = 200
            end
            item
              Text = 'Total pay amount:'
              Width = 200
            end
            item
              Text = 'Total balance:'
              Width = 200
            end>
          ParentShowHint = False
          ShowHint = False
          SizeGrip = False
          UseSystemFont = False
        end
      end
    end
    object tsAccounts: TTabSheet
      Caption = 'Accounts'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object StatusBar1: TStatusBar
        Left = 0
        Top = 518
        Width = 1253
        Height = 19
        Panels = <>
      end
      object dbgrdAccounts: TDBGridEasy
        Left = 0
        Top = 41
        Width = 1253
        Height = 477
        Align = alClient
        DataSource = Accounts_DS
        DefaultDrawing = True
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = 'Calibri'
        TitleFont.Style = []
        OnDrawColumnCell = DrawColumnCell
        AltColor = 15857656
        Columns = <
          item
            Expanded = False
            FieldName = 'Name'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Color = clGray
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 240
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Type'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            PickList.Strings = (
              'Checking'
              'Savings'
              'Credit Card'
              'Biller')
            Title.Alignment = taCenter
            Title.Color = clGray
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 100
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Sub_Type'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            PickList.Strings = (
              'Visa'
              'Master'
              'Discover'
              'Amex'
              'Other')
            Title.Alignment = taCenter
            Title.Caption = 'Sub type'
            Title.Color = clGray
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 100
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Begin_Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'Since'
            Title.Color = clGray
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 70
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'End_Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'Through'
            Title.Color = clGray
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 70
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Active'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            PickList.Strings = (
              'Yes'
              'No')
            Title.Alignment = taCenter
            Title.Color = clGray
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Notes'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Color = clGray
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 400
            Visible = True
          end>
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 1253
        Height = 41
        Align = alTop
        TabOrder = 2
        object DBNavigator3: TDBNavigator
          Left = 7
          Top = 4
          Width = 290
          Height = 26
          DataSource = Accounts_DS
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = DBNavigator3Click
        end
      end
    end
    object tsMovements: TTabSheet
      Caption = 'Movements'
      ImageIndex = 4
      OnShow = TabSheetShow
      object dbgrdMovements: TDBGridEasy
        Left = 0
        Top = 41
        Width = 1253
        Height = 477
        Align = alClient
        DataSource = Movements_DS
        DefaultDrawing = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = 'Calibri'
        TitleFont.Style = []
        OnCellClick = dbgrdMovementsCellClick
        OnDrawColumnCell = DrawColumnCell
        AltColor = 16381168
        Columns = <
          item
            Alignment = taLeftJustify
            Expanded = False
            FieldName = 'Type'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
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
            Width = 120
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Op_Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'Date'
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
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
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
            FieldName = 'Amount'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
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
            FieldName = 'Run_Balance'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'Balance'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 75
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Status'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            PickList.Strings = (
              'Planned'
              'Posted'
              'Cancelled')
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
            Alignment = taCenter
            Expanded = False
            FieldName = 'Checked'
            PickList.Strings = (
              'Yes'
              'No')
            Title.Alignment = taCenter
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TargetName'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'Target account'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 180
            Visible = True
          end
          item
            DropDownRows = 10
            Expanded = False
            FieldName = 'Bill'
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
            FieldName = 'Notes'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
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
      object StatusBar5: TStatusBar
        Left = 0
        Top = 518
        Width = 1253
        Height = 19
        Panels = <>
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 1253
        Height = 41
        Align = alTop
        TabOrder = 2
        object Label3: TLabel
          Left = 303
          Top = 7
          Width = 120
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Select Account:'
        end
        object cbbMovements: TComboBox
          Left = 429
          Top = 4
          Width = 365
          Height = 26
          Style = csDropDownList
          DropDownCount = 20
          TabOrder = 0
          OnSelect = ComboBoxSelect
        end
        object btnPasteFromSS: TButton
          Left = 800
          Top = 4
          Width = 161
          Height = 26
          Caption = 'Paste from spreadsheet'
          TabOrder = 1
          OnClick = btnPasteFromSSClick
        end
        object DBNavigator1: TDBNavigator
          Left = 7
          Top = 4
          Width = 290
          Height = 26
          DataSource = Movements_DS
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
        end
        object Button1: TButton
          Left = 1032
          Top = 10
          Width = 75
          Height = 25
          Caption = 'Scroll Y'
          TabOrder = 3
          OnClick = Button1Click
        end
        object Edit1: TEdit
          Left = 1113
          Top = 9
          Width = 121
          Height = 26
          TabOrder = 4
          Text = '0'
        end
      end
    end
    object tsBills: TTabSheet
      Caption = 'Bills'
      ImageIndex = 2
      OnShow = TabSheetShow
      object StatusBar3: TStatusBar
        Left = 0
        Top = 518
        Width = 1253
        Height = 19
        Panels = <>
      end
      object dbgrdBills: TDBGridEasy
        Left = 0
        Top = 41
        Width = 1253
        Height = 477
        Align = alClient
        DataSource = Bills_DS
        DefaultDrawing = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = 'Calibri'
        TitleFont.Style = []
        AltColor = 15724794
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'C_F_Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'From'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 75
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'C_T_Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'To'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 75
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Days_In_Cycle'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'Days'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 40
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Payment_Due'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'Paymt. Due'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Due_Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'Due Date'
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
            FieldName = 'Payment'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
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
            Alignment = taCenter
            Expanded = False
            FieldName = 'LP_Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'Last P. Date'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Balance'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
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
            FieldName = 'Notes'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 400
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Active'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            PickList.Strings = (
              'Open'
              'Closed')
            Title.Alignment = taCenter
            Title.Caption = 'Status'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 70
            Visible = True
          end>
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1253
        Height = 41
        Align = alTop
        TabOrder = 2
        object Label2: TLabel
          Left = 303
          Top = 7
          Width = 120
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Select biller:'
        end
        object btnCreditCardBillers: TSpeedButton
          Left = 833
          Top = 4
          Width = 27
          Height = 26
          Hint = 'Credit Cards only'
          GroupIndex = 1
          Caption = 'CC'
          ParentShowHint = False
          ShowHint = True
          OnClick = btnBillersClick
        end
        object btnOtherBillers: TSpeedButton
          Left = 866
          Top = 4
          Width = 27
          Height = 26
          Hint = 'Other billers only'
          GroupIndex = 1
          Caption = 'OB'
          ParentShowHint = False
          ShowHint = True
          OnClick = btnBillersClick
        end
        object btnAllBillers: TSpeedButton
          Left = 800
          Top = 4
          Width = 27
          Height = 26
          Hint = 'All billers'
          GroupIndex = 1
          Down = True
          Caption = 'A'
          ParentShowHint = False
          ShowHint = True
          OnClick = btnBillersClick
        end
        object cbbBills: TComboBox
          Left = 429
          Top = 4
          Width = 365
          Height = 26
          Style = csDropDownList
          DropDownCount = 20
          TabOrder = 0
          OnSelect = ComboBoxSelect
        end
        object DBNavigator2: TDBNavigator
          Left = 7
          Top = 4
          Width = 290
          Height = 26
          DataSource = Bills_DS
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = DBNavigator2Click
        end
      end
    end
    object tsFULLCCS: TTabSheet
      Caption = 'Credit card statements'
      ImageIndex = 3
      OnShow = TabSheetShow
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1253
        Height = 41
        Align = alTop
        TabOrder = 0
        object Label1: TLabel
          Left = 303
          Top = 7
          Width = 120
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Select credit card:'
        end
        object cbbFULLCCS: TComboBox
          Left = 429
          Top = 4
          Width = 365
          Height = 26
          Style = csDropDownList
          DropDownCount = 20
          TabOrder = 0
          OnSelect = ComboBoxSelect
        end
        object DBNavigator4: TDBNavigator
          Left = 7
          Top = 4
          Width = 290
          Height = 26
          DataSource = FULLCCS_DS
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = DBNavigator4Click
        end
      end
      object dbgrdCCStatements: TDBGridEasy
        Left = 0
        Top = 41
        Width = 1253
        Height = 477
        Align = alClient
        DataSource = FULLCCS_DS
        DefaultDrawing = True
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = 'Calibri'
        TitleFont.Style = []
        AltColor = 16249588
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'C_F_Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'From'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 75
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'C_T_Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'To'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 75
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Days_In_Cycle'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'Days'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 40
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Interest_Rate'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'APR'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Payment_Due'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'Min. Paymt.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 75
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Due_Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'Due Date'
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
            FieldName = 'Prev_Payments'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'Payments'
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
            FieldName = 'Prev_Expenses'
            Title.Alignment = taCenter
            Title.Caption = 'Expenses'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Charged_Interests'
            Title.Alignment = taCenter
            Title.Caption = 'Interests'
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
            FieldName = 'Charged_Fees'
            Title.Alignment = taCenter
            Title.Caption = 'Fees'
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
            FieldName = 'Prev_Balance'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'Balance'
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
            FieldName = 'Limit'
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
            FieldName = 'Utilization'
            Title.Alignment = taCenter
            Title.Caption = '% U.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 40
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Available_Credit'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            PickList.Strings = (
              'Open'
              'Closed')
            Title.Alignment = taCenter
            Title.Caption = 'Av. Credit'
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
            FieldName = 'Notes'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3289650
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -15
            Title.Font.Name = 'Calibri'
            Title.Font.Style = [fsBold]
            Width = 400
            Visible = True
          end>
      end
      object StatusBar2: TStatusBar
        Left = 0
        Top = 518
        Width = 1253
        Height = 19
        Panels = <>
      end
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 1261
    Height = 29
    ButtonHeight = 18
    Caption = 'ToolBar1'
    TabOrder = 1
  end
  object Accounts_DS: TDataSource
    DataSet = DM.ACCOUNTS
    Left = 64
    Top = 320
  end
  object Bills_DS: TDataSource
    DataSet = DM.BILLS
    Left = 224
    Top = 320
  end
  object FULLCCS_DS: TDataSource
    DataSet = DM.FULLCCS
    Left = 312
    Top = 320
  end
  object Movements_DS: TDataSource
    DataSet = DM.MOVEMENTS
    Left = 152
    Top = 320
  end
  object Summary_DS: TDataSource
    AutoEdit = False
    DataSet = DM.SUMMARY
    Left = 64
    Top = 264
  end
  object pmSummary: TPopupMenu
    OnPopup = pmSummaryPopup
    Left = 64
    Top = 200
    object Viewbill1: TMenuItem
      Caption = 'View bill'
      OnClick = pmSummaryViewbillClick
    end
    object Gotomovement1: TMenuItem
      Caption = 'Go to movement'
      OnClick = pmSummaryGotoMovementClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Refresh1: TMenuItem
      Caption = 'Refresh'
      OnClick = pmSummaryRefreshClick
    end
  end
  object ACCOUNTPAYMENTS_DS: TDataSource
    AutoEdit = False
    DataSet = DM.ACCOUNTPAYMENTS
    Left = 416
    Top = 256
  end
  object ACCOUNTTOTALS_DS: TDataSource
    AutoEdit = False
    DataSet = DM.ACCOUNTTOTALS
    Left = 536
    Top = 256
  end
  object ACCOUNTBALANCES_DS: TDataSource
    AutoEdit = False
    DataSet = DM.ACCOUNTBALANCES
    Left = 664
    Top = 256
  end
end
