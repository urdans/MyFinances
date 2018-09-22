unit PastingUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, ComCtrls, DB, DBGrids, StdCtrls, DBCtrls, BillPickList;

type
  TDBG = class(TCustomDBGrid);

  TPastingForm = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    Button3: TButton;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Button4: TButton;
    Label5: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DBGrid1ColEnter(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure Button4Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FOnClose: TNotifyEvent;
    FOkToAdd: Boolean;
    FRunningBalance: Real;
    BillPickList: TBillPickList;
    function GetFinalBalance: Real;
    function InsertData(aDate:TDate; Description: string; Amount: real): boolean;
    procedure OnClickAndHideBillPickList(Sender: TObject);
    procedure ProccessClipBoard;
    function ProcessContent(StringLines: TStrings): boolean;
  public
    { Public declarations }
    constructor Create(aOwner: TComponent; OnClose:TNotifyEvent); reintroduce;
    property OkToAdd: Boolean read FOkToAdd;
    procedure SetRunningBalance(aBalance: Real);
    procedure SetAccountName(aName: string);
  end;

var
  PastingForm: TPastingForm;

const
  TAB = #9;

implementation

uses
  DataModuleUnit, BatchProcessUnit;

{$R *.dfm}

{ TPastingForm }
function _TryStrToFloat(const S: string; out Value: Double): Boolean;
var
  temp: string;
  i: Integer;
begin
  temp :='';
  for i := 1 to Length(S) do
  begin
    if S[i]<>ThousandSeparator then
      temp := temp + S[i];
  end;
  Result := TryStrToFloat(temp, Value);
end;

function _TryStrToDate(Const S: string; out Value: TDateTime): boolean;
begin
  Result := True;
  try
    Value := VarToDateTime(S);
  except
    Result := False;
  end;
end;

procedure TPastingForm.Button1Click(Sender: TObject);
begin
  ProccessClipBoard;
{DONE:
  PastingDS must be ordered from older operations at the top, to the newer operations at the bottom.
  Just before aading the records from PastingDS to MOVEMENTS, PastingDS must be ordered.
  Also, while the user is working with the pasting form, he must be able to order the set at will.
  When the data is pasted from the source, a good idea is to keep it as it, eventhought the user could apply an
  order at will. In all cases, adding the records to MOVEMENTS has to be done in an ordered way (from older operations
  to newer ones).
}
end;

procedure TPastingForm.Button2Click(Sender: TObject);
var
  fb, eb: Real;
begin
  fb := GetFinalBalance;
  try
    eb := StrToFloat(Edit3.Text);
  except
    eb := 0;
    Edit3.Text := '0.00';
  end;
  Edit2.Text := FloatToStrF(fb, ffFixed, 15, 2); //FloatToStr(fb);
  Edit4.Text := FloatToStrF(fb - eb, ffFixed, 15, 2);//FloatToStr(fb - eb);
end;

procedure TPastingForm.Button3Click(Sender: TObject);
begin
{TODO:
Pasting form:

Test soon *
*  -clicking on the title of column "Target Account" or "Bill" raises an "Index not found" exception.
  -what is the proper side for the cancel and ok button to be place on? rightmost side.
	-Pasting form should have a maximize button. Questionable.
	-Selection on multiple rows should be also done using the shift+mouse combination. Check if later version of Delphi
   nativelly implement it.
	-Would it be probably nice to save the content of the dbgrid once it is prepared for process...?

	-It looks like a transfer can be processed without a target account being provided. Make tests, trying
	 to process an outgoing transfer without a target account.

*	-Editboxes for expected balance and difference looks like they are receiveing values the other way around.
	 Fix it.

	-When pasting form is initiated, it should somehow save the account Id against which it will add movements,
	 so the user can select another account to view from the combobox. For future versions

  -Fix the form so that minimum size guaratees that upper panel is shown properly.

}
  if DM.PastingDS.State = dsEdit then
    DM.PastingDS.Post;
  if MessageDlg('This operation cannot be undone!' + #13#10 +
    'Press OK to continue.',  mtWarning, mbOKCancel, 0) = mrOk then
  begin
    FOkToAdd := True;
    FOnClose(Self);
  end;
end;

procedure TPastingForm.Button4Click(Sender: TObject);
var
  _Type, TargetId, BillId, i: Integer;
  Description, Notes: string;
  _include: Boolean;
begin
  if DM.PastingDS.State = dsEdit then
    DM.PastingDS.Post;
  BatchProcessForm := TBatchProcessForm.Create(Self, DBGrid1);
  try
    if BatchProcessForm.ShowModal = mrOk then
    begin //apply data to selected rows
      _Type := DM.PastingDSType.Value;
      Description := DM.PastingDSDescription.Value;
      TargetId := DM.PastingDSTarget_Id.Value;
      BillId := DM.PastingDSLinked_Bill.Value;
      Notes := DM.PastingDSNotes.Value;
      _include := BatchProcessForm.chkInclude.Checked;
      DM.PastingDS.Cancel;
      for i:= 0 to DBGrid1.SelectedRows.Count-1 do
      begin
        DM.PastingDS.GotoBookmark(Pointer(DBGrid1.SelectedRows.Items[i]));
        DM.PastingDS.Edit;
        if BatchProcessForm.chkType.Checked then
          DM.PastingDSType.Value := _Type;
        if BatchProcessForm.chkDescription.Checked then
          DM.PastingDSDescription.Value := Description;
        if BatchProcessForm.chkTargetAcc.Checked then
          DM.PastingDSTarget_Id.Value := TargetId;
        if BatchProcessForm.chkBill.Checked then
          DM.PastingDSLinked_Bill.Value := BillId;
        if BatchProcessForm.chkNotes.Checked then
          DM.PastingDSNotes.Value := Notes;
        DM.PastingDSPaste.Value := _include;
        DM.PastingDS.Post;
      end;
    end;
  finally
    DM.PastingDS.Cancel;
    BatchProcessForm.Free;
  end;
end;

constructor TPastingForm.Create(aOwner: TComponent; OnClose: TNotifyEvent);
begin
  inherited Create(aOwner);
  FOnClose := OnClose;
  DM.PastingDS.EmptyDataSet;
end;

procedure TPastingForm.DBGrid1CellClick(Column: TColumn);
begin
  if (Column.Field.DataType = ftBoolean) then
  begin
    {toggle True and False}
    Column.Grid.DataSource.DataSet.Edit;
    Column.Field.Value:= not Column.Field.AsBoolean;
  end
  else
    DBGrid1ColEnter(nil);
end;

procedure TPastingForm.DBGrid1ColEnter(Sender: TObject);
var BillId, Row, Col: Integer;
begin
  if (DBGrid1.SelectedField <> DM.PastingDSType) and
    (DBGrid1.SelectedField <> DM.PastingDSTargetName) and
    (DBGrid1.SelectedField <> DM.PastingDSBill) then
    Exit;
  if (DBGrid1.SelectedField = DM.PastingDSTargetName) then
    if DM.PastingDSType.Value <> OUTTRANSFER then
      Exit;

  if DBGrid1.SelectedField = DM.PastingDSBill then
  begin
    if DM.PastingDSType.Value = BILLPAYMENT then
    begin
      if not DM.PastingDSLinked_Bill.IsNull then
        BillId := DM.PastingDSLinked_Bill.Value
      else
        BillId := -1;
      Row := TDBG(DBGrid1).Row;
      Col := TDBG(DBGrid1).Col;
      BillPickList.ShowAt(TDBG(DBGrid1).CellRect(Col, Row), BillId);
    end;
    Exit;
  end;

  DBGrid1.EditorMode := True;
  keybd_event(VK_MENU, MapVirtualKey(VK_MENU, 0), 0, 0);
  keybd_event(VK_DOWN, MapVirtualKey(VK_DOWN, 0), 0, 0);
  keybd_event(VK_DOWN, 0, KEYEVENTF_KEYUP, 0);
  keybd_event(VK_MENU, 0, KEYEVENTF_KEYUP, 0);
end;

procedure TPastingForm.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
const
  CtrlState: array[Boolean] of integer = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED) ;
begin
  if (Column.Field.DataType=ftBoolean) then
  begin
    DBGrid1.Canvas.FillRect(Rect);
    if Column.Field.IsNull then
      DrawFrameControl(DBGrid1.Canvas.Handle,Rect, DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_INACTIVE) {grayed}
    else
      DrawFrameControl(DBGrid1.Canvas.Handle,Rect, DFC_BUTTON, CtrlState[Column.Field.AsBoolean]); {checked or unchecked}
  end
  else if not (gdSelected in State) then
  begin
    DBGrid1.Canvas.FillRect(Rect);
    if not DM.PastingDSPaste.Value then
      DBGrid1.Canvas.Font.Color := $00B4B4B4
    else
      DBGrid1.Canvas.Font.Color := $00323232;
    DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TPastingForm.DBGrid1TitleClick(Column: TColumn);
begin
  DM.PastingDSOrderBy(Column.FieldName, not DM.PastingDSIsAscending(Column.FieldName));
end;

procedure TPastingForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FOkToAdd := False;
  FOnClose(Self);
end;

procedure TPastingForm.FormCreate(Sender: TObject);
begin
  BillPickList := TBillPickList.Create(DBGrid1, OnClickAndHideBillPickList);
end;

procedure TPastingForm.FormDestroy(Sender: TObject);
begin
  BillPickList.Free;
end;

function TPastingForm.GetFinalBalance: Real;
var
  BM: TBookmark;
  Balance: Real;
  Amount: Real;
  _sign: ShortInt;
begin
  Balance := FRunningBalance;
  DM.PastingDS.DisableControls;
  BM := DM.PastingDS.GetBookmark;

  DM.PastingDS.First;
  while not DM.PastingDS.Eof do
  begin
    if DM.PastingDS.FieldByName('Paste').AsBoolean then
    begin
      Amount := DM.PastingDS.FieldByName('Amount').AsFloat;
      _sign := Sign(DM.PastingDS.FieldByName('Type').AsInteger);
      Balance := Balance + _sign * Amount;
    end;
    DM.PastingDS.Next;
  end;

  DM.PastingDS.GotoBookmark(BM);
  DM.PastingDS.FreeBookmark(BM);
  DM.PastingDS.EnableControls;

  Result := Balance;
end;

function TPastingForm.InsertData(aDate: TDate; Description: string; Amount: real): boolean;
var
  _type: Integer;
begin
  Result := True;
  if Amount < 0  then
    _type := EXPENSES
  else
    _type := SALARY;  //Salary
  Amount := Abs(Amount);
  try
    DM.PastingDS.Insert;
    DM.PastingDS.FieldByName('Type').AsInteger := _type;
    DM.PastingDS.FieldByName('Date').AsDateTime := aDate;
    DM.PastingDS.FieldByName('Description').AsString := Description;
    DM.PastingDS.FieldByName('Amount').AsCurrency := Amount;
    DM.PastingDS.Post;
  Except
    Result := False;
  end;
end;

procedure TPastingForm.OnClickAndHideBillPickList(Sender: TObject);
begin
  DM.PastingDS.Edit;
  DM.PastingDSLinked_Bill.Value := BillPickList.PickedBillId;
end;

procedure TPastingForm.ProccessClipBoard;
var
  Memo: TMemo;
  r: Boolean;
begin
  Memo := TMemo.Create(Self);
  Memo.Visible := False;
  Memo.WordWrap := False;
  Memo.Parent := Self;
  try
    Memo.PasteFromClipboard;
    DM.PastingDS.EmptyDataSet;
    r := ProcessContent(Memo.Lines);
    Button3.Enabled := r;
    if not r then
    begin
      ShowMessage('Invalid clipboard content.'#10#13'Copy and try again.');
      DM.PastingDS.EmptyDataSet;
    end;
  finally
    Memo.Free;
  end;
end;

function TPastingForm.ProcessContent(StringLines: TStrings): Boolean;
var
  StringLine, StringColumn, Description: string;
  EndIndex, StartIndex, Len, i: Integer;
  Date: TDateTime;
  Amount: Double;
  DateFound, DescriptionFound, AmountFound: Boolean;
  procedure ResetFlags;
  begin
    DateFound := False;
    DescriptionFound := False;
    AmountFound := False;
  end;
begin
  Result := False;
  ResetFlags;
  for i := StringLines.Count - 1 downto 0 do
  begin
    StringLine := StringLines[i];
    Len := Length(StringLine);
    EndIndex := 1;
    while EndIndex < Len do
    begin
      if StringLine[EndIndex] <> TAB then // found 1st character
      begin
        StartIndex := EndIndex;
        repeat
          Inc(EndIndex);
        until (EndIndex = Len + 1) or (StringLine[EndIndex] = TAB);
        StringColumn := Copy(StringLine, StartIndex, EndIndex - StartIndex);
        if _TryStrToFloat(StringColumn, Amount) then
        begin
          if AmountFound then
            Exit;
          AmountFound := True;
        end
        else if _TryStrToDate(StringColumn, Date) then
        begin
          if DateFound then
            Exit;
          DateFound := True;
        end
        else
        begin
          if DescriptionFound then
            Exit;
          DescriptionFound := True;
          Description := StringColumn;
        end;
      end;
      Inc(EndIndex);
    end;
    if DateFound and DescriptionFound and AmountFound then
    begin
      if not InsertData(Date, Description, Amount) then
        Exit;
    end
    else
      Exit;
    ResetFlags;
  end;
  Result := True;
end;

procedure TPastingForm.SetAccountName(aName: string);
begin
  Caption := 'Pasting from spreadsheet to account '+ aName;
end;

procedure TPastingForm.SetRunningBalance(aBalance: Real);
begin
  FRunningBalance := aBalance;
  Edit1.Text := FloatToStrF(aBalance, ffFixed, 15, 2);
end;

end.
