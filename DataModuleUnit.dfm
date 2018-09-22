object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 405
  Width = 717
  object ZConnection1: TZConnection
    ControlsCodePage = cCP_UTF16
    TransactIsolationLevel = tiReadCommitted
    Port = 0
    Protocol = 'sqlite-3'
    Left = 552
    Top = 16
  end
  object ACCOUNTS: TZTable
    Connection = ZConnection1
    SortedFields = 'Type;Name'
    AutoCalcFields = False
    AfterScroll = ACCOUNTSAfterScroll
    AfterInsert = ACCOUNTSAfterInsert
    BeforePost = ACCOUNTSBeforePost
    AfterPost = ACCOUNTSAfterPost
    TableName = 'ACCOUNTS'
    IndexFieldNames = 'Type Asc;Name Asc'
    Left = 24
    Top = 16
    object ACCOUNTSId: TLargeintField
      FieldName = 'Id'
    end
    object ACCOUNTSName: TWideStringField
      FieldName = 'Name'
      Required = True
      Size = 60
    end
    object ACCOUNTSType: TLargeintField
      FieldName = 'Type'
      Required = True
      OnChange = ACCOUNTSTypeChange
      OnGetText = ACCOUNTSTypeGetText
      OnSetText = ACCOUNTSTypeSetText
    end
    object ACCOUNTSSub_Type: TLargeintField
      FieldName = 'Sub_Type'
      OnGetText = ACCOUNTSSub_TypeGetText
      OnSetText = ACCOUNTSSub_TypeSetText
    end
    object ACCOUNTSBegin_Date: TDateField
      FieldName = 'Begin_Date'
      OnSetText = ValidateDate
      DisplayFormat = 'mm/dd/yy'
      EditMask = '!99/99/00;1;_'
    end
    object ACCOUNTSEnd_Date: TDateField
      FieldName = 'End_Date'
      OnSetText = ValidateDate
      DisplayFormat = 'mm/dd/yy'
      EditMask = '!99/99/00;1;_'
    end
    object ACCOUNTSActive: TBooleanField
      DefaultExpression = #39'TRUE'#39
      FieldName = 'Active'
      OnGetText = YESNOGetText
      OnSetText = YESNOSetText
    end
    object ACCOUNTSNotes: TWideStringField
      FieldName = 'Notes'
      Size = 160
    end
  end
  object ZQuery1: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 664
    Top = 16
  end
  object FULLCCS: TZQuery
    Connection = ZConnection1
    OnCalcFields = FULLCCSCalcFields
    CachedUpdates = True
    AfterInsert = FULLCCSAfterInsert
    BeforePost = FULLCCSBeforePost
    BeforeDelete = FULLCCSBeforeDelete
    SQL.Strings = (
      
        'SELECT * FROM BILLS INNER JOIN CCSTATEMENTS ON BILLS.Id=CCSTATEM' +
        'ENTS.Bill_Id'
      'WHERE Biller_Id=:RefId'
      'ORDER BY C_F_Date DESC')
    Params = <
      item
        DataType = ftWideString
        Name = 'RefId'
        ParamType = ptUnknown
        Value = 8
      end>
    Left = 192
    Top = 16
    ParamData = <
      item
        DataType = ftWideString
        Name = 'RefId'
        ParamType = ptUnknown
        Value = 8
      end>
    object FULLCCSId: TLargeintField
      FieldName = 'Id'
    end
    object FULLCCSBiller_Id: TLargeintField
      FieldName = 'Biller_Id'
      Required = True
    end
    object FULLCCSC_F_Date: TDateField
      FieldName = 'C_F_Date'
      Required = True
      OnSetText = ValidateDate
      OnValidate = FULLCCSValidateCycleDate
      DisplayFormat = 'mm/dd/yy'
      EditMask = '!99/99/00;1;_'
    end
    object FULLCCSC_T_Date: TDateField
      FieldName = 'C_T_Date'
      Required = True
      OnSetText = ValidateDate
      OnValidate = FULLCCSValidateCycleDate
      DisplayFormat = 'mm/dd/yy'
      EditMask = '!99/99/00;1;_'
    end
    object FULLCCSPayment_Due: TFloatField
      FieldName = 'Payment_Due'
      Required = True
      currency = True
    end
    object FULLCCSDue_Date: TDateField
      FieldName = 'Due_Date'
      Required = True
      OnSetText = ValidateDate
      DisplayFormat = 'mm/dd/yy'
      EditMask = '!99/99/00;1;_'
    end
    object FULLCCSPayment: TFloatField
      FieldName = 'Payment'
      currency = True
    end
    object FULLCCSLP_Date: TDateField
      FieldName = 'LP_Date'
      OnSetText = ValidateDate
      DisplayFormat = 'mm/dd/yy'
      EditMask = '!99/99/00;1;_'
    end
    object FULLCCSActive: TBooleanField
      FieldName = 'Active'
    end
    object FULLCCSNotes: TWideStringField
      FieldName = 'Notes'
      Size = 160
    end
    object FULLCCSSid: TLargeintField
      FieldName = 'Sid'
    end
    object FULLCCSBill_Id: TLargeintField
      FieldName = 'Bill_Id'
    end
    object FULLCCSPrev_Payments: TFloatField
      FieldName = 'Prev_Payments'
      OnChange = FULLCCSPaymtAndChargesChange
      currency = True
    end
    object FULLCCSPrev_Expenses: TFloatField
      FieldName = 'Prev_Expenses'
      OnChange = FULLCCSPaymtAndChargesChange
      currency = True
    end
    object FULLCCSCharged_Interests: TFloatField
      FieldName = 'Charged_Interests'
      OnChange = FULLCCSPaymtAndChargesChange
      currency = True
    end
    object FULLCCSCharged_Fees: TFloatField
      FieldName = 'Charged_Fees'
      OnChange = FULLCCSPaymtAndChargesChange
      currency = True
    end
    object FULLCCSPrev_Balance: TFloatField
      FieldName = 'Prev_Balance'
      currency = True
    end
    object FULLCCSInterest_Rate: TFloatField
      FieldName = 'Interest_Rate'
      DisplayFormat = '0.00%'
      EditFormat = '0.00'
    end
    object FULLCCSLimit: TFloatField
      FieldName = 'Limit'
      currency = True
    end
    object FULLCCSAvailable_Credit: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'Available_Credit'
      Calculated = True
    end
    object FULLCCSUtilization: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Utilization'
      DisplayFormat = '0%'
      Calculated = True
    end
    object FULLCCSDays_In_Cycle: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'Days_In_Cycle'
      Calculated = True
    end
  end
  object BILLS: TZQuery
    Connection = ZConnection1
    OnCalcFields = BILLSCalcFields
    BeforeInsert = BILLSBeforeInsert
    AfterInsert = BILLSAfterInsert
    BeforePost = BILLSBeforePost
    AfterPost = BILLSAfterPost
    BeforeDelete = BILLSBeforeDelete
    SQL.Strings = (
      
        'SELECT * FROM BILLS WHERE Biller_Id=:RefId ORDER BY C_F_Date DES' +
        'C')
    Params = <
      item
        DataType = ftWideString
        Name = 'RefId'
        ParamType = ptUnknown
        Value = 8
      end>
    Left = 112
    Top = 16
    ParamData = <
      item
        DataType = ftWideString
        Name = 'RefId'
        ParamType = ptUnknown
        Value = 8
      end>
    object BILLSId: TLargeintField
      FieldName = 'Id'
    end
    object BILLSBiller_Id: TLargeintField
      FieldName = 'Biller_Id'
      Required = True
    end
    object BILLSC_F_Date: TDateField
      FieldName = 'C_F_Date'
      Required = True
      OnSetText = ValidateDate
      OnValidate = BILLSValidateCycleDate
      DisplayFormat = 'mm/dd/yy'
      EditMask = '!99/99/00;1;_'
    end
    object BILLSC_T_Date: TDateField
      FieldName = 'C_T_Date'
      Required = True
      OnSetText = ValidateDate
      OnValidate = BILLSValidateCycleDate
      DisplayFormat = 'mm/dd/yy'
      EditMask = '!99/99/00;1;_'
    end
    object BILLSPayment_Due: TFloatField
      FieldName = 'Payment_Due'
      Required = True
      currency = True
    end
    object BILLSDue_Date: TDateField
      FieldName = 'Due_Date'
      Required = True
      OnSetText = ValidateDate
      DisplayFormat = 'mm/dd/yy'
      EditMask = '!99/99/00;1;_'
    end
    object BILLSPayment: TFloatField
      FieldName = 'Payment'
      currency = True
    end
    object BILLSBalance: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Balance'
      currency = True
      Calculated = True
    end
    object BILLSLP_Date: TDateField
      FieldName = 'LP_Date'
      DisplayFormat = 'mm/dd/yy'
      EditMask = '!99/99/00;1;_'
    end
    object BILLSActive: TBooleanField
      DefaultExpression = #39'TRUE'#39
      FieldName = 'Active'
      OnGetText = BILLSActiveGetText
      OnSetText = BILLSActiveSetText
    end
    object BILLSDays_In_Cycle: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'Days_In_Cycle'
      Calculated = True
    end
    object BILLSNotes: TWideStringField
      FieldName = 'Notes'
      Size = 160
    end
  end
  object MOVEMENTS: TZQuery
    Connection = ZConnection1
    AfterScroll = MOVEMENTSAfterScroll
    BeforeInsert = MOVEMENTSBeforeInsert
    AfterInsert = MOVEMENTSAfterInsert
    BeforePost = MOVEMENTSBeforePost
    AfterCancel = MOVEMENTSAfterCancel
    BeforeDelete = MOVEMENTSBeforeDelete
    SQL.Strings = (
      
        'SELECT * FROM MOVEMENTS WHERE Account_Id=:RefId ORDER BY Op_Date' +
        ' DESC, Id DESC')
    Params = <
      item
        DataType = ftWideString
        Name = 'RefId'
        ParamType = ptUnknown
        Value = 1
      end>
    Left = 320
    Top = 16
    ParamData = <
      item
        DataType = ftWideString
        Name = 'RefId'
        ParamType = ptUnknown
        Value = 1
      end>
    object MOVEMENTSId: TLargeintField
      FieldName = 'Id'
    end
    object MOVEMENTSAccount_Id: TLargeintField
      FieldName = 'Account_id'
      Required = True
    end
    object MOVEMENTSOp_Date: TDateField
      FieldName = 'Op_Date'
      Required = True
      OnSetText = ValidateDate
      DisplayFormat = 'mm/dd/yy'
      EditMask = '!99/99/00;1;_'
    end
    object MOVEMENTSAmount: TFloatField
      FieldName = 'Amount'
      Required = True
      currency = True
    end
    object MOVEMENTSType: TLargeintField
      FieldName = 'Type'
      Required = True
      OnChange = MOVEMENTSTypeChange
      OnGetText = TypeGetText
      OnSetText = TypeSetText
    end
    object MOVEMENTSStatus: TLargeintField
      FieldName = 'Status'
      Required = True
      OnChange = MOVEMENTSStatusChange
      OnGetText = MOVEMENTSStatusGetText
      OnSetText = MOVEMENTSStatusSetText
    end
    object MOVEMENTSDescription: TWideStringField
      FieldName = 'Description'
      Required = True
      Size = 60
    end
    object MOVEMENTSTarget_Id: TLargeintField
      FieldName = 'Target_Id'
    end
    object MOVEMENTSRun_Balance: TFloatField
      FieldName = 'Run_Balance'
      ReadOnly = True
      currency = True
    end
    object MOVEMENTSLinked_Op: TLargeintField
      FieldName = 'Linked_Op'
    end
    object MOVEMENTSLinked_Bill: TLargeintField
      FieldName = 'Linked_Bill'
      OnChange = MOVEMENTSLinked_BillChange
    end
    object MOVEMENTSNotes: TWideStringField
      FieldName = 'Notes'
      Size = 160
    end
    object MOVEMENTSChecked: TBooleanField
      FieldName = 'Checked'
      OnGetText = MOVEMENTSCheckedGetText
      OnSetText = MOVEMENTSCheckedSetText
    end
    object MOVEMENTSTargetName: TStringField
      FieldKind = fkLookup
      FieldName = 'TargetName'
      LookupDataSet = TRANSFERACCOUNTS
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'Target_Id'
      Size = 60
      Lookup = True
    end
    object MOVEMENTSBill: TStringField
      DisplayWidth = 60
      FieldKind = fkLookup
      FieldName = 'Bill'
      LookupDataSet = OPENBILLS
      LookupKeyFields = 'Id'
      LookupResultField = 'Bill'
      KeyFields = 'Linked_Bill'
      Size = 60
      Lookup = True
    end
  end
  object ZQuery2: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 664
    Top = 72
  end
  object PastingDS: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Date'
        DataType = ftDate
      end
      item
        Name = 'Amount'
        DataType = ftCurrency
      end
      item
        Name = 'Type'
        DataType = ftLargeint
      end
      item
        Name = 'Description'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 60
      end
      item
        Name = 'Target_Id'
        DataType = ftLargeint
      end
      item
        Name = 'Linked_Op'
        DataType = ftLargeint
      end
      item
        Name = 'Linked_Bill'
        DataType = ftLargeint
      end
      item
        Name = 'Notes'
        DataType = ftWideString
        Size = 160
      end
      item
        Name = 'Paste'
        DataType = ftBoolean
      end
      item
        Name = 'Success'
        DataType = ftBoolean
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
      end
      item
        Name = 'CHANGEINDEX'
      end
      item
        Name = 'ASC_Date'
        Fields = 'Date'
      end
      item
        Name = 'DSC_Date'
        Fields = 'Date'
        Options = [ixDescending]
      end
      item
        Name = 'ASC_Type'
        Fields = 'Type'
      end
      item
        Name = 'DSC_Type'
        Fields = 'Type'
        Options = [ixDescending]
      end
      item
        Name = 'ASC_Description'
        Fields = 'Description'
      end
      item
        Name = 'DSC_Description'
        Fields = 'Description'
        Options = [ixDescending]
      end
      item
        Name = 'ASC_Notes'
        Fields = 'Notes'
      end
      item
        Name = 'DSC_Notes'
        Fields = 'Notes'
        Options = [ixDescending]
      end
      item
        Name = 'ASC_Paste'
        Fields = 'Paste'
      end
      item
        Name = 'DSC_Paste'
        Fields = 'Paste'
        Options = [ixDescending]
      end
      item
        Name = 'ASC_Amount'
        Fields = 'Amount'
      end
      item
        Name = 'DSC_Amount'
        Fields = 'Amount'
        Options = [ixDescending]
      end>
    Params = <>
    StoreDefs = True
    AfterScroll = PastingDSAfterScroll
    Left = 48
    Top = 88
    object PastingDSDate: TDateField
      FieldName = 'Date'
      OnSetText = ValidateDate
      DisplayFormat = 'mm/dd/yy'
      EditMask = '!99/99/00;1;_'
    end
    object PastingDSAmount: TCurrencyField
      FieldName = 'Amount'
    end
    object PastingDSType: TLargeintField
      FieldName = 'Type'
      OnChange = PastingDSTypeChange
      OnGetText = TypeGetText
      OnSetText = TypeSetText
    end
    object PastingDSDescription: TWideStringField
      FieldName = 'Description'
      Required = True
      Size = 60
    end
    object PastingDSTarget_Id: TLargeintField
      FieldName = 'Target_Id'
    end
    object PastingDSLinked_Op: TLargeintField
      FieldName = 'Linked_Op'
    end
    object PastingDSLinked_Bill: TLargeintField
      FieldName = 'Linked_Bill'
    end
    object PastingDSNotes: TWideStringField
      FieldName = 'Notes'
      Size = 160
    end
    object PastingDSPaste: TBooleanField
      DefaultExpression = #39'FALSE'#39
      FieldName = 'Paste'
      OnGetText = YESNOGetText
      OnSetText = YESNOSetText
    end
    object PastingDSTargetName: TStringField
      FieldKind = fkLookup
      FieldName = 'TargetName'
      LookupDataSet = TRANSFERACCOUNTS
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'Target_Id'
      Size = 60
      Lookup = True
    end
    object PastingDSBill: TStringField
      DisplayWidth = 60
      FieldKind = fkLookup
      FieldName = 'Bill'
      LookupDataSet = OPENBILLS
      LookupKeyFields = 'Id'
      LookupResultField = 'Bill'
      KeyFields = 'Linked_Bill'
      Size = 60
      Lookup = True
    end
    object PastingDSSuccess: TBooleanField
      FieldName = 'Success'
    end
  end
  object OPENBILLS: TZQuery
    Connection = ZConnection1
    AfterRefresh = OPENBILLSAfterRefresh
    OnCalcFields = OPENBILLSCalcFields
    Filter = 'Active='#39'Y'#39
    SQL.Strings = (
      
        'SELECT BILLS.Id, Payment_Due, Payment, Due_Date, Name, BILLS.Act' +
        'ive FROM'
      'BILLS INNER JOIN ACCOUNTS ON BILLS.Biller_Id=ACCOUNTS.Id'
      'ORDER BY Due_Date ASC')
    Params = <>
    Left = 320
    Top = 64
    object OPENBILLSId: TLargeintField
      FieldName = 'Id'
    end
    object OPENBILLSPayment_Due: TFloatField
      FieldName = 'Payment_Due'
      Required = True
      currency = True
    end
    object OPENBILLSPayment: TFloatField
      FieldName = 'Payment'
      currency = True
    end
    object OPENBILLSDue_Date: TDateField
      FieldName = 'Due_Date'
      Required = True
      DisplayFormat = 'mm/dd/yy'
    end
    object OPENBILLSName: TWideStringField
      FieldName = 'Name'
      Required = True
      Size = 60
    end
    object OPENBILLSActive: TBooleanField
      FieldName = 'Active'
    end
    object OPENBILLSBill: TStringField
      FieldKind = fkCalculated
      FieldName = 'Bill'
      Size = 60
      Calculated = True
    end
    object OPENBILLSPendingAmount: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'PendingAmount'
      Calculated = True
    end
  end
  object TRANSFERACCOUNTS: TZQuery
    Connection = ZConnection1
    SQL.Strings = (
      
        'SELECT Id, Type, Name FROM ACCOUNTS WHERE Active='#39'Y'#39' AND Type<3 ' +
        'ORDER BY Name')
    Params = <>
    Left = 320
    Top = 120
    object TRANSFERACCOUNTSId: TLargeintField
      FieldName = 'Id'
    end
    object TRANSFERACCOUNTSType: TLargeintField
      FieldName = 'Type'
      Required = True
    end
    object TRANSFERACCOUNTSName: TWideStringField
      FieldName = 'Name'
      Required = True
      Size = 60
    end
  end
  object SUMMARY: TZTable
    Connection = ZConnection1
    Filter = 'DUEDATE >= '#39'2018-05-01'#39
    TableName = 'SUMMARY'
    Left = 48
    Top = 160
    object SUMMARYBILLERNAME: TWideStringField
      FieldName = 'BILLERNAME'
      Size = 60
    end
    object SUMMARYDUEDATE: TDateField
      FieldName = 'DUEDATE'
      DisplayFormat = 'mm/dd/yy'
      EditMask = '!99/99/00;1;_'
    end
    object SUMMARYDAYSLEFT: TLargeintField
      FieldName = 'DAYSLEFT'
      OnGetText = SUMMARYDAYSLEFTGetText
    end
    object SUMMARYPAYMENTDUE: TFloatField
      FieldName = 'PAYMENTDUE'
      currency = True
    end
    object SUMMARYBALANCE: TFloatField
      FieldName = 'BALANCE'
      OnGetText = SUMMARYBALANCEGetText
      currency = True
    end
    object SUMMARYPAYDATE: TDateField
      FieldName = 'PAYDATE'
      DisplayFormat = 'mm/dd/yy'
      EditMask = '!99/99/00;1;_'
    end
    object SUMMARYPAYAMOUNT: TFloatField
      FieldName = 'PAYAMOUNT'
      currency = True
    end
    object SUMMARYFROMACCOUNT: TWideStringField
      FieldName = 'FROMACCOUNT'
      Size = 60
    end
    object SUMMARYMOVSTATUS: TLargeintField
      FieldName = 'MOVSTATUS'
      OnGetText = SUMMARYMOVSTATUSGetText
    end
    object SUMMARYMOVCHECKED: TBooleanField
      FieldName = 'MOVCHECKED'
    end
    object SUMMARYBILLSNOTES: TWideStringField
      FieldName = 'BILLSNOTES'
      Size = 160
    end
    object SUMMARYBILLERTYPE: TLargeintField
      FieldName = 'BILLERTYPE'
      OnGetText = SUMMARYBILLERTYPEGetText
    end
    object SUMMARYBILLERID: TLargeintField
      FieldName = 'BILLERID'
    end
    object SUMMARYMOVID: TLargeintField
      FieldName = 'MOVID'
    end
    object SUMMARYBILLID: TLargeintField
      FieldName = 'BILLID'
    end
    object SUMMARYMOVACCOUNTID: TLargeintField
      FieldName = 'MOVACCOUNTID'
    end
  end
  object ACCOUNTBALANCES: TZTable
    Connection = ZConnection1
    TableName = 'ACCOUNTBALANCES'
    Left = 48
    Top = 344
    object ACCOUNTBALANCESACID: TLargeintField
      FieldName = 'ACID'
    end
    object ACCOUNTBALANCESNAME: TWideStringField
      FieldName = 'NAME'
      Size = 60
    end
    object ACCOUNTBALANCESLAST_OP_DATE: TDateField
      FieldName = 'LAST_OP_DATE'
    end
    object ACCOUNTBALANCESBALANCE: TFloatField
      FieldName = 'BALANCE'
      currency = True
    end
  end
  object ACCOUNTPAYMENTS: TZQuery
    Connection = ZConnection1
    SQL.Strings = (
      
        'SELECT FROMACCOUNT, MOVSTATUS, TOTAL(PAYAMOUNT) AS TOTALPAYMENT ' +
        ' FROM SUMMARY'
      'WHERE MOVSTATUS <> -1 AND DUEDATE>=:DDT'
      'GROUP BY FROMACCOUNT, MOVSTATUS'
      'ORDER BY MOVSTATUS, FROMACCOUNT')
    Params = <
      item
        DataType = ftString
        Name = 'DDT'
        ParamType = ptInput
        Value = '2018-05-01'
      end>
    Left = 48
    Top = 224
    ParamData = <
      item
        DataType = ftString
        Name = 'DDT'
        ParamType = ptInput
        Value = '2018-05-01'
      end>
    object ACCOUNTPAYMENTSFROMACCOUNT: TWideStringField
      FieldName = 'FROMACCOUNT'
      Size = 60
    end
    object ACCOUNTPAYMENTSMOVSTATUS: TLargeintField
      FieldName = 'MOVSTATUS'
      OnGetText = ACCOUNTPAYMENTSMOVSTATUSGetText
    end
    object ACCOUNTPAYMENTSTOTALPAYMENT: TFloatField
      FieldName = 'TOTALPAYMENT'
      ReadOnly = True
      currency = True
    end
  end
  object ACCOUNTTOTALS: TZQuery
    Connection = ZConnection1
    SQL.Strings = (
      'SELECT FROMACCOUNT, TOTAL(TOTALPAYMENT) AS TOTALPAYMENT FROM ('
      
        'SELECT FROMACCOUNT, MOVSTATUS, TOTAL(PAYAMOUNT) AS TOTALPAYMENT ' +
        ' FROM SUMMARY'
      'WHERE MOVSTATUS <> -1 AND DUEDATE>=:DDT'
      'GROUP BY FROMACCOUNT, MOVSTATUS'
      'ORDER BY MOVSTATUS, FROMACCOUNT'
      ')GROUP BY FROMACCOUNT')
    Params = <
      item
        DataType = ftWideString
        Name = 'DDT'
        ParamType = ptUnknown
        Value = '2018-05-01'
      end>
    Left = 48
    Top = 288
    ParamData = <
      item
        DataType = ftWideString
        Name = 'DDT'
        ParamType = ptUnknown
        Value = '2018-05-01'
      end>
    object ACCOUNTTOTALSFROMACCOUNT: TWideStringField
      FieldName = 'FROMACCOUNT'
      ReadOnly = True
      Size = 60
    end
    object ACCOUNTTOTALSTOTALPAYMENT: TFloatField
      FieldName = 'TOTALPAYMENT'
      ReadOnly = True
      currency = True
    end
  end
end
