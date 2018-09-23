unit DataModuleUnit;

interface

uses
  SysUtils, Classes, DB, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset,
  ZAbstractConnection, ZConnection, Dialogs,{quitar al final} Controls, DBClient, ZDbcIntfs, StrUtils, Variants,
  Generics.Collections, MidasLib;

type
  TRecomputeRBMode = (rrbm_Exclude, rrbm_Include);
//  TOType = (ot_Ascending, ot_Descending);
  TRefreshMethod = (rm_Bookmark, rm_Locate);
  TQryDs = TZQuery;
  TWQuery = class(TZQuery)
    constructor CreateAndOpen(aSql: string);
    procedure CloseAndFree;
  end;

  _TSortType = TSortType;

  TDM = class(TDataModule)
    ZConnection1: TZConnection;
    ACCOUNTS: TZTable;
    ACCOUNTSId: TLargeintField;
    ACCOUNTSName: TWideStringField;
    ACCOUNTSType: TLargeintField;
    ACCOUNTSSub_Type: TLargeintField;
    ACCOUNTSActive: TBooleanField;
    ACCOUNTSNotes: TWideStringField;
    ZQuery1: TZQuery;
    FULLCCS: TZQuery;
    BILLS: TZQuery;
    BILLSId: TLargeintField;
    BILLSBiller_Id: TLargeintField;
    BILLSPayment_Due: TFloatField;
    BILLSPayment: TFloatField;
    BILLSBalance: TFloatField;
    BILLSDays_In_Cycle: TIntegerField;
    BILLSActive: TBooleanField;
    BILLSNotes: TWideStringField;
    MOVEMENTS: TZQuery;
    ZQuery2: TZQuery;
    PastingDS: TClientDataSet;
    PastingDSDate: TDateField;
    PastingDSAmount: TCurrencyField;
    PastingDSPaste: TBooleanField;
    PastingDSType: TLargeintField;
    PastingDSNotes: TWideStringField; //TStringField;
    PastingDSLinked_Op: TLargeintField;
    PastingDSTarget_Id: TLargeintField;
    PastingDSTargetName: TStringField;
    PastingDSLinked_Bill: TLargeintField;
    PastingDSBill: TStringField;
    PastingDSDescription: TWideStringField;
    ACCOUNTSBegin_Date: TDateField;
    ACCOUNTSEnd_Date: TDateField;
    BILLSC_F_Date: TDateField;
    BILLSC_T_Date: TDateField;
    BILLSDue_Date: TDateField;
    BILLSLP_Date: TDateField;
    FULLCCSId: TLargeintField;
    FULLCCSBiller_Id: TLargeintField;
    FULLCCSC_F_Date: TDateField;
    FULLCCSC_T_Date: TDateField;
    FULLCCSPayment_Due: TFloatField;
    FULLCCSDue_Date: TDateField;
    FULLCCSPayment: TFloatField;
    FULLCCSLP_Date: TDateField;
    FULLCCSActive: TBooleanField;
    FULLCCSNotes: TWideStringField;
    FULLCCSSid: TLargeintField;
    FULLCCSBill_Id: TLargeintField;
    FULLCCSPrev_Payments: TFloatField;
    FULLCCSPrev_Expenses: TFloatField;
    FULLCCSCharged_Interests: TFloatField;
    FULLCCSCharged_Fees: TFloatField;
    FULLCCSPrev_Balance: TFloatField;
    FULLCCSInterest_Rate: TFloatField;
    FULLCCSLimit: TFloatField;
    FULLCCSAvailable_Credit: TCurrencyField;
    FULLCCSUtilization: TFloatField;
    FULLCCSDays_In_Cycle: TIntegerField;
    MOVEMENTSId: TLargeintField;
    MOVEMENTSAccount_Id: TLargeintField;
    MOVEMENTSOp_Date: TDateField;
    MOVEMENTSAmount: TFloatField;
    MOVEMENTSType: TLargeintField;
    MOVEMENTSStatus: TLargeintField;
    MOVEMENTSDescription: TWideStringField;
    MOVEMENTSTarget_Id: TLargeintField;
    MOVEMENTSRun_Balance: TFloatField;
    MOVEMENTSLinked_Op: TLargeintField;
    MOVEMENTSLinked_Bill: TLargeintField;
    MOVEMENTSNotes: TWideStringField;
    MOVEMENTSChecked: TBooleanField;
    MOVEMENTSTargetName: TStringField;
    OPENBILLS: TZQuery;
    MOVEMENTSBill: TStringField;
    OPENBILLSId: TLargeintField;
    OPENBILLSPayment_Due: TFloatField;
    OPENBILLSPayment: TFloatField;
    OPENBILLSDue_Date: TDateField;
    OPENBILLSName: TWideStringField;
    OPENBILLSActive: TBooleanField;
    OPENBILLSBill: TStringField;
    TRANSFERACCOUNTS: TZQuery;
    TRANSFERACCOUNTSId: TLargeintField;
    TRANSFERACCOUNTSName: TWideStringField;
    TRANSFERACCOUNTSType: TLargeintField;
    PastingDSSuccess: TBooleanField;
    OPENBILLSPendingAmount: TCurrencyField;
    SUMMARY: TZTable;
    SUMMARYBILLERNAME: TWideStringField;
    SUMMARYDUEDATE: TDateField;
    SUMMARYDAYSLEFT: TLargeintField;
    SUMMARYPAYMENTDUE: TFloatField;
    SUMMARYBALANCE: TFloatField;
    SUMMARYPAYDATE: TDateField;
    SUMMARYPAYAMOUNT: TFloatField;
    SUMMARYFROMACCOUNT: TWideStringField;
    SUMMARYMOVCHECKED: TBooleanField;
    SUMMARYBILLSNOTES: TWideStringField;
    SUMMARYBILLERTYPE: TLargeintField;
    SUMMARYBILLERID: TLargeintField;
    SUMMARYMOVID: TLargeintField;
    SUMMARYBILLID: TLargeintField;
    SUMMARYMOVSTATUS: TLargeintField;
    SUMMARYMOVACCOUNTID: TLargeintField;
    ACCOUNTBALANCES: TZTable;
    ACCOUNTBALANCESACID: TLargeintField;
    ACCOUNTBALANCESNAME: TWideStringField;
    ACCOUNTBALANCESLAST_OP_DATE: TDateField;
    ACCOUNTBALANCESBALANCE: TFloatField;
    ACCOUNTPAYMENTS: TZQuery;
    ACCOUNTPAYMENTSFROMACCOUNT: TWideStringField;
    ACCOUNTPAYMENTSMOVSTATUS: TLargeintField;
    ACCOUNTPAYMENTSTOTALPAYMENT: TFloatField;
    ACCOUNTTOTALS: TZQuery;
    ACCOUNTTOTALSFROMACCOUNT: TWideStringField;
    ACCOUNTTOTALSTOTALPAYMENT: TFloatField;
    procedure BILLSCalcFields(DataSet: TDataSet);
    procedure FULLCCSCalcFields(DataSet: TDataSet);
    procedure ACCOUNTSTypeGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure ACCOUNTSTypeSetText(Sender: TField; const Text: string);
    procedure ACCOUNTSSub_TypeGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure ACCOUNTSSub_TypeSetText(Sender: TField; const Text: string);
    procedure YESNOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure YESNOSetText(Sender: TField; const Text: string);
    procedure ACCOUNTSTypeChange(Sender: TField);
    procedure FULLCCSAfterInsert(DataSet: TDataSet);
    procedure FULLCCSPaymtAndChargesChange(Sender: TField);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure BILLSActiveGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure BILLSActiveSetText(Sender: TField; const Text: string);
    procedure BILLSAfterInsert(DataSet: TDataSet);
    procedure BILLSBeforePost(DataSet: TDataSet);
    procedure TypeGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure TypeSetText(Sender: TField; const Text: string);
    procedure MOVEMENTSStatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure MOVEMENTSStatusSetText(Sender: TField; const Text: string);
    procedure MOVEMENTSAfterInsert(DataSet: TDataSet);
    procedure MOVEMENTSBeforePost(DataSet: TDataSet);
    procedure ACCOUNTSBeforePost(DataSet: TDataSet);
    procedure FULLCCSBeforePost(DataSet: TDataSet);
    procedure ValidateDate(Sender: TField; const Text: string);
    procedure FULLCCSValidateCycleDate(Sender: TField);
    procedure BILLSValidateCycleDate(Sender: TField);
    procedure MOVEMENTSCheckedGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure MOVEMENTSCheckedSetText(Sender: TField; const Text: string);
    procedure ACCOUNTSAfterScroll(DataSet: TDataSet);
    procedure MOVEMENTSBeforeDelete(DataSet: TDataSet);
    procedure OPENBILLSBillGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure MOVEMENTSBeforeInsert(DataSet: TDataSet);
    procedure MOVEMENTSTypeChange(Sender: TField);
    procedure MOVEMENTSAfterCancel(DataSet: TDataSet);
    procedure MOVEMENTSAfterScroll(DataSet: TDataSet);
    procedure MOVEMENTSStatusChange(Sender: TField);
    procedure OPENBILLSCalcFields(DataSet: TDataSet);
    procedure BILLSAfterPost(DataSet: TDataSet);
    procedure ACCOUNTSAfterInsert(DataSet: TDataSet);
    procedure ACCOUNTSAfterPost(DataSet: TDataSet);
    procedure FULLCCSBeforeDelete(DataSet: TDataSet);
    procedure BILLSBeforeInsert(DataSet: TDataSet);
    procedure BILLSBeforeDelete(DataSet: TDataSet);
    procedure MOVEMENTSLinked_BillChange(Sender: TField);
    procedure PastingDSTypeChange(Sender: TField);
//    procedure PastingDSLinked_BillChange(Sender: TField);
    procedure PastingDSAfterScroll(DataSet: TDataSet);
    procedure OPENBILLSAfterRefresh(DataSet: TDataSet);
    procedure SUMMARYDAYSLEFTGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure SUMMARYBALANCEGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure SUMMARYBILLERTYPEGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure ACCOUNTPAYMENTSMOVSTATUSGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure SUMMARYMOVSTATUSGetText(Sender: TField; var Text: string; DisplayText: Boolean);
//    procedure PastingDSLinked_BillSetText(Sender: TField; const Text: string);
//    procedure PastingDSLinked_BillGetText(Sender: TField; var Text: string; DisplayText: Boolean);
//    procedure PastingDSAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    FOnOPENBILLSRefresh: TList<TNotifyEvent>;
    MustUpdateBILLS: Boolean;
    FSUMMARYShowFromDate: TDate;
    function  AddOneMonth(aDate: TDate): TDate;
    function  InserBillFromFULLCCS: Integer;
    procedure CheckRequiredFields(DataSet: TDataSet);
    procedure EditBillFromFULLCCS;
    procedure EditCCStatementFromFULLCCS;
    procedure InsertCCStatementFromFULLCCS(aBillId: Integer);
    procedure RefreshDataSet(aDataSet: TZAbstractDataSet; RefreshMethod: TRefreshMethod; RecordId: Integer = -1);
    function GetLocateIdAfterDelete(aDataSet: TZAbstractDataSet): Integer;

    function ACCOUNTSIsActive(anAccountId: Integer): Boolean;
    function ACCOUNTSGetType(AccountId: Integer): Integer;

    function FULLCCSGetQueryForPrev_Balance(aBillerId: Integer): string;
    procedure FULLCCSProcessEdits;
    function FULLCCSProcessInserts: Integer;
    function FULLCCSRequireFieldsAreNull: Boolean;

    function  BILLSAfterInsertSetDefaultValues: Integer;
    procedure BILLSAfterInsertSetCalculatedValues(aBillerId: Integer);
    procedure BILLSCheckActiveConstraint(anAccountId: Integer);
    procedure BILLSCheckCanInsert;
    function  BILLSHasBeenPaid(const BillId: Integer; out aMsg: string): Boolean;

    function  MOVEMENTSAfterInsertSetDefaultValues: Integer;
    function  MOVEMENTSAmountChanged: Boolean;
    function  MOVEMENTSPostedDateAmountStatusChanged: Boolean;
    function  MOVEMENTSDateChanged: Boolean;
    function  MOVEMENTSGetPreviousBalance(MovementId: Integer; FromDate: TDate; Qry: TWQuery): Currency;
    procedure MOVEMENTSCheckActiveConstraint(anAccountId: Integer);
    procedure MOVEMENTSCheckPaymentRequirements;
    procedure MOVEMENTSCheckUpdateBILLS;
    procedure MOVEMENTSComputeRB(AccountId: Integer; FromThisRecord: Integer;
      RecomputeMode: TRecomputeRBMode = rrbm_Include; OldDate: TDate = 0);
    procedure MOVEMENTSGetLastAndPenultimatePaymentDates(aBillId: Integer; aDate: TDate;
      out LastDate: TDate; out PenultimateDate: TDate);
    procedure MOVEMENTSLockFields(Lock: Boolean);
    procedure MOVEMENTSPayBill;
    procedure MOVEMENTSPost;
    procedure MOVEMENTSProcessBill;
    procedure MOVEMENTSProcessChanges;
    procedure MOVEMENTSProcessInTransfer;
    procedure MOVEMENTSProcessOutTransfer;
    procedure MOVEMENTSProcessTransferEdit;
    procedure MOVEMENTSProcessTransferInsert;
    procedure MOVEMENTSSetFieldReadOnlyness;
    procedure MOVEMENTSUndoPayBill;
    procedure MOVEMENTSUpdateBill(aBillId: Integer; PaymentAmount: Currency; aDate: TDate;
      EnforceValues: Boolean);
    procedure SetSummaryStartFromDate(aDate: TDate);
  public
    { Public declarations }
//    PastingDSBillStrings: TStrings;
    property SUMMARYShowFromDate: TDate read FSUMMARYShowFromDate write SetSummaryStartFromDate;
    function GetRunningBalance: Real;
    procedure MOVEMENTSAddFromPastingDS;
    procedure OPENBILLSRegisterRefreshListener(aListener: TNotifyEvent);
    procedure OPENBILLSUnRegisterRefreshListener(aListener: TNotifyEvent);
    function PastingDSIsAscending(oFieldName: string): Boolean;
    procedure PastingDSOrderBy(oFieldName: string; Asc: Boolean);
  end;

  function Sign(aValue: Real): ShortInt;

var
  DM: TDM;
//  ApplicationPath: string;

const
  CREDITCARD = 3;
  DATABASENAME = 'fncdb.db';
  EXPENSES = -3;
  SALARY = 3;
  POSTED = 0;
  PLANNED = 1;
  CANCELLED = 2;
  VISA = 1;
  BILLPAYMENT = -4;
  OUTTRANSFER = -2;
  INTRANSFER = 2;
//  PLANNEDTAG = 'PLANNED';
//  POSTEDTAG = 'POSTED';

  Debugging = True;  { TODO: remove later}
  {This will control the readonlyness of pesistent fields BILLSActive, BILLSPayment and BILLSLP_Date}

implementation

{$R *.dfm}
{$REGION 'General functions'}
{executes a non resultset query}
procedure ExecuteQuery(aStatement: string);
var Query: TZQuery;
begin
  Query := TZQuery.Create(nil);
  try
    Query.Connection := DM.ZConnection1;
    Query.SQL.Add(aStatement);
    Query.ExecSQL;
  except
    Query.Free;
    raise;
  end;
  Query.Free;
end;

{returns the aDate as a string of the form "2017-03-30"}
function GetSQLiteDateStr(aDate: TDate):string;
var
  y, m, d: Word;
begin
    DecodeDate(aDate, y, m, d);
    Result := Format('%4.4d-%2.2d-%2.2d',[y,m,d]);
end;

function Sign(aValue: Real): ShortInt;
begin
  if aValue < 0 then
    Result := -1
  else if aValue = 0 then
    Result := 0
  else
    Result := 1;
end;
{$ENDREGION}

{$REGION 'TDM'}
procedure TDM.ACCOUNTSAfterInsert(DataSet: TDataSet);
begin
  ACCOUNTSActive.Value := True;
end;

procedure TDM.ACCOUNTSAfterPost(DataSet: TDataSet);
begin
  RefreshDataSet(TRANSFERACCOUNTS, rm_Bookmark);
end;

{makes selected fields readonly or writable according to if the account is active}
procedure TDM.ACCOUNTSAfterScroll(DataSet: TDataSet);
var b: Boolean;
begin  //an inactive account is read only except its field Notes
  b := ((not ACCOUNTSActive.IsNull) and (not ACCOUNTSActive.Value)) and (not Debugging);
  ACCOUNTSId.ReadOnly := b;
  ACCOUNTSName.ReadOnly := b;
  ACCOUNTSType.ReadOnly := b;
  ACCOUNTSSub_Type.ReadOnly := b;
  ACCOUNTSBegin_Date.ReadOnly := b;
  ACCOUNTSEnd_Date.ReadOnly := b;
  ACCOUNTSActive.ReadOnly := b;
end;

procedure TDM.ACCOUNTSBeforePost(DataSet: TDataSet);
begin
  CheckRequiredFields(DataSet);
end;

{returns the type of the account record identified by AccountId}
function TDM.ACCOUNTSGetType(AccountId: Integer): Integer;
var
  Qry: TWQuery;
begin
  Qry := TWQuery.CreateAndOpen('SELECT Type FROM ACCOUNTS WHERE Id = ' + IntToStr(AccountId));
  Result := Qry.FieldByName('Type').AsInteger;
  Qry.CloseAndFree;
end;

{Returns true if the account record identified by anAccountId is active}
function TDM.ACCOUNTSIsActive(anAccountId: Integer): Boolean;
var
  Qry: TWQuery;
begin
  Qry := TWQuery.CreateAndOpen('SELECT Active FROM ACCOUNTS WHERE Id=' + IntToStr(anAccountId));
  Result := Qry.FieldByName('Active').AsBoolean;
  Qry.CloseAndFree;
end;

procedure TDM.ACCOUNTSSub_TypeGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  case Sender.AsInteger of
    1: Text := 'Visa';
    2: Text := 'Master';
    3: Text := 'Discover';
    4: Text := 'Amex';
    5: Text := 'Other';
  end;
end;

procedure TDM.ACCOUNTSSub_TypeSetText(Sender: TField; const Text: string);
begin
  if Text = 'Visa' then Sender.AsInteger := 1
  else if Text = 'Master' then Sender.AsInteger := 2
  else if Text = 'Discover' then Sender.AsInteger := 3
  else if Text = 'Amex' then Sender.AsInteger := 4
  else Sender.AsInteger := 5;
end;

{Field Sub_Type gets cleared or set and read only or writable according to the value of field Type}
procedure TDM.ACCOUNTSTypeChange(Sender: TField);
begin
  if ACCOUNTSType.Value <> CREDITCARD then
  begin
    ACCOUNTSSub_Type.ReadOnly := False;
    ACCOUNTSSub_Type.Clear;
    ACCOUNTSSub_Type.ReadOnly := True;
  end
  else
  begin
    ACCOUNTSSub_Type.ReadOnly := False;
    if ACCOUNTSSub_Type.IsNull then
      ACCOUNTSSub_Type.Value := VISA;
  end;
end;

procedure TDM.ACCOUNTSTypeGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  case Sender.AsInteger of
    1: Text := 'Checking';
    2: Text := 'Savings';
    3: Text := 'Credit Card';
    4: Text := 'Biller';
    5: Text := 'Other';
  end;
end;

procedure TDM.ACCOUNTSTypeSetText(Sender: TField; const Text: string);
begin
  if Text = 'Checking' then Sender.AsInteger := 1
  else if Text = 'Savings' then Sender.AsInteger := 2
  else if Text = 'Credit Card' then Sender.AsInteger := 3
  else if Text = 'Biller' then Sender.AsInteger := 4
  else Sender.AsInteger := 5;
end;

procedure TDM.BILLSActiveGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsBoolean then
    Text := 'Open'
  else
    Text := 'Closed';
end;

procedure TDM.BILLSActiveSetText(Sender: TField; const Text: string);
begin
  Sender.AsBoolean := (Text = 'Open');
end;

procedure TDM.BILLSAfterInsert(DataSet: TDataSet);
var
  BillerId: integer;
begin
  BillerId := BILLSAfterInsertSetDefaultValues;
  BILLSAfterInsertSetCalculatedValues(BillerId);
end;

{Just after a bill is inserted, the field "cycle to date"(C_T_Date) and due date (Due_Date) are suggested}
procedure TDM.BILLSAfterInsertSetCalculatedValues(aBillerId: Integer);
var
  Qry: TWQuery;
begin
  Qry := TWQuery.CreateAndOpen('SELECT MAX(C_F_DATE) as C_F_DATE, C_T_Date, Due_Date ' +
                               'FROM BILLS WHERE Biller_Id=' + IntToStr(aBillerId));
  if (Qry.RecordCount <> 0) and not(Qry.FieldByName('C_T_Date').IsNull) then
  begin
    BILLSC_F_Date.Value := Qry.FieldByName('C_T_Date').AsDateTime + 1;
    BILLSDue_Date.Value := AddOneMonth(Qry.FieldByName('Due_Date').AsDateTime);
  end;
  Qry.CloseAndFree;
end;

{Given the date aDate of a posted payment movement, and its linked bill id aBillId, returns in LastDate and
PenultimateDate, the last date and the date before aDate, that a posted payment movement was made against that bill.
Raises an exception if the bill doesnt exist/is not found.
Example:
aDate = 12-10-17 aBillId = 47
There are 5 movements against that bill 47. These are the dates of those movements, ordered from newer to older:

12-15-17 -> LastDate (always the newest date)
12-10-17 -> aDate (the given date)
10-02-17 -> PenultimateDate (the date before the given date)
10-01-17 ..older date
09-15-17 ..older date

If there are no movement before aDate, PenultimateDate value is zero.}
procedure TDM.MOVEMENTSGetLastAndPenultimatePaymentDates(aBillId: Integer; aDate: TDate;
  out LastDate: TDate; out PenultimateDate: TDate);
var
  Qry: TWQuery;
begin
  Qry := TWQuery.CreateAndOpen('SELECT Op_Date FROM MOVEMENTS WHERE Linked_Bill=' +
    IntToStr(aBillId) + #10#13'AND Status= 0 ORDER BY Op_Date DESC, Id DESC');
  if Qry.RecordCount = 0 then
    raise Exception.Create('No such a movement.')
  else
  begin
    LastDate := Qry.FieldByName('Op_Date').AsDateTime;
    while not Qry.Eof do
    begin
      if Qry.FieldByName('Op_Date').AsDateTime = aDate then
        Break;
      Qry.Next;
    end;
    Qry.Next;
    PenultimateDate := Qry.FieldByName('Op_Date').AsDateTime;
    if PenultimateDate = aDate then
      PenultimateDate := 0;
  end;
  Qry.CloseAndFree;
end;

{Checks if a planned or posted movement that is a payment, has its bill linked to it. Raises an exception if not}
procedure TDM.MOVEMENTSCheckPaymentRequirements;
begin
  if ((MOVEMENTSStatus.Value = PLANNED) or (MOVEMENTSStatus.Value = POSTED)) and
    (MOVEMENTSLinked_Bill.IsNull) then
    raise Exception.Create('Payment does not reference any bill.');
end;

{Returns the running balance of the previous posted movement of MovementId, using an open Qry that contains
an ordered result set of movements (ordered by date, from older to newer, and by Id, ascending).
Also, makes the previous record's balance the active record within Qry.}
function TDM.MOVEMENTSGetPreviousBalance(MovementId: Integer; FromDate: TDate; Qry: TWQuery): Currency;
var
  PreviousId: Integer;
  FDate: TDateField;
  aDate: TDate;
  DateFound: Boolean;
begin
  Result := 0;
  if FromDate = 0 then
  begin
    if not Qry.Locate('Id', MovementId, []) then
      raise Exception.Create('Cannot locate movement record (Id: ' + IntToStr(MovementId) + ')');
  end
  else
  begin
    //I will go record by record looking for the first one with the specified date
    FDate := TDateField(Qry.FieldByName('Op_Date'));
    DateFound := False;
    while not Qry.Eof do
    begin
      if FromDate = FDate.Value then
      begin
        DateFound := True;
        Break;
      end;
      Qry.Next;
    end;
    if not DateFound then
      raise Exception.Create('Cannot locate a movement record with such a date: ' + DateToStr(FromDate));
  end;
  PreviousId := MovementId;
  //look for the previous posted movement's running balance
  while not Qry.Bof do
  begin
    Qry.Prior;
    if Qry.FieldByName('Status').AsInteger = POSTED then
    begin
      PreviousId := Qry.FieldByName('Id').AsInteger;
      Break;
    end;
  end;
  if MovementId <> PreviousId then
  begin
    Result := Qry.FieldByName('Run_Balance').AsCurrency;
    if FromDate = 0 then
      Qry.Locate('Id', MovementId, [])
    else
      Qry.Next;
  end;
end;

{Makes the selected fields readonly/rewritable according to the Lock parameter value.}
procedure TDM.MOVEMENTSLinked_BillChange(Sender: TField);
begin
  if MOVEMENTSLinked_Bill.IsNull then
    Exit;

  if OPENBILLS.Locate('Id', MOVEMENTSLinked_Bill.Value, []) then
  begin
    if MOVEMENTSAmount.IsNull then
      MOVEMENTSAmount.Value := OPENBILLSPayment_Due.Value;
    if MOVEMENTSDescription.IsNull then
      MOVEMENTSDescription.Value := OPENBILLSName.Value;
  end;
end;

procedure TDM.MOVEMENTSLockFields(Lock: Boolean);
begin
  MOVEMENTSId.ReadOnly := Lock;
  MOVEMENTSAccount_Id.ReadOnly := Lock;
  MOVEMENTSType.ReadOnly := Lock;
  MOVEMENTSTarget_Id.ReadOnly := Lock;
//  MOVEMENTSRun_Balance.ReadOnly := Lock;
  MOVEMENTSLinked_Op.ReadOnly := Lock;
  MOVEMENTSLinked_Bill.ReadOnly := Lock;
  MOVEMENTSStatus.ReadOnly := False;
  MOVEMENTSOp_Date.ReadOnly := Lock;

  OPENBILLS.Filtered := FALSE;
  TRANSFERACCOUNTS.Filtered := False;
end;

{Given a bill identified by aBillId, it updates the amount paid to bill and the date of last payment as follow:
-Field Payment is incremented by the value of PaymentAmount parameter. PaymentAmount can be negative so Payment field
 can become equal to zero; in that case, Payment and LP_Date fields are nulled as if that bill had never received a
 payment; otherwise LP_Date is updated with value of aDate parameter if the any of following conditions are met:
   -aDate is a more recent date that what field LP_Date has.
   -EnforceValues is true.
-If the balance of the account is less or equal to zero, the bill is closed.
-If the given bill doesnt exist or the bill is not active, and the updating is not being enforced (EnforceValues not
 true), an exception is raised.}
procedure TDM.MOVEMENTSUpdateBill(aBillId: Integer; PaymentAmount: Currency; aDate: TDate;
  EnforceValues: Boolean);
var
  Qry: TWQuery;
begin
  Qry := TWQuery.CreateAndOpen('SELECT * FROM BILLS WHERE Id=' + IntToStr(aBillId));
  if Qry.RecordCount = 0 then
  begin
    Qry.CloseAndFree;
    raise Exception.Create('No such a bill.');
  end;
  if (not Qry.FieldByName('Active').AsBoolean) and (not EnforceValues) then
  begin
{TODO:
SEVERAL CHANGES/IMPROVEMENTS
-This exception is being raised when an existing posted movement is edited/changed its date.
this happen no matter if checked or not.
In particular, the movement whos date I'm trying to update is a payment on a credit card bill.
that specific bill had been already paid and closed. To do the second payment, it was necessary
to manually reopen the bill:
05-10-18 Discovery Card 1449.53 (Due date: 05-15-18)
05-20-18 Discovery Card   98.75 (Due date: 05-15-18)
I was able to update the description, notes and checked fields. But the date, nor the amount
couldnt be changed.
The way I overcame that was:
1. I changed the status from posted to Planned.
2. I updated the date (I could have updated the amount if I would have liked)
3. I manually reopened the bill.
4. I changed the status from Planned to Posted.
And it worked.

-When trying to make a payment against a closed bill, a dialog box should ask for confirmation.

-Change the checked to show a checked simbol instead of a Yes/No.
*- Post the change inmediatelly if all the requirments are met.

*-Just after posting a change on an existing record, that record becomes the first in the dbgrid.
It's annoying. It should be kept in the same position, no scroll. SOLVED WITH A HACK FOR CHECKED FIELD IN MOVEMENTS

*-When filtering the summary records, the filter should not hide the due bill. All the unpaid bills
should remain shown
-Something is wrong when the running balance is updated. Somehow, it gets out of synchrony so I have to mimic a recent
 transaction to update the running balance. Check the algorithm and the different scenarios.

}
    Qry.CloseAndFree;
    raise Exception.Create('Referenced bill is closed.');
  end;
  try
    Qry.Edit;
    Qry.FieldByName('Payment').AsCurrency := Qry.FieldByName('Payment').AsCurrency + PaymentAmount;
    if Qry.FieldByName('Payment').AsCurrency = 0 then
    begin
      Qry.FieldByName('Payment').Clear;
      Qry.FieldByName('LP_Date').Clear;
    end
    else if EnforceValues or (Qry.FieldByName('LP_Date').AsDateTime < aDate) then
      Qry.FieldByName('LP_Date').AsDateTime := aDate;
    Qry.FieldByName('Active').AsBoolean := Qry.FieldByName('Payment').AsCurrency < Qry.FieldByName
      ('Payment_Due').AsCurrency;
    Qry.Post;
  except
    Qry.CloseAndFree;
    raise;
  end;
  Qry.CloseAndFree;
  MustUpdateBILLS := True;
end;

{Link the new inserted bill to its referenced biller}
function TDM.BILLSAfterInsertSetDefaultValues: Integer;
begin
  Result := BILLS.ParamByName('RefId').AsInteger;
  BILLSCheckActiveConstraint(Result);
  BILLSBiller_Id.Value := Result;
end;

procedure TDM.BILLSAfterPost(DataSet: TDataSet);
begin
  OPENBILLS.Refresh;
//  RefreshDataSet(OPENBILLS, rm_Bookmark);
  {DONE:
  Bug here, bookmark not found. Occurs when inserting a bill having the pasting form open with a movement record
  payment type on edit state.
  }
end;

procedure TDM.BILLSBeforeDelete(DataSet: TDataSet);
{Deletes the actual bill and if aplies, its corresponding credit card statement record}
var
  msg: string;
  FCCSId: Integer;
begin
  if BILLSHasBeenPaid(BILLSId.Value, msg) then
    raise Exception.Create('Bill has planned/received payments and cannot be deleted.'#13#10 + msg);

  if ACCOUNTSGetType(BILLS.ParamByName('RefId').AsInteger) = CREDITCARD then
  begin
    FCCSId := -1; //this will indicate both corresponding BILLS and FULLCCS are the selected/actual records.
    if BILLSId.Value <> FULLCCSId.Value then
    begin
      FCCSId := FULLCCSId.Value; //saves the Id of the actual FULLCCS record.
      if not FULLCCS.Locate('Id', BILLSId.Value, []) then
        raise Exception.Create('Bill doesn'#39't have a corresponding credit card statement.');
    end;
    //At this point, both the corresponding BILLS and FULLCCS are selected.
    //We order to delete the FULLCCS actual record (routine already implemented)
    try
      FULLCCSBeforeDelete(FULLCCS);
    finally
      if FCCSId <> -1 then
        FULLCCS.Locate('Id', FCCSId, []);
      Abort;
    end;
  end; //else, allow deleting the bill using Dataset's deletion way
end;

procedure TDM.BILLSBeforeInsert(DataSet: TDataSet);
begin
  BILLSCheckCanInsert;
end;

procedure TDM.BILLSBeforePost(DataSet: TDataSet);
begin
  CheckRequiredFields(DataSet);
end;

procedure TDM.BILLSCalcFields(DataSet: TDataSet);
begin
  BILLSBalance.Value := BILLSPayment_Due.Value - BILLSPayment.Value;
  if (not BILLSC_T_Date.IsNull) and (not BILLSC_F_Date.IsNull) then
    BILLSDays_In_Cycle.Value := Trunc(BILLSC_T_Date.Value - BILLSC_F_Date.Value) + 1;
end;

{Makes sure that no new bill can reference an inactive account by raising an exception}
procedure TDM.BILLSCheckActiveConstraint(anAccountId: Integer);
begin
  if not ACCOUNTSIsActive(anAccountId) then
  begin
    BILLS.Cancel;
    raise Exception.Create('Bill cannot reference an inactive account.');
  end;
end;

{Makes sure that no new bill for a credit card can be inserted by raising an exception. The credit card bills are
created from its statement}
procedure TDM.BILLSCheckCanInsert;
begin
  if ACCOUNTSGetType(BILLS.ParamByName('RefId').AsInteger) = CREDITCARD then
    raise Exception.Create('Credit cards bills are only created from credit card statements.');
end;

function TDM.BILLSHasBeenPaid(const BillId: Integer; out aMsg: string): Boolean;
var
  Qry: TWQuery;
begin
  Result := False;
  Qry := TWQuery.CreateAndOpen('SELECT Description, Op_Date FROM MOVEMENTS WHERE Linked_Bill=' + IntToStr(BillId));
  try
    if Qry.RecordCount <> 0 then
    begin
      Result := True;
      aMsg := 'Description: ' + Qry.FieldByName('Description').AsString + #13#10 +
              'Date: ' + Qry.FieldByName('Op_Date').AsString;
    end;
  finally
    Qry.CloseAndFree;
  end;
end;

{Makes sure that on table BILLS, C_F_Date is older or equal that C_T_Date by raising an exception}
procedure TDM.BILLSValidateCycleDate(Sender: TField);
begin
  if BILLSC_T_Date.IsNull or BILLSC_F_Date.IsNull then
    Exit;
  if BILLSC_T_Date.Value < BILLSC_F_Date.Value then
    raise Exception.Create('Cycle closing date must be greater'#10#13+
                           'than cycle opening date!');
end;

{$HINTS OFF}
{Makes sure that all the persistent fields marked as required are not null, by raising an exception}
procedure TDM.CheckRequiredFields(DataSet: TDataSet);
var
  i: Integer;
begin
  for i := 0 to DataSet.FieldCount - 1 do
    if DataSet.Fields[i].Required and DataSet.Fields[i].IsNull then
      raise Exception.Create('Data in the current record is not complete.'#10#13 +
                             'Field: ' + DataSet.Fields[i].FieldName);
end;
{$HINTS ON}

procedure TDM.DataModuleCreate(Sender: TObject);
//var q:TWQuery;
begin
//D:\Documents\RAD Studio\Projects\MyFinances\fncdb.db
  //Prepare the "Show from date" to be 30 days ago.
  SUMMARYShowFromDate := Date - 30;
  DateSeparator := '-';
{ TODO :
It looks like date separator doesnt take effect until the second run.
I saw in a first run that the dates were shown as 03/03/18, not as 03-03-18

This persists. I realized the date format was wrong after processing data pasted from excel.
UPDATE: The format gets modified after the system recovers from hybernation.
}
  ShortDateFormat := 'mm/dd/yy';
  CurrencyFormat := 2;
  NegCurrFormat := 14;
  //
  FOnOPENBILLSRefresh := TList<TNotifyEvent>.Create;
  //
  MOVEMENTSLockFields(True);
  BILLSActive.ReadOnly := not Debugging;// True;
  BILLSPayment.ReadOnly := not Debugging;// True;
  BILLSLP_Date.ReadOnly := not Debugging;// True;
  //
  ZConnection1.Database := ExtractFilePath(ParamStr(0)) + DATABASENAME;
  ZConnection1.AutoCommit := True;
  ZConnection1.TransactIsolationLevel := TZTransactIsolationLevel.tiNone;
  ZConnection1.Connect;
  ExecuteQuery('PRAGMA foreign_keys=1');
  ZConnection1.TransactIsolationLevel := TZTransactIsolationLevel.tiReadCommitted;

  {DONE: remove later from here}
//  q:=TWQuery.CreateAndOpen('pragma foreign_keys');
//  ShowMessage('PRAMA foreign_keys = ' + q.FieldByName('foreign_keys').AsString);
//  q.CloseAndFree;
  //to here

  OPENBILLS.Open;
  ACCOUNTS.Open;
  BILLS.Open;
  TRANSFERACCOUNTS.Open;
  MOVEMENTS.Open;
  FULLCCS.Open;
  PastingDS.CreateDataSet;
  PastingDS.Open;
  SUMMARY.Open;
  ACCOUNTPAYMENTS.Open;
  ACCOUNTBALANCES.Open;
  ACCOUNTTOTALS.Open;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  ACCOUNTTOTALS.CLose;
  ACCOUNTPAYMENTS.CLose;
  ACCOUNTBALANCES.CLose;
  SUMMARY.Close;
  PastingDS.Close;
  ACCOUNTS.Close;
  BILLS.Close;
  MOVEMENTS.Close;
  TRANSFERACCOUNTS.Close;
  FULLCCS.Close;
  OPENBILLS.Close;
  ZConnection1.Disconnect;
  //
  FOnOPENBILLSRefresh.Free;
end;

{Updates the selected fields of table BILLS from data contained in the joint resultset FULLCCS}
procedure TDM.EditBillFromFULLCCS;
var
  Qry: TWQuery;
  BillId: Integer;
begin
  BillId := FULLCCS.FieldByName('Id').AsInteger;
  Qry := TWQuery.CreateAndOpen('SELECT * FROM BILLS WHERE Id=' + IntToStr(BillId));
  Qry.Edit;
  Qry.FieldByName('C_F_Date').AsDateTime := FULLCCSC_F_Date.Value;
  Qry.FieldByName('C_T_Date').AsDateTime := FULLCCSC_T_Date.Value;
  Qry.FieldByName('Payment_Due').AsCurrency := FULLCCSPayment_Due.Value;
  Qry.FieldByName('Due_Date').AsDateTime := FULLCCSDue_Date.Value;
  Qry.FieldByName('Payment').AsCurrency := FULLCCSPayment.Value;
  Qry.FieldByName('LP_Date').AsDateTime := FULLCCSLP_Date.Value;
  Qry.FieldByName('Active').AsBoolean := FULLCCSActive.Value;
  Qry.FieldByName('Notes').AsString := FULLCCSNotes.Value;
  Qry.Post;
  Qry.CloseAndFree;
end;

{Updates the selected fields of table CCSTATEMENTS from data contained in the joint resultset FULLCCS}
procedure TDM.EditCCStatementFromFULLCCS;
var
  Qry: TWQuery;
  Sid: Integer;
begin
  Sid := FULLCCS.FieldByName('Sid').AsInteger;
  Qry := TWQuery.CreateAndOpen('SELECT * FROM CCSTATEMENTS WHERE Sid=' + IntToStr(Sid));
  Qry.Edit;
  Qry.FieldByName('Prev_Payments').AsCurrency := FULLCCSPrev_Payments.Value;
  Qry.FieldByName('Prev_Expenses').AsCurrency := FULLCCSPrev_Expenses.Value;
  Qry.FieldByName('Charged_Interests').AsCurrency := FULLCCSCharged_Interests.Value;
  Qry.FieldByName('Charged_Fees').AsCurrency := FULLCCSCharged_Fees.Value;
  Qry.FieldByName('Prev_Balance').AsCurrency := FULLCCSPrev_Balance.Value;
  Qry.FieldByName('Interest_Rate').AsFloat := FULLCCSInterest_Rate.Value;
  Qry.FieldByName('Limit').AsCurrency := FULLCCSLimit.Value;
  Qry.Post;
  Qry.CloseAndFree;
end;

{Set selected fields of joint result set with suggested values}
procedure TDM.FULLCCSAfterInsert(DataSet: TDataSet);
var
  BillerId: integer;
  Qry: TWQuery;
begin
  BillerId := FULLCCS.ParamByName('RefId').AsInteger;
  FULLCCSBiller_Id.Value := BillerId;
  FULLCCSActive.Value := True;
  Qry := TWQuery.CreateAndOpen('SELECT C_F_DATE, C_T_Date, Due_Date, Interest_Rate, [Limit]'#10#13 +
           'FROM BILLS INNER JOIN CCSTATEMENTS ON BILLS.Id=CCSTATEMENTS.Bill_Id'#10#13 +
           'WHERE Biller_Id=' + IntToStr(BillerId) + ' ORDER BY C_F_Date DESC LIMIT 1');
  if (Qry.RecordCount <> 0) and (not Qry.FieldByName('C_T_Date').IsNull) then
  begin
    FULLCCSC_F_Date.Value := Qry.FieldByName('C_T_Date').AsDateTime + 1;
    FULLCCSDue_Date.Value := AddOneMonth(Qry.FieldByName('Due_Date').AsDateTime);
    FULLCCSInterest_Rate.Value := Qry.FieldByName('Interest_Rate').AsFloat;
    FULLCCSLimit.Value := Qry.FieldByName('Limit').AsCurrency;
  end;
  Qry.CloseAndFree;
end;

procedure TDM.FULLCCSBeforeDelete(DataSet: TDataSet);
{Deletes the corresponding bill and credit card statement record related to the joint resultset FULLCCS}
var
  msg: string;
  BillRelocateTo, FullccsRelocateTo: Integer;
begin
  if BILLSHasBeenPaid(FULLCCSId.Value, msg) then
    raise Exception.Create('Cannot delete this statement since there is a payment against its bill.' + #13#10 + msg);
  FullccsRelocateTo := GetLocateIdAfterDelete(FULLCCS);
  if BILLSId.Value = FULLCCSId.Value then // the bill that will be deleted is the one that is selected.
    BillRelocateTo := GetLocateIdAfterDelete(BILLS)
  else
    BillRelocateTo := BILLSId.Value;

  ZConnection1.StartTransaction;
  try
    ExecuteQuery('DELETE FROM CCSTATEMENTS WHERE Sid=' + FULLCCSSid.AsString);
    ExecuteQuery('DELETE FROM BILLS WHERE Id=' + FULLCCSId.AsString);
    ZConnection1.Commit;
  except
    ZConnection1.Rollback;
    raise;
  end;
  FULLCCS.CancelUpdates;
  RefreshDataSet(BILLS, rm_Locate, BillRelocateTo);
  OPENBILLS.Refresh; //RefreshDataSet(OPENBILLS, rm_Locate, 1);
  RefreshDataSet(FULLCCS, rm_Locate, FullccsRelocateTo);
  Abort;
{ DONE : Implement deletion using a query.
procedure:
  If the related bill has movements linked to it, the ccstatement wont be deleted and an exception will be raised.
  If there are no movements involved, the ccstatement and its linked bill are both deleted.
  If an exeption is raised, the transaction is rolled back and the exception is rerraised.

  Info:
  There are two ways of stopping a deletion inside BeforeDelete event handler: calling Abort or raisig an exception.
  So, if everything goes ok, the TDataSet deletion process will be stopped by calling Abort.
  Otherwise, any exception will stop it.

  After calling Abort, the affected datasets must be refreshed. No need to implement the AfterDelete event handler which
  by using Abort or raisin any exception wont never be called.
 }
end;

procedure TDM.FULLCCSBeforePost(DataSet: TDataSet);
var BillId: Integer;
begin
  CheckRequiredFields(DataSet);
  if DataSet.State = dsInsert then
    BillId := FULLCCSProcessInserts
  else if DataSet.State = dsEdit then
  begin
    FULLCCSProcessEdits;
    BillId := FULLCCSId.Value;
  end
  else
    raise Exception.Create('FULLCCS not in edit or insert mode.');
  FULLCCS.CancelUpdates;
  FULLCCS.Cancel;
  RefreshDataSet(FULLCCS, rm_Locate, BillId);
  RefreshDataSet(BILLS, rm_Locate, BILLSId.Value);
  OPENBILLS.Refresh; //RefreshDataSet(OPENBILLS, rm_Locate, 1);
end;

procedure TDM.FULLCCSCalcFields(DataSet: TDataSet);
begin
  if (not FULLCCSC_T_Date.IsNull) and (not FULLCCSC_T_Date.IsNull) then
    FULLCCSDays_In_Cycle.Value := Trunc(FULLCCSC_T_Date.Value - FULLCCSC_F_Date.Value) + 1;
  FULLCCSAvailable_Credit.Value := FULLCCSLimit.Value - FULLCCSPrev_Balance.Value;
  if FULLCCSLimit.Value <> 0 then
    FULLCCSUtilization.Value := 100 * (FULLCCSPrev_Balance.Value / FULLCCSLimit.Value)
  else
    FULLCCSUtilization.Value := 0;
end;

{Makes sure that on joint resultset FULLCCS, C_F_Date is older or equal that C_T_Date by raising an exception}
procedure TDM.FULLCCSValidateCycleDate(Sender: TField);
begin
  if FULLCCSC_T_Date.IsNull or FULLCCSC_F_Date.IsNull then
    Exit;
  if FULLCCSC_T_Date.Value < FULLCCSC_F_Date.Value then
    raise Exception.Create('Cycle closing date must be greater'#10#13+
                           'than cycle opening date!');
end;

function TDM.GetLocateIdAfterDelete(aDataSet: TZAbstractDataSet): Integer;
{Returns the Id of the record to which the aDataSet has to relocate to after deleting the actual record}
var
  IdToDelete: Integer;
begin
  aDataSet.DisableControls;
  try
    IdToDelete := aDataSet.FieldByName('Id').AsInteger;
    aDataSet.Next;
    Result := aDataSet.FieldByName('Id').AsInteger;
    aDataSet.Prior;
    if Result = IdToDelete then //the one to delete is the last one
    begin
      Result := aDataSet.FieldByName('Id').AsInteger;
      aDataSet.Next;
    end;
  finally
    aDataSet.EnableControls;
  end;
end;

function TDM.GetRunningBalance: Real;
{Returns the actual running balance of the account referenced by the MOVEMENTS dataset}
var
  BM: TBookmark;
begin
  MOVEMENTS.DisableControls;
  BM := MOVEMENTS.GetBookmark;
  MOVEMENTS.First;
  while (MOVEMENTSStatus.Value <> POSTED)and(not MOVEMENTS.Eof) do
    MOVEMENTS.Next;
  Result := MOVEMENTSRun_Balance.Value;
  MOVEMENTS.GotoBookmark(BM);
  MOVEMENTS.FreeBookmark(BM);
  MOVEMENTS.EnableControls;
end;

procedure TDM.FULLCCSPaymtAndChargesChange(Sender: TField);
var
  s_balance: Currency;
  Qry: TWQuery;
begin
  if FULLCCSRequireFieldsAreNull then
    Exit;
  Qry := TWQuery.CreateAndOpen(FULLCCSGetQueryForPrev_Balance(FULLCCS.ParamByName('RefId')
          .AsInteger));
  if Qry.RecordCount = 0 then
    s_balance := 0
  else
    s_balance := Qry.FieldByName('Prev_Balance').AsCurrency;
  Qry.CloseAndFree;
  FULLCCSPrev_Balance.Value := s_balance - FULLCCSPrev_Payments.Value +
               FULLCCSPrev_Expenses.Value + FULLCCSCharged_Interests.Value +
               FULLCCSCharged_Fees.Value;
end;

procedure TDM.FULLCCSProcessEdits;
begin
  ZConnection1.StartTransaction;
  try
    EditBillFromFULLCCS;
    EditCCStatementFromFULLCCS;
    ZConnection1.Commit;
  except
    ZConnection1.Rollback;
    raise;
  end;
end;

function TDM.FULLCCSProcessInserts: Integer;
begin
  ZConnection1.StartTransaction;
  try
    Result := InserBillFromFULLCCS;
    InsertCCStatementFromFULLCCS(Result);
    ZConnection1.Commit;
  except
    ZConnection1.Rollback;
    raise;
  end;
end;

function TDM.FULLCCSRequireFieldsAreNull: Boolean;
begin
  Result := FULLCCSPrev_Payments.IsNull or FULLCCSPrev_Expenses.IsNull or
    FULLCCSCharged_Interests.IsNull or FULLCCSCharged_Fees.IsNull or
    FULLCCSC_F_Date.IsNull;
end;

function TDM.FULLCCSGetQueryForPrev_Balance(aBillerId: Integer): string;
begin
  Result := 'SELECT Prev_Balance FROM BILLS INNER JOIN CCSTATEMENTS'#10#13 +
      'ON BILLS.Id=CCSTATEMENTS.Bill_Id WHERE Biller_Id=' + IntToStr(aBillerId) + #10#13;
  if FULLCCS.State = dsEdit then
  begin
    Result := Result + 'AND C_F_DATE<'#39 +
      GetSQLiteDateStr(FULLCCS.FieldByName('C_F_Date').AsDateTime) +
      #39' ORDER BY C_F_Date DESC LIMIT 1';
  end
  else if FULLCCS.State = dsInsert then
    Result := Result + 'ORDER BY C_F_Date DESC LIMIT 1';
end;

function TDM.InserBillFromFULLCCS: Integer;
var
  Qry: TWQuery;
begin
  Qry := TWQuery.CreateAndOpen('SELECT * FROM BILLS WHERE 0');
  Qry.Insert;
  Qry.FieldByName('Biller_Id').AsInteger := FULLCCSBiller_Id.Value;
  Qry.FieldByName('C_F_Date').AsDateTime := FULLCCSC_F_Date.Value;
  Qry.FieldByName('C_T_Date').AsDateTime := FULLCCSC_T_Date.Value;
  Qry.FieldByName('Payment_Due').AsCurrency := FULLCCSPayment_Due.Value;
  Qry.FieldByName('Due_Date').AsDateTime := FULLCCSDue_Date.Value;
//  Qry.FieldByName('Payment').Clear; // AsCurrency := FULLCCSPayment.Value;
//  Qry.FieldByName('LP_Date').Clear; //AsDateTime := FULLCCSLP_Date.Value;
  Qry.FieldByName('Active').AsBoolean := FULLCCSActive.Value;
  Qry.FieldByName('Notes').AsString := FULLCCSNotes.Value;
  Qry.Post;
  Result := Qry.FieldByName('Id').AsInteger;
  Qry.CloseAndFree;
end;

procedure TDM.InsertCCStatementFromFULLCCS(aBillId: Integer);
var
  Qry: TWQuery;
begin
  Qry := TWQuery.CreateAndOpen('SELECT * FROM CCSTATEMENTS WHERE 0');
  Qry.Insert;
  Qry.FieldByName('Bill_Id').AsInteger := aBillId;
  Qry.FieldByName('Prev_Payments').AsCurrency := FULLCCSPrev_Payments.Value;
  Qry.FieldByName('Prev_Expenses').AsCurrency := FULLCCSPrev_Expenses.Value;
  Qry.FieldByName('Charged_Interests').AsCurrency := FULLCCSCharged_Interests.Value;
  Qry.FieldByName('Charged_Fees').AsCurrency := FULLCCSCharged_Fees.Value;
  Qry.FieldByName('Prev_Balance').AsCurrency := FULLCCSPrev_Balance.Value;
  Qry.FieldByName('Interest_Rate').AsFloat := FULLCCSInterest_Rate.Value;
  Qry.FieldByName('Limit').AsCurrency := FULLCCSLimit.Value;
  Qry.Post;
  Qry.CloseAndFree;
end;

{Posts the data contained in the dataset MOVEMENTS into the table MOVEMENTS using a dedicated TZQuery object.
Dataset MOVEMENTS must be in insert or edit mode, otherwise an exception is raised.
The caller must refresh the dataset MOVEMENTS using the locate method. The Id of the inserted record is returned in
the MOVEMENTSId field itself}
procedure TDM.MOVEMENTSPost;
var
  Qry: TWQuery;
  qs: string;
begin
  Qry := nil;
  qs := 'SELECT * FROM MOVEMENTS WHERE ';
  try
    if MOVEMENTS.State = dsInsert then
    begin
      Qry := TWQuery.CreateAndOpen(qs + '0');
      Qry.Insert;
    end
    else if MOVEMENTS.State = dsEdit then
    begin
      Qry := TWQuery.CreateAndOpen(qs + 'Id=' + MOVEMENTSId.AsString);
      Qry.Edit;
    end
    else
      raise Exception.Create('Dataset MOVEMENTS not in Edit or Insert state');
    Qry.FieldByName('Account_Id').AsInteger := MOVEMENTSAccount_Id.Value;
    Qry.FieldByName('Op_Date').AsDateTime := MOVEMENTSOp_Date.Value;
    Qry.FieldByName('Amount').AsCurrency := MOVEMENTSAmount.Value;
    Qry.FieldByName('Type').AsInteger := MOVEMENTSType.Value;
    Qry.FieldByName('Status').AsInteger := MOVEMENTSStatus.Value;
    Qry.FieldByName('Description').AsString := MOVEMENTSDescription.Value;
    if not MOVEMENTSTarget_Id.IsNull then
      Qry.FieldByName('Target_id').AsInteger := MOVEMENTSTarget_Id.Value;
    if not MOVEMENTSRun_Balance.IsNull then
      Qry.FieldByName('Run_Balance').AsCurrency := MOVEMENTSRun_Balance.Value;
    if not MOVEMENTSLinked_Op.IsNull then
      Qry.FieldByName('Linked_Op').AsInteger := MOVEMENTSLinked_Op.Value;
    if not MOVEMENTSLinked_Bill.IsNull then
      Qry.FieldByName('Linked_Bill').AsInteger := MOVEMENTSLinked_Bill.Value;
    Qry.FieldByName('Notes').AsString := MOVEMENTSNotes.Value;
    Qry.FieldByName('Checked').AsBoolean := MOVEMENTSChecked.Value;
    Qry.Post;
    if MOVEMENTS.State = dsInsert then
      MOVEMENTSId.Value := Qry.FieldByName('Id').AsInteger;
  except
    if Qry <> nil then
      Qry.CloseAndFree;
    raise;
  end;
  Qry.CloseAndFree;
end;

function TDM.MOVEMENTSPostedDateAmountStatusChanged: Boolean;
begin
  Result := False;
  if MOVEMENTS.State = dsInsert then
  begin
    if (MOVEMENTSStatus.Value = POSTED) then
      Result := True;
  end
  else if MOVEMENTS.State = dsEdit then
  begin
    if ((MOVEMENTSStatus.OldValue = POSTED) and (MOVEMENTSStatus.Value <> POSTED)) or
      ((MOVEMENTSStatus.OldValue  <> POSTED) and (MOVEMENTSStatus.Value = POSTED)) then
      Result := True
    else if ((MOVEMENTSStatus.OldValue = POSTED) and (MOVEMENTSStatus.Value = POSTED)) and
      (MOVEMENTSDateChanged or MOVEMENTSAmountChanged) then
      Result := True;
  end;
end;

function TDM.MOVEMENTSDateChanged: Boolean;
begin
  Result := MOVEMENTSOp_Date.OldValue <> MOVEMENTSOp_Date.Value;
end;

{Copy the records from the PastingDS into MOVEMENTS dataset}
procedure TDM.MOVEMENTSAddFromPastingDS;
  procedure CleanSuccessfullRecords;
  begin
    PastingDS.First;
    while not PastingDS.Eof do
    begin
      if PastingDSSuccess.Value then
        PastingDS.Delete
      else
        PastingDS.Next;
    end;
  end;
begin
  PastingDSOrderBy('Date', True);
  MOVEMENTS.First;
  PastingDS.First;
  try
    while not PastingDS.Eof do
    begin
      if PastingDSPaste.Value then
      begin
        MOVEMENTS.Insert;
        MOVEMENTSOp_Date.Value := PastingDSDate.Value;
        MOVEMENTSAmount.Value := PastingDSAmount.Value;
        MOVEMENTSType.Value := PastingDSType.Value;
        MOVEMENTSStatus.Value := POSTED;
        MOVEMENTSDescription.Value := PastingDSDescription.Value;
        if not PastingDSTarget_Id.IsNull then
          MOVEMENTSTarget_Id.Value := PastingDSTarget_Id.Value;
        if not PastingDSLinked_Op.IsNull then
          MOVEMENTSLinked_Op.Value := PastingDSLinked_Op.Value;
        if not PastingDSLinked_Bill.IsNull then
          MOVEMENTSLinked_Bill.Value := PastingDSLinked_Bill.Value;
        MOVEMENTSNotes.Value := PastingDSNotes.Value;
        MOVEMENTSChecked.Value := True;

        MOVEMENTS.Post;
        PastingDS.Edit;
        PastingDSSuccess.Value := True;
        PastingDS.Post;
      end;
      PastingDS.Next;
    end;
  except
    MOVEMENTS.Cancel;
  end;
  CleanSuccessfullRecords;
end;

procedure TDM.MOVEMENTSAfterCancel(DataSet: TDataSet);
begin
  MOVEMENTSLockFields(True);
end;

procedure TDM.MOVEMENTSAfterInsert(DataSet: TDataSet);
begin
  MOVEMENTSAfterInsertSetDefaultValues;
end;

function TDM.MOVEMENTSAfterInsertSetDefaultValues: Integer;
begin
  Result := MOVEMENTS.ParamByName('RefId').AsInteger;
  MOVEMENTSAccount_Id.Value :=  Result;
  MOVEMENTSCheckActiveConstraint(Result);
  MOVEMENTSType.Value := EXPENSES;
  MOVEMENTSStatus.Value := POSTED;
  MOVEMENTSOp_Date.Value := TDate(Date);
end;

procedure TDM.MOVEMENTSAfterScroll(DataSet: TDataSet);
begin
  MOVEMENTSSetFieldReadOnlyness;
end;

function TDM.MOVEMENTSAmountChanged: Boolean;
begin
  Result := MOVEMENTSAmount.OldValue <> MOVEMENTSAmount.Value;
end;

{Deletes the actual movement record, by first:
  -Undoing any posted bill payment and
  -Recomputing the running balances.
If the movement is an outgoing transfer, the linked movement is also deleted.
Refreshes the affected datasets, including MOVEMENTS and stops the TDataset object deletion process by calling abort.}
procedure TDM.MOVEMENTSBeforeDelete(DataSet: TDataSet);
var
  IdToDelete, IdToRelocate, LinkedOp, TargetId: Integer;
  isAnOutGoingTransfer: Boolean;
begin
  ZConnection1.StartTransaction;
  try
    if MOVEMENTSType.Value = INTRANSFER then
      raise Exception.Create('Incoming transfer cannot be deleted. Instead,'#13#10 +
                             'delete the corresponding outgoing transfer.');
    if MOVEMENTSStatus.Value = POSTED then        //if the movement to be deleted is posted...
    begin
      if MOVEMENTSType.Value = BILLPAYMENT then   //and its a payment, it must be undone first,
        MOVEMENTSUndoPayBill;
      //then recompute RB after it (excluding it)
      MOVEMENTSComputeRB(MOVEMENTS.ParamByName('RefId').AsInteger, MOVEMENTSId.Value, rrbm_Exclude);
    end;
    LinkedOp := MOVEMENTSLinked_Op.Value;
    TargetId := MOVEMENTSTarget_Id.Value;
    isAnOutGoingTransfer := MOVEMENTSType.Value = OUTTRANSFER;
    //prepare the id to relocate to when refreshing MOVEMENTS
    IdToDelete := MOVEMENTSId.Value;
    IdToRelocate := GetLocateIdAfterDelete(MOVEMENTS);
    //Delete the movement record
    ExecuteQuery('DELETE FROM MOVEMENTS WHERE Id=' + IntToStr(IdToDelete));
    if isAnOutGoingTransfer then
    begin
      MOVEMENTSComputeRB(TargetId, LinkedOp, rrbm_Exclude);
      ExecuteQuery('DELETE FROM MOVEMENTS WHERE Id=' + IntToStr(LinkedOp));
    end;
    ZConnection1.Commit;
  except
    ZConnection1.Rollback;
    raise;
  end;
  //finally, everything is refreshed.
  RefreshDataSet(BILLS, rm_Bookmark);
  OPENBILLS.Refresh; //RefreshDataSet(OPENBILLS, rm_Bookmark);
  RefreshDataSet(MOVEMENTS, rm_Locate, IdToRelocate);
  //Stops the TDataSet object deletion process
  Abort;
end;

procedure TDM.MOVEMENTSBeforeInsert(DataSet: TDataSet);
begin //Unlocks the locked fields so they can initially be edited
  MOVEMENTSLockFields(False);
end;

procedure TDM.MOVEMENTSBeforePost(DataSet: TDataSet);
var
  Id: Integer;
  NewDate: TDate;
begin
  CheckRequiredFields(MOVEMENTS);
  ZConnection1.StartTransaction;
  try
    if MOVEMENTSDateChanged then
    begin
      if MOVEMENTSOp_Date.OldValue < MOVEMENTSOp_Date.Value then
        NewDate := MOVEMENTSOp_Date.OldValue
      else
        NewDate := MOVEMENTSOp_Date.Value
    end
    else
      NewDate := 0;

    if MOVEMENTSType.Value = BILLPAYMENT then
      MOVEMENTSProcessBill;

    MOVEMENTSPost;
    Id := MOVEMENTSId.Value;

    if MOVEMENTSType.Value = OUTTRANSFER then
      MOVEMENTSProcessOutTransfer;

    if MOVEMENTSType.Value = INTRANSFER then
      MOVEMENTSProcessInTransfer;

    if MOVEMENTSPostedDateAmountStatusChanged then
      MOVEMENTSComputeRB(MOVEMENTS.ParamByName('RefId').AsInteger, Id, rrbm_Include, NewDate);
    ZConnection1.Commit;
  except
    ZConnection1.Rollback;
    raise;
  end;
  MOVEMENTS.Cancel;
  MOVEMENTSCheckUpdateBILLS;
  MOVEMENTSLockFields(True);
  MOVEMENTSSetFieldReadOnlyness;
  RefreshDataSet(MOVEMENTS, rm_Locate, Id);

{* When posting changes to an existing record on a table "A" (or when posting a new inserted record), the wrong way of
  posting changes is this way: (to be avoided)
  1. The before post even handler calls a method that modifies/inserts a record into a table "B".
     If something goes wrong inside that method, an exception is raised (no changes on table "B" occurs) and propagated
     to the before post event handler, so aborting the posting process on table "A".
  2. If no exception is raise, the posting on table "A" is then acomplish by the dataset library.
  3. The after post event handler takes care of the last step, including modifying a table "C" or refreshing data on all
     modified tables ("A", "B" and "C").
* That works ok if there are no exception after step 1; if an exception is raised inside step 2 or 3, the changes made
  on step 1 remains, introducing inconsistencies to the database.

* The approach to post changes in several tables at a time, using a TZQuery object is like this:
  1. In the before post event handler, make all the modifications/insertions to the tables "A", "B"and "C" at once
     inside a started transaction. If something goes wrong, roll back changes and raise an exception. If everything
     is ok, just call DataSet.Cancel to stop the current posting process; finally, refresh the modified tables.
     No need to rely on after post event handlers.

* This way is the correct one to implement.
* What are the table that are implementing the wrong way?
  ACCOUNTS: Ok. BeforePost to check constraints and AfterPost to refresh other affected datasets.
  BILLS:    Ok. Same as ACCOUNTS.
  FULLCCS:  Ok. It's a complex query with cached updates that never calls ApplyUpdates. It only uses the BeforePost and
            BeforeDelete event handler to post and delete records on others tables by using on the fly ZQueries.
  MOVEMENTS: Ok for the deletion process.
             Ok for the post process.}
end;

procedure TDM.MOVEMENTSCheckActiveConstraint(anAccountId: Integer);
begin   //no new movement can reference an inactive account
  if not ACCOUNTSIsActive(anAccountId) then
  begin
    MOVEMENTS.Cancel;
    raise Exception.Create('Movement cannot reference an inactive account.');
  end;
end;

procedure TDM.MOVEMENTSCheckedGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if MOVEMENTSChecked.IsNull then   //default value
    Exit;
  if MOVEMENTSChecked.Value then
    Text := 'Yes'
  else
    Text := 'No';
end;

procedure TDM.MOVEMENTSCheckedSetText(Sender: TField; const Text: string);
begin
  Sender.AsBoolean := Text = 'Yes';
end;

procedure TDM.MOVEMENTSCheckUpdateBILLS;
begin
  if MustUpdateBILLS then
  begin
    MustUpdateBILLS := False;
    RefreshDataSet(BILLS, rm_Bookmark);
    OPENBILLS.Refresh; //RefreshDataSet(OPENBILLS, rm_Bookmark);
  end;
end;

procedure TDM.MOVEMENTSUndoPayBill;
var
  LastDate, PenultimateDate, UseDate: TDate;
  MLB: Boolean;
begin
  MOVEMENTSGetLastAndPenultimatePaymentDates(MOVEMENTSLinked_Bill.Value,
    MOVEMENTSOp_Date.OldValue, LastDate, PenultimateDate);
  if MOVEMENTSOp_Date.OldValue = LastDate then
    UseDate := PenultimateDate
  else
    UseDate := LastDate;
  MOVEMENTSUpdateBill(MOVEMENTSLinked_Bill.Value, -MOVEMENTSAmount.OldValue,
    UseDate, True);
  if (MOVEMENTSStatus.Value = CANCELLED) then
  begin
    MLB := MOVEMENTSLinked_Bill.ReadOnly;
    MOVEMENTSLinked_Bill.ReadOnly := False;
    MOVEMENTSLinked_Bill.Clear;
    MOVEMENTSLinked_Bill.ReadOnly := MLB;
  end;
end;

procedure TDM.MOVEMENTSPayBill;
begin
  MOVEMENTSUpdateBill(MOVEMENTSLinked_Bill.Value, MOVEMENTSAmount.Value, MOVEMENTSOp_Date.Value,
    FALSE);
end;

procedure TDM.MOVEMENTSProcessBill;
begin
  MOVEMENTSCheckPaymentRequirements;
  if (MOVEMENTS.State = dsInsert) and (MOVEMENTSStatus.Value = POSTED) then
    MOVEMENTSPayBill
  else if MOVEMENTS.State = dsEdit then
    MOVEMENTSProcessChanges;
end;

{Recomputes the movement's running balance on each posted record, starting and including the record FromThisRecord and
saving it to the MOVEMENTS table.
If RecomputeMode is rrbm_Delete, that record gets deleted before and the recalculation process starts at the
following record.
The caller should start a transaction before calling this procedure; also, the caller must commit the changes when this
procedure returns unles this procedure throws an exception in which case the caller must roll back the changes.}
procedure TDM.MOVEMENTSComputeRB(AccountId: Integer; FromThisRecord: Integer;
  RecomputeMode: TRecomputeRBMode = rrbm_Include; OldDate: TDate = 0);
var
  PreviousBalance: Currency;
  ActualBalance: Currency;
  _Sign: ShortInt;
  Qry: TWQuery;
  FType, FStatus: TLargeintField;
  FAmount, FRun_Balance: TFloatField;
begin
  if (RecomputeMode = rrbm_Exclude) and (OldDate <> 0) then
    raise Exception.Create('Wrong combination of arguments!!!S');

  Qry := TWQuery.CreateAndOpen(
    'SELECT Id, Type, Status, Op_Date, Amount, Run_Balance FROM MOVEMENTS'#10#13 +
      'WHERE Account_Id=' + IntToStr(AccountId) + #10#13 +
      'ORDER BY Op_Date ASC, Id ASC');
  FType := TLargeintField(Qry.FieldByName('Type'));
  FStatus := TLargeintField(Qry.FieldByName('Status'));
  FAmount := TFloatField(Qry.FieldByName('Amount'));
  FRun_Balance := TFloatField(Qry.FieldByName('Run_Balance'));
  try
    PreviousBalance := MOVEMENTSGetPreviousBalance(FromThisRecord, OldDate, Qry);
    if RecomputeMode = rrbm_Exclude then
    begin
      Qry.Next; // the cursor advaces to the next record, excluding the actual record for recomputing.
      if Qry.Eof then // If it is the last one, we have nothing to recompute.
      begin
        Qry.CloseAndFree;
        Exit;
      end;
    end;
    while not Qry.Eof do
    begin
      Qry.Edit;
      if FStatus.Value <> POSTED then
      begin
        FRun_Balance.Clear;
      end
      else
      begin
        _Sign := Sign(FType.Value);
        ActualBalance := PreviousBalance + _Sign * FAmount.Value;
        FRun_Balance.Value := ActualBalance;
        PreviousBalance := ActualBalance;
      end;
      Qry.Post;
      Qry.Next;
    end;
  except
    Qry.CloseAndFree;
    raise;
  end;
  Qry.CloseAndFree;
end;

procedure TDM.MOVEMENTSProcessChanges;
begin
  if MOVEMENTSStatus.OldValue = POSTED then
  begin
    if (MOVEMENTSStatus.Value = POSTED) and (MOVEMENTSDateChanged or MOVEMENTSAmountChanged) then
    begin
      MOVEMENTSUndoPayBill;
      MOVEMENTSPayBill;
    end
    else if (MOVEMENTSStatus.Value = PLANNED) or (MOVEMENTSStatus.Value = CANCELLED) then
      MOVEMENTSUndoPayBill;
  end
  else if (MOVEMENTSStatus.OldValue = PLANNED) and (MOVEMENTSStatus.Value = POSTED) then
    MOVEMENTSPayBill
  else if (MOVEMENTSStatus.OldValue = CANCELLED) and (MOVEMENTSStatus.Value <> CANCELLED) then
    raise Exception.Create('Cancelled movements cannot change status.');
end;

{Check that the Op_Date of the incoming tranfer movement is equal to or older than the date of the outgoing transfer
movement}
procedure TDM.MOVEMENTSProcessInTransfer;
var
  Qry: TWQuery;
begin
  Qry := TWQuery.CreateAndOpen('SELECT Op_Date FROM MOVEMENTS WHERE Id=' + MOVEMENTSLinked_Op.AsString);
  try
    if Qry.RecordCount = 0 then
      raise Exception.Create('Incoming transfer doesnt have a linked outgoing transfer.');
    if MOVEMENTSOp_Date.Value < Qry.FieldByName('Op_Date').AsDateTime then
      raise Exception.Create('Incoming transfer date (' + MOVEMENTSOp_Date.AsString + ') cannot be earlier'#13#10 +
                             'than the outgoing transfer date (' + Qry.FieldByName('Op_Date').AsString + ')');
  except
    Qry.CloseAndFree;
    raise;
  end;
  Qry.CloseAndFree;
end;

procedure TDM.MOVEMENTSProcessOutTransfer;
begin
  if MOVEMENTSTarget_Id.IsNull then
    raise Exception.Create('Target account cannot be null.');
  if MOVEMENTS.State = dsInsert then
    MOVEMENTSProcessTransferInsert
  else if MOVEMENTS.State = dsEdit then
    MOVEMENTSProcessTransferEdit
  else
    raise Exception.Create('Not in edit/insert mode');
{ DONE :
MOVEMENTSProcessTransfer must do the following task:

If the movement is being inserted:
  Using a TZQuery object, insert another movement that is the mirrored movement of the one being processed
  (the one that has just been processed in the MOVEMENTPost procedure). Link both movements using its Ids.

If the movement is being edited:
  Changes in date, amount, status, checked are reflected in both linked movements.
  Running balances must also be recompute for the mirrored movement (of the target account).

Movement receiving the transfer (incoming transfer) is completelly readonly except for its notes. }
end;

procedure TDM.MOVEMENTSProcessTransferEdit;
var
  Qry: TWQuery;
begin
  Qry := TWQuery.CreateAndOpen('SELECT * FROM MOVEMENTS WHERE Id=' + MOVEMENTSLinked_Op.AsString);
  try
    if Qry.RecordCount = 0 then
      raise Exception.Create('Outgoing transfer doesnt have a linked incoming transfer.');
    Qry.Edit;
    Qry.FieldByName('Op_Date').AsDateTime := MOVEMENTSOp_Date.AsDateTime;
    Qry.FieldByName('Amount').AsCurrency := MOVEMENTSAmount.Value;
    Qry.FieldByName('Status').AsInteger := MOVEMENTSStatus.Value;
    Qry.FieldByName('Checked').AsBoolean := MOVEMENTSChecked.Value;
    Qry.Post;
    if MOVEMENTSPostedDateAmountStatusChanged then
      MOVEMENTSComputeRB(MOVEMENTSTarget_Id.Value, MOVEMENTSLinked_Op.Value);
  except
    Qry.CloseAndFree;
    raise;
  end;
  Qry.CloseAndFree;
end;

procedure TDM.MOVEMENTSProcessTransferInsert;
var
  Qry: TWQuery;
begin
  Qry := TWQuery.CreateAndOpen('SELECT * FROM MOVEMENTS WHERE Id=' + MOVEMENTSId.AsString);
  try
    if Qry.RecordCount = 0 then
      raise Exception.Create('No such a transfer movement.');
    Qry.Insert;
    Qry.FieldByName('Account_Id').AsInteger := MOVEMENTSTarget_Id.Value;
    Qry.FieldByName('Op_Date').AsDateTime := MOVEMENTSOp_Date.AsDateTime;
    Qry.FieldByName('Amount').AsCurrency := MOVEMENTSAmount.Value;
    Qry.FieldByName('Type').AsInteger := INTRANSFER;
    Qry.FieldByName('Status').AsInteger := MOVEMENTSStatus.Value;
    Qry.FieldByName('Description').AsString := MOVEMENTSDescription.Value;
    Qry.FieldByName('Target_Id').AsInteger := MOVEMENTSAccount_Id.Value;
    Qry.FieldByName('Linked_Op').AsInteger := MOVEMENTSId.Value;
    Qry.FieldByName('Notes').AsString := MOVEMENTSNotes.Value;
    Qry.FieldByName('Checked').AsBoolean := MOVEMENTSChecked.Value;
    Qry.Post;
    MOVEMENTSLinked_Op.Value := Qry.FieldByName('Id').AsInteger;
    Qry.Next;
//this is not workin, Prior is not returning to the previous record. is it Next? How can I predict the correct one?
//maybe I have to order the dataset and refresh it, in order to make sure the record I'm pointing to is the correct one.
    Qry.Edit;
    Qry.FieldByName('Linked_Op').AsInteger := MOVEMENTSLinked_Op.Value;
    Qry.Post;
    MOVEMENTSComputeRB(MOVEMENTSTarget_Id.Value, MOVEMENTSLinked_Op.Value);
  except
    Qry.CloseAndFree;
    raise;
  end;
  Qry.CloseAndFree;
end;

procedure TDM.MOVEMENTSSetFieldReadOnlyness;
begin
  MOVEMENTSChecked.ReadOnly := not (MOVEMENTSStatus.Value = POSTED);
  MOVEMENTSOp_Date.ReadOnly := MOVEMENTSStatus.Value = CANCELLED;
  MOVEMENTSDescription.ReadOnly := MOVEMENTSStatus.Value = CANCELLED;
  MOVEMENTSAmount.ReadOnly := (MOVEMENTSStatus.Value = CANCELLED) or (MOVEMENTSType.Value = INTRANSFER);
  MOVEMENTSStatus.ReadOnly := (MOVEMENTSStatus.Value = CANCELLED) or (MOVEMENTSType.Value = INTRANSFER);
end;

procedure TDM.MOVEMENTSStatusChange(Sender: TField);
begin
  if MOVEMENTSStatus.Value <> POSTED then
  begin
    MOVEMENTSChecked.ReadOnly := False;
    MOVEMENTSChecked.Value := False;
    MOVEMENTSChecked.ReadOnly := True;
  end
  else
    MOVEMENTSChecked.ReadOnly := False;
end;

procedure TDM.MOVEMENTSStatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if MOVEMENTSStatus.IsNull then
    Exit;
  case MOVEMENTSStatus.Value of
    0: Text := 'Posted';
    1: Text := 'Planned';
    2: Text := 'Cancelled';
  end;
end;

procedure TDM.MOVEMENTSStatusSetText(Sender: TField; const Text: string);
begin
  if Text = 'Posted' then
    MOVEMENTSStatus.Value := 0
  else if Text = 'Planned' then
    MOVEMENTSStatus.Value := 1
  else if Text = 'Cancelled' then
    MOVEMENTSStatus.Value := 2;
end;

procedure TDM.MOVEMENTSTypeChange(Sender: TField);
  procedure ClearTarget;
  begin
    MOVEMENTSTarget_Id.ReadOnly := False;
    MOVEMENTSTarget_Id.Clear;
    MOVEMENTSTarget_Id.ReadOnly := True;
    TRANSFERACCOUNTS.Filtered := False;
  end;
  procedure ClearBill;
  begin
    MOVEMENTSLinked_Bill.ReadOnly := False;
    MOVEMENTSLinked_Bill.Clear;
    MOVEMENTSLinked_Bill.ReadOnly := True;
    OPENBILLS.Filtered := False;
  end;
begin
  if MOVEMENTSType.Value = BILLPAYMENT then
  begin
    ClearTarget;
    MOVEMENTSLinked_Bill.ReadOnly := False;
    OPENBILLS.Filtered := True;
  end
  else if MOVEMENTSType.Value = OUTTRANSFER then
  begin
    ClearBill;
    MOVEMENTSTarget_Id.ReadOnly := False;
    TRANSFERACCOUNTS.Filter := 'Id<>' + MOVEMENTS.ParamByName('RefId').AsString;
    TRANSFERACCOUNTS.Filtered := True;
  end
  else
  begin
    ClearBill;
    ClearTarget;
  end;
end;

procedure TDM.OPENBILLSAfterRefresh(DataSet: TDataSet);
var
  Listener: TNotifyEvent;
begin
  for Listener in FOnOPENBILLSRefresh do
    Listener(OPENBILLS);
end;

procedure TDM.OPENBILLSBillGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  Text := Sender.AsString;
end;

procedure TDM.OPENBILLSCalcFields(DataSet: TDataSet);
var
  s: WideString;
  pd, p, b: Currency;
begin
  {DONE: the length of the open bill description should not be determined/calculated here}
  pd := OPENBILLSPayment_Due.Value;
  p := OPENBILLSPayment.Value;
  b := pd - p;
  s := OPENBILLSName.Value;
//  if Length(s) > 40 then
//    s := Copy(s, 1, 40) + '...';
  s := Format('$%8.2f/$%8.2f',[b, pd]) + ' [' + OPENBILLSDue_Date.AsString + '] ' + s;
  OPENBILLSBill.AsString := s;
  OPENBILLSPendingAmount.Value := b;
end;

procedure TDM.OPENBILLSRegisterRefreshListener(aListener: TNotifyEvent);
begin
  if FOnOPENBILLSRefresh.IndexOf(aListener) = -1 then
    FOnOPENBILLSRefresh.Add(aListener);
end;

procedure TDM.OPENBILLSUnRegisterRefreshListener(aListener: TNotifyEvent);
begin
  FOnOPENBILLSRefresh.Remove(aListener);
end;

//procedure TDM.PastingDSAfterPost(DataSet: TDataSet);
//begin
////I dont like the way I'm implementing the marking the picked bill from the picklist. Too much effort for an ugly result..
//end;

procedure TDM.PastingDSAfterScroll(DataSet: TDataSet);
begin
  PastingDSTarget_Id.ReadOnly := True;
  TRANSFERACCOUNTS.Filtered := False;
  PastingDSLinked_Bill.ReadOnly := True;
  OPENBILLS.Filtered := False;

  if PastingDSType.Value = BILLPAYMENT then
  begin
    PastingDSLinked_Bill.ReadOnly := False;
    OPENBILLS.Filtered := True;
  end;

  if PastingDSType.Value = OUTTRANSFER then
  begin
    PastingDSTarget_Id.ReadOnly := False;
    TRANSFERACCOUNTS.Filter := 'Id<>' + MOVEMENTS.ParamByName('RefId').AsString;
    TRANSFERACCOUNTS.Filtered := True;
  end;
end;

function TDM.PastingDSIsAscending(oFieldName: string): Boolean;
{Return true if the indicated field name's index is ascending, false if it's descenging}
var
  i: Integer;
begin
  if UpperCase(Copy(PastingDS.IndexName, 5, Length(PastingDS.IndexName))) = UpperCase(oFieldName) then
  begin
    i := PastingDS.IndexDefs.IndexOf(PastingDS.IndexName);
    Result := not(ixDescending in PastingDS.IndexDefs[i].Options);
  end
  else
    Result := False;
end;

//procedure TDM.PastingDSLinked_BillChange(Sender: TField);
//begin
//
//end;

//procedure TDM.PastingDSLinked_BillGetText(Sender: TField; var Text: string; DisplayText: Boolean);
//var i: Integer;
//begin
//  if PastingDSBillStrings = nil then
//    raise Exception.Create('Bill string is nil.');
//  for i := 0 to PastingDSBillStrings.Count - 1 do
//  begin
//    if PastingDSLinked_Bill.Value = Integer(PastingDSBillStrings.Objects[i]) then
//    begin
//      Text := PastingDSBillStrings[i];
//      Break;
//    end;
//  end;
//end;

//procedure TDM.PastingDSLinked_BillSetText(Sender: TField; const Text: string);
//var i: Integer;
//begin
//  if PastingDSBillStrings = nil then
//    raise Exception.Create('Bill string is nil.');
//  for i := 0 to PastingDSBillStrings.Count - 1 do
//  begin
//    if Text = PastingDSBillStrings[i] then
//    begin
//      PastingDSLinked_Bill.Value := Integer(PastingDSBillStrings.Objects[i]);
//      Break;
//    end;
//  end;
//end;

procedure TDM.PastingDSOrderBy(oFieldName: string; Asc: Boolean);
{Orders the PastingDS by the field indicated. If Asc is true, the order is ascending, otherwise it's descending}
var
  i: Integer;
  found: Boolean;
  function IndexIsAcending: Boolean;
  begin
    Result := not(ixDescending in PastingDS.IndexDefs[i].Options);
  end;
  function IndexIsDescending: Boolean;
  begin
    Result := not IndexIsAcending;
  end;
begin
  found := False;
  for i := 0 to PastingDS.IndexDefs.Count - 1 do
  begin
    if UpperCase(PastingDS.IndexDefs[i].Fields) = UpperCase(oFieldName) then
    begin
      if (IndexIsAcending and Asc) or (IndexIsDescending and not Asc) then
      begin
        PastingDS.IndexName := PastingDS.IndexDefs[i].Name;
        found := True;
        Break;
      end;
    end;
  end;
  if not found then
    raise Exception.Create('Index not found.');
end;

procedure TDM.PastingDSTypeChange(Sender: TField);
  procedure ClearTarget;
  begin
    PastingDSTarget_Id.ReadOnly := False;
    PastingDSTarget_Id.Clear;
    PastingDSTarget_Id.ReadOnly := True;
    TRANSFERACCOUNTS.Filtered := False;
  end;
  procedure ClearBill;
  begin
    PastingDSLinked_Bill.ReadOnly := False;
    PastingDSLinked_Bill.Clear;
    PastingDSLinked_Bill.ReadOnly := True;
    OPENBILLS.Filtered := False;
  end;
begin
  if PastingDSType.Value = BILLPAYMENT then
  begin
    ClearTarget;
    PastingDSLinked_Bill.ReadOnly := False;
    OPENBILLS.Filtered := True;
  end
  else if PastingDSType.Value = OUTTRANSFER then
  begin
    ClearBill;
    PastingDSTarget_Id.ReadOnly := False;
    TRANSFERACCOUNTS.Filter := 'Id<>' + MOVEMENTS.ParamByName('RefId').AsString;
    TRANSFERACCOUNTS.Filtered := True;
  end
  else
  begin
    ClearBill;
    ClearTarget;
  end;
end;

function TDM.AddOneMonth(aDate: TDate): TDate;
var
  year: Word;
  day: Word;
  month: Word;
begin
  DecodeDate(aDate, year, month, day);
  inc(month);
  if month = 13 then
  begin
    month := 1;
    inc(year);
  end;
  if (day > 28) and (month = 2) then
    day := 28;
  if (day > 30) and (month in [4, 6, 9, 11]) then
    day := 30;
  Result := EncodeDate(year, month, day);
end;

{Refresh the aDataset using two different methods: rm_Bookmark or rm_Locate
  - rm_Bookmark: uses the dataset's GotoBookmark method. This works when editing an existing record, not when deleting/
    inserting a new one. In this case, RecordId is meaningless and default to -1.
  - rm_Locate: uses the dataset's Locate method. This works when deleting/inserting new record. After the record has been
    inserted, the caller must provide the Id of that record as a parameter; is a record is about to be deleted, the
    caller must provide the id of the record to which relocate to; in both cases, if the record id is not provided,
    an exception is raised. }
procedure TDM.RefreshDataSet(aDataSet: TZAbstractDataSet; RefreshMethod: TRefreshMethod; RecordId: Integer = -1);
var
  BM: TBookmark;
begin
  aDataSet.DisableControls;
  if RefreshMethod = rm_Bookmark then
  begin
    BM := aDataSet.GetBookmark;
    try
      aDataSet.Refresh;
      //there is a bug in the Zeos library than can be reproduced when inserting new records into MOVEMENTS ZQuery.
      //the bookmark is lost and the last record of the set becomes the actual record.
      aDataSet.GotoBookmark(BM);
    finally
      aDataSet.FreeBookmark(BM);
    end;
  end
  else if RefreshMethod = rm_Locate then  //method valid only for dataset with an Id field
  begin
    if RecordId = -1 then
      raise Exception.Create('Missing RecordId parameter.');
    try
      aDataSet.Refresh;
      aDataSet.Locate('Id', RecordId, []);
    finally
      //whatever. Just want to silence any exception that can raise here.
    end;
  end;
  aDataSet.EnableControls;
end;

procedure TDM.SetSummaryStartFromDate(aDate: TDate);
var ShowFromStr: string;
begin
  if aDate = FSUMMARYShowFromDate then
    Exit;
  FSUMMARYShowFromDate := aDate;
  SUMMARY.Filtered := False;
  ShowFromStr := GetSQLiteDateStr(FSUMMARYShowFromDate);
  SUMMARY.Filter := 'DUEDATE >= '#39 + ShowFromStr + #39 + ' OR BALANCE > 0 OR MOVSTATUS = 1';
  SUMMARY.Filtered := True;
  ACCOUNTPAYMENTS.ParamByName('DDT').AsString := ShowFromStr;
  if ACCOUNTPAYMENTS.Active then
    ACCOUNTPAYMENTS.Refresh;
  ACCOUNTTOTALS.ParamByName('DDT').AsString := ShowFromStr;
  if ACCOUNTTOTALS.Active then
    ACCOUNTTOTALS.Refresh;
end;

procedure TDM.SUMMARYBALANCEGetText(Sender: TField; var Text: string; DisplayText: Boolean);
var
  bal: Currency;
begin
  bal := Sender.AsCurrency;
  if  bal < 0 then
    bal := 0;
  Text := CurrToStrF(bal, ffCurrency, 2);
end;

procedure TDM.SUMMARYBILLERTYPEGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsInteger = 3 then
    Text := 'CC'
  else if Sender.AsInteger = 4 then
    Text := 'OB';
end;

procedure TDM.SUMMARYDAYSLEFTGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if SUMMARYBALANCE.Value <=0 then
    Text := 'PAID'
  else if (Sender.AsInteger < 0) or (SUMMARYBALANCE.Value > SUMMARYPAYMENTDUE.Value)  then
    Text := 'DUE'
  else
    Text := Sender.AsString;
end;

procedure TDM.SUMMARYMOVSTATUSGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsInteger = POSTED then
    Text := 'POSTED'
  else if Sender.AsInteger = PLANNED then
    Text := 'PLANNED'
  else
    Text := '';
end;

procedure TDM.TypeGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  case Sender.AsInteger of
    1: Text := 'Deposit';
    2: Text := 'Incoming transfer';
    3: Text := 'Salary';
    4: Text := 'Refund';
    127: Text := 'Other credits';
    -1: Text := 'Withdrawall';
    -2: Text := 'Outgoing transfer';
    -3: Text := 'Expenses';
    -4: Text := 'Payment';
    -127: Text := 'Other debits';
  end;
end;

procedure TDM.TypeSetText(Sender: TField; const Text: string);
begin
  if Text = 'Deposit' then
    Sender.AsInteger := 1
  else if Text = 'Incoming transfer' then
    Sender.AsInteger := 2
  else if Text = 'Salary' then
    Sender.AsInteger := 3
  else if Text = 'Refund' then
    Sender.AsInteger := 4
  else if Text = 'Other credits' then
    Sender.AsInteger := 127
  else if Text = 'Withdrawall' then
    Sender.AsInteger := -1
  else if Text = 'Outgoing transfer' then
    Sender.AsInteger := -2
  else if Text = 'Expenses' then
    Sender.AsInteger := -3
  else if Text = 'Payment' then
    Sender.AsInteger := -4
  else if Text = 'Other debits' then
    Sender.AsInteger := -127;
end;

procedure TDM.ValidateDate(Sender: TField; const Text: string);
var Error: Boolean;
begin
  Error := False;
  try
    if  RightStr(Text, 2) = '  ' then
      Sender.Value := VarToDateTime(LeftStr(Text, 5))
    else
      Sender.Value := VarToDateTime(Text);
  except
    Error := True;
  end;
  if Error then
    raise Exception.Create('Invalid date.');
end;

procedure TDM.YESNOGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if Sender.IsNull then   //default value
    Text := 'Yes'
  else if Sender.AsBoolean then
    Text := 'Yes'
  else
    Text := 'No';
end;

procedure TDM.YESNOSetText(Sender: TField; const Text: string);
begin
  Sender.AsBoolean := Text = 'Yes';
end;
procedure TDM.ACCOUNTPAYMENTSMOVSTATUSGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsInteger = POSTED then
    Text := 'POSTED'
  else if Sender.AsInteger = PLANNED then
    Text := 'PLANNED'
  else
    Text := '';
end;

{$ENDREGION}

{$REGION 'TWQuery'}
procedure TWQuery.CloseAndFree;
begin
  Close;
  Free;
end;

constructor TWQuery.CreateAndOpen(aSql: string);
begin
  inherited Create(nil);
  Connection := DM.ZConnection1;
  SQL.Add(aSql);
  Open;
end;
{$ENDREGION}

{$WARN GARBAGE OFF}
end.

{ TODO :
-implement form to enter data
*implement the planing views.
}

{TODO:

Operations should be entered using a form style not the dbgrid list.
The dbgrid is for showing the operation only, not for editing it:
  -Planned Ops in one color, example red. (only that field)
  -Posted Ops in color normal.
  -Cancelled Ops in light gray (the whole line)
  -Check Ops in color green (only that field)

Once an operation is entered, changes on it must be restricted:
on the entry form:
	-simple operations cannot be converted to compount operations and viceversa (affecting one account to affecting two accounts).
	-when an operation date changes, the runbalance must be recomputed.

avoid deletion of record by ctrl+del


the planned credit operation must be shown in the status bar
the planned debit operation must be shown in the status bar


pasting from spreadsheet
-The PastingDataSet must include the related account and that column must be shown in the pasting form.
-when the user select the type of operation as "incoming transfer" or "outgoing transfer" the program must mark that record with
 red color until the field related account be filled out.
-add & close must reamil inactive while records in red exist

}
{$WARN GARBAGE ON}
