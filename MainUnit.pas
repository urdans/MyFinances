unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ComCtrls, ToolWin, StdCtrls, DBCtrls, ExtCtrls, Buttons, Menus, DBCGrids, DBGridEasy;

type
  TDBG = class(TDBGrid);

type
  THackGrid = class(TCustomDBGrid);
  THackDataLink = class(TGridDataLink);
  TMainForm = class(TForm)
    pgcMain: TPageControl;
    tsAccounts: TTabSheet;
    ToolBar1: TToolBar;
    StatusBar1: TStatusBar;
    Accounts_DS: TDataSource;
    dbgrdAccounts: TDBGridEasy;
    tsBills: TTabSheet;
    Bills_DS: TDataSource;
    StatusBar3: TStatusBar;
    dbgrdBills: TDBGridEasy;
    FULLCCS_DS: TDataSource;
    tsMovements: TTabSheet;
    dbgrdMovements: TDBGridEasy;
    StatusBar5: TStatusBar;
    Movements_DS: TDataSource;
    Panel2: TPanel;
    Label2: TLabel;
    cbbBills: TComboBox;
    Panel3: TPanel;
    Label3: TLabel;
    cbbMovements: TComboBox;
    Panel4: TPanel;
    btnPasteFromSS: TButton;
    btnCreditCardBillers: TSpeedButton;
    btnOtherBillers: TSpeedButton;
    btnAllBillers: TSpeedButton;
    tsFULLCCS: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    cbbFULLCCS: TComboBox;
    dbgrdCCStatements: TDBGridEasy;
    StatusBar2: TStatusBar;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    DBNavigator3: TDBNavigator;
    DBNavigator4: TDBNavigator;
    Summary: TTabSheet;
    pnlMostTop: TPanel;
    DBNavigator5: TDBNavigator;
    Summary_DS: TDataSource;
    dbgrdSummary: TDBGridEasy;
    pmSummary: TPopupMenu;
    Viewbill1: TMenuItem;
    Gotomovement1: TMenuItem;
    N1: TMenuItem;
    Refresh1: TMenuItem;
    dbgrdAccountPayments: TDBGridEasy;
    dbgrdAccountTotals: TDBGridEasy;
    dbgrdAccountBalances: TDBGridEasy;
    ACCOUNTPAYMENTS_DS: TDataSource;
    ACCOUNTTOTALS_DS: TDataSource;
    ACCOUNTBALANCES_DS: TDataSource;
    DateTimePicker1: TDateTimePicker;
    Label4: TLabel;
    Splitter1: TSplitter;
    pnlMostBottom: TPanel;
    splLeft: TSplitter;
    Splitter3: TSplitter;
    pnlLeftBottom: TPanel;
    pnlAPTitle: TPanel;
    pnlRightBottom: TPanel;
    pnlRightMostBottom: TPanel;
    Panel5: TPanel;
    pnlMiddleBottom: TPanel;
    Panel6: TPanel;
    pnlTop: TPanel;
    Panel7: TPanel;
    StatusBar4: TStatusBar;
    Button1: TButton;
    Edit1: TEdit;
    procedure TabSheetShow(Sender: TObject);
    procedure ComboBoxSelect(Sender: TObject);
    procedure DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure btnPasteFromSSClick(Sender: TObject);
    procedure btnBillersClick(Sender: TObject);
    procedure DBNavigator4Click(Sender: TObject; Button: TNavigateBtn);
    procedure DBNavigator2Click(Sender: TObject; Button: TNavigateBtn);
    procedure DBNavigator3Click(Sender: TObject; Button: TNavigateBtn);
    procedure dbgrdMovementsCellClick(Column: TColumn);
    procedure pmSummaryGotoMovementClick(Sender: TObject);
    procedure pmSummaryPopup(Sender: TObject);
    procedure pmSummaryRefreshClick(Sender: TObject);
    procedure pmSummaryViewbillClick(Sender: TObject);
    procedure SummaryShow(Sender: TObject);
    procedure dbgrdSummaryTitleClick(Column: TColumn);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure dbgrdSummaryCellClick(Column: TColumn);
    procedure dbgrdSummaryKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure OnPastingFormClose(Sender: TObject);
    procedure UpdateStatusBar;
//    procedure SUMMARYAfterScroll(DataSet: TDataSet);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  DataModuleUnit, PastingUnit, BatchProcessUnit;

{$R *.dfm}

const
  DAYSGREEN = 6;
  //DAYSYELLOW = 3..5;
  DAYSRED = 2;


procedure TMainForm.btnBillersClick(Sender: TObject);
begin
  TabSheetShow(tsBills);
end;

procedure TMainForm.btnPasteFromSSClick(Sender: TObject);
begin
  if PastingForm = nil then
    PastingForm := TPastingForm.Create(Self, OnPastingFormClose);
  cbbMovements.Enabled := False;
  PastingForm.SetRunningBalance(DM.GetRunningBalance);
  PastingForm.SetAccountName(cbbMovements.Text);
  PastingForm.Show;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  THackGrid(dbgrdMovements).Scroll(StrToInt(Edit1.Text));
end;

procedure TMainForm.ComboBoxSelect(Sender: TObject);
var
  id: Integer;
  ComboBox: TComboBox;
  QryDs: TQryDs;
  grid: TDBGridEasy;
begin
  if Sender = cbbBills then
  begin
    QryDs := DM.BILLS;
    grid := dbgrdBills;
  end
  else if Sender = cbbMovements then
  begin
    QryDs := DM.MOVEMENTS;
    grid := dbgrdMovements;
  end
  else if Sender = cbbFULLCCS then
  begin
    QryDs := DM.FULLCCS;
    grid := dbgrdCCStatements;
  end
  else
    Exit;

  ComboBox := Sender as TComboBox;
  id := Integer(ComboBox.Items.Objects[ComboBox.ItemIndex]);

  if QryDs.ParamByName('RefId').AsInteger = id then
    Exit;

//This hack is due to an error in the TDBGrid control
  THackGrid(grid).ScrollBars := ssNone;
  QryDs.Close;
  THackGrid(grid).ScrollBars := ssHorizontal;
  QryDs.ParamByName('RefId').AsInteger := id;
  QryDs.Open;
end;

procedure TMainForm.DateTimePicker1Change(Sender: TObject);
begin
  DM.SUMMARYShowFromDate := DateTimePicker1.Date;
  dbgrdSummary.SelectedRows.Clear;
end;

procedure TMainForm.dbgrdMovementsCellClick(Column: TColumn);
var RowBefore, DeltaRow: Integer;
  grid:THackGrid;
begin
  if (Column.Field.DataType = ftBoolean) then
  begin //toggle True and False
    if not Column.Field.ReadOnly then
    begin
      grid:=THackGrid(dbgrdMovements);
      RowBefore := grid.Row;
      Column.Grid.DataSource.DataSet.Edit;
      Column.Field.Value:= not Column.Field.AsBoolean;
//    try
      Column.Grid.DataSource.DataSet.Post;
//    except
//    end;
//      RowAfter := grid.Row;
      DeltaRow := RowBefore - grid.Row;
      if DeltaRow > 0 then
      begin
        DM.MOVEMENTS.DisableControls;
        DM.MOVEMENTS.MoveBy(-DeltaRow);
        DM.MOVEMENTS.MoveBy(DeltaRow);
        DM.MOVEMENTS.EnableControls;
      end;
    end;
  end
end;

procedure TMainForm.dbgrdSummaryCellClick(Column: TColumn);
begin
  UpdateStatusBar;
end;

procedure TMainForm.dbgrdSummaryKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN) then
    UpdateStatusBar;
end;

procedure TMainForm.dbgrdSummaryTitleClick(Column: TColumn);
var
  sb, s: string;
begin
  sb := Column.FieldName;
  s := DM.SUMMARY.SortedFields;
  if Pos(sb, s) = 0 then //first time click
  begin
    DM.SUMMARY.SortedFields := Column.FieldName + ', ' + DM.SUMMARYBILLERNAME.FieldName;
    DM.SUMMARY.SortType := _TSortType.stAscending;
  end
  else
  begin
    if DM.SUMMARY.SortType = _TSortType.stAscending then
      DM.SUMMARY.SortType := _TSortType.stDescending
    else
      DM.SUMMARY.SortType := _TSortType.stAscending;
  end;
end;

procedure TMainForm.DBNavigator2Click(Sender: TObject; Button: TNavigateBtn);
begin
  if Button = nbInsert then
  begin
    dbgrdBills.SetFocus;
    dbgrdBills.SelectedField := DM.BILLSC_F_Date;
  end;
end;

procedure TMainForm.DBNavigator3Click(Sender: TObject; Button: TNavigateBtn);
begin
  if Button = nbInsert then
  begin
    dbgrdAccounts.SetFocus;
    dbgrdAccounts.SelectedField := DM.ACCOUNTSName;
  end;
end;

procedure TMainForm.DBNavigator4Click(Sender: TObject; Button: TNavigateBtn);
begin
  if Button = nbInsert then
  begin
    dbgrdCCStatements.SetFocus;
    dbgrdCCStatements.SelectedField := DM.FULLCCSC_F_Date;
  end;
end;

procedure TMainForm.DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
var
  DBGrid: TDBGrid;
begin
  DBGrid := Sender as TDBGrid;
  if Sender = dbgrdAccounts then
  begin
    if not Column.Field.DataSet.FieldByName('Active').AsBoolean then
      DBGrid.Canvas.Font.Color := $00B4B4B4; //light gray
  end
  else if Sender = dbgrdMovements then
  begin
    if Column.Field = DM.MOVEMENTSStatus then
    begin
      if (DM.MOVEMENTSStatus.Value = POSTED) and (not DM.MOVEMENTSChecked.Value) then
        DBGrid.Canvas.Brush.Color := clWebGold
      else if DM.MOVEMENTSStatus.Value = PLANNED then
        DBGrid.Canvas.Brush.Color := clWebChocolate;
    end;
    if DM.MOVEMENTSStatus.Value = CANCELLED then
      DBGrid.Canvas.Font.Color := $00B4B4B4; //light gray
  end
  else if Sender = dbgrdSummary then
  begin
    if Column.Field = DM.SUMMARYDAYSLEFT then
    begin
      if DM.SUMMARYBALANCE.Value > 0 then
      begin
        DBGrid.Canvas.Font.Style := [fsBold];
        if (DM.SUMMARYDAYSLEFT.DisplayText = 'DUE') or (DM.SUMMARYDAYSLEFT.Value <= DAYSRED) then
        begin
          DBGrid.Canvas.Font.Color := clHighlightText;
          DBGrid.Canvas.Brush.Color := clRed;
        end
        else if DM.SUMMARYDAYSLEFT.Value <= DAYSGREEN then
        begin
          DBGrid.Canvas.Font.Color := clHighlightText;
          DBGrid.Canvas.Brush.Color := clWebOrange;
        end
        else
        begin
          DBGrid.Canvas.Font.Color := clHighlightText;
          DBGrid.Canvas.Brush.Color := clWebGreen;
        end
      end;
    end
    else if Column.Field = DM.SUMMARYMOVSTATUS then
    begin
      if DM.SUMMARYMOVSTATUS.Value = PLANNED then
      begin
        DBGrid.Canvas.Font.Color := clHighlightText;
        DBGrid.Canvas.Brush.Color := clWebChocolate;//clWebOrangeRed;
      end
      else if DM.SUMMARYMOVSTATUS.Value = POSTED then
      begin
        if not DM.SUMMARYMOVCHECKED.Value then
        begin
          DBGrid.Canvas.Font.Color := clHighlightText;
          DBGrid.Canvas.Brush.Color := clWebGold;
        end;
      end;
    end
    else if Column.Field = DM.SUMMARYBALANCE then
    begin
      if DM.SUMMARYBALANCE.Value > 0 then
        DBGrid.Canvas.Font.Style := [fsBold]
      else
        DBGrid.Canvas.Font.Color := $00B4B4B4; //light gray
    end;
  end;
  DBGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
//  DataModuleUnit.ApplicationPath := ExtractFilePath(Application.ExeName);
end;

procedure TMainForm.OnPastingFormClose(Sender: TObject);
begin
  //perfoms actions when the pasting form closes;
  if PastingForm.OkToAdd then
  begin
    DM.MOVEMENTSAddFromPastingDS;
    if DM.PastingDS.RecordCount <> 0 then
      Exit;
  end;
  PastingForm.Free;
  PastingForm := nil;
  cbbMovements.Enabled := True;
end;

procedure TMainForm.pmSummaryGotoMovementClick(Sender: TObject);
var
  i, indx: Integer;
begin
  TabSheetShow(tsMovements);
  indx := -1;
  for i := 0 to cbbMovements.Items.Count - 1 do
  begin
    if Cardinal(cbbMovements.Items.Objects[i]) = DM.SUMMARYMOVACCOUNTID.Value then
    begin
      indx := i;
      Break;
    end;
  end;
  cbbMovements.ItemIndex := indx;
  ComboBoxSelect(cbbMovements);
  DM.MOVEMENTS.Locate('Id',DM.SUMMARYMOVID.Value,[]);
//  THackGrid(dbgrdMovements).ScrollBars
  pgcMain.ActivePage := tsMovements;
end;

procedure TMainForm.pmSummaryPopup(Sender: TObject);
begin
  pmSummary.Items[0].Enabled := not DM.SUMMARYBILLID.IsNull;
  pmSummary.Items[1].Enabled := not DM.SUMMARYMOVID.IsNull;
  pmSummary.Items[2].Enabled := DM.SUMMARY.RecordCount>0;
end;

procedure TMainForm.pmSummaryRefreshClick(Sender: TObject);
begin
//
end;

procedure TMainForm.pmSummaryViewbillClick(Sender: TObject);
var
  i, indx: Integer;
begin
  btnAllBillers.Down := True;
  TabSheetShow(tsBills);
  indx := -1;
  for i := 0 to cbbBills.Items.Count - 1 do
  begin
    if Cardinal(cbbBills.Items.Objects[i]) = DM.SUMMARYBILLERID.Value then
    begin
      indx := i;
      Break;
    end;
  end;
  cbbBills.ItemIndex := indx;
  ComboBoxSelect(cbbBills);
  DM.BILLS.Locate('Id',DM.SUMMARYBILLID.Value,[]);
  pgcMain.ActivePage := tsBills;
end;

procedure TMainForm.SummaryShow(Sender: TObject);
begin
  dbgrdSummary.SetFocus;
  DateTimePicker1.Date := DM.SUMMARYShowFromDate;
  DM.SUMMARY.Refresh;
  DM.ACCOUNTBALANCES.Refresh;
  DM.ACCOUNTTOTALS.Refresh;
  DM.ACCOUNTPAYMENTS.Refresh;
end;

procedure TMainForm.TabSheetShow(Sender: TObject);
var
  id: Cardinal;
  CurrentId: Cardinal;
  i: Integer;
  ComboBox: TComboBox;
  Query: string;
  WhereCl: string;
begin
  if Sender = tsBills then
  begin
    ComboBox := cbbBills;
    if btnAllBillers.Down then
      WhereCl :='TYPE=3 or TYPE=4'
    else if btnCreditCardBillers.Down then
      WhereCl :='TYPE=3'
    else
      WhereCl :='TYPE=4';
    Query := 'SELECT Id, Name FROM ACCOUNTS WHERE (' + WhereCl + ') and Active='#39'Y'#39+
             ' ORDER BY Type, Name';
  end
  else if Sender = tsMovements then
  begin
    ComboBox := cbbMovements;
    Query := 'SELECT Id, Name FROM ACCOUNTS WHERE (TYPE=1 OR TYPE=2 OR TYPE=3)'#10#13 +
             'AND Active='#39'Y'#39' ORDER BY Type, Name';
  end
  else if Sender = tsFULLCCS then
  begin
    ComboBox := cbbFULLCCS;
    Query := 'SELECT Id, Name FROM ACCOUNTS WHERE (TYPE=3) and Active='#39'Y'#39+
             ' ORDER BY Name';
  end
  else
    Exit;

  CurrentId := High(Cardinal);
  if ComboBox.ItemIndex <> -1 then
    CurrentId := Cardinal(ComboBox.Items.Objects[ComboBox.ItemIndex]);
  ComboBox.Clear;

  DM.ZQuery1.SQL.Clear;
  DM.ZQuery1.SQL.Add(Query);
  DM.ZQuery1.Open;

  while not DM.ZQuery1.Eof do
  begin
    ComboBox.Items.Add(DM.ZQuery1.FieldByName('Name').AsString);
    id := DM.ZQuery1.FieldByName('Id').AsInteger;
    ComboBox.Items.Objects[ComboBox.Items.Count - 1] := Pointer(id);
    DM.ZQuery1.Next;
  end;

  DM.ZQuery1.Close;

  for i := 0 to ComboBox.Items.Count - 1 do
  begin
    if CurrentId = Cardinal(ComboBox.Items.Objects[i]) then
    begin
      ComboBox.ItemIndex := i;
      Exit;
    end;
  end;

  if ComboBox.Items.Count = 0 then
    ComboBox.ItemIndex := -1
  else
    ComboBox.ItemIndex := 0;

  ComboBoxSelect(ComboBox);
end;

procedure TMainForm.UpdateStatusBar;
var
  T_Bill_amount, T_pay_amount, T_balance: Currency;
  i: Integer;
  BM: TBookmark;
begin
  T_Bill_amount := 0;
  T_pay_amount := 0;
  T_balance := 0;
  BM := DM.SUMMARY.GetBookmark;
  DM.SUMMARY.DisableControls;
  try
    for i := 0 to dbgrdSummary.SelectedRows.Count - 1 do
    begin
      DM.SUMMARY.GotoBookmark(dbgrdSummary.SelectedRows.Items[i]);
      T_Bill_amount := T_Bill_amount + DM.SUMMARYPAYMENTDUE.Value;
      T_pay_amount := T_pay_amount + DM.SUMMARYPAYAMOUNT.Value;
      if DM.SUMMARYBALANCE.Value > 0 then
        T_balance := T_balance + DM.SUMMARYBALANCE.Value;
    end;
  finally
    DM.SUMMARY.GotoBookmark(BM);
    DM.SUMMARY.FreeBookmark(BM);
    DM.SUMMARY.EnableControls;
    StatusBar4.Panels[0].Text := 'Total bill amount: ' + CurrToStrF(T_Bill_amount, ffCurrency, 2);
    StatusBar4.Panels[1].Text := 'Total pay amount: ' + CurrToStrF(T_pay_amount, ffCurrency, 2);
    StatusBar4.Panels[2].Text := 'Total balance: ' + CurrToStrF(T_balance, ffCurrency, 2);
  end;
end;

{$WARN GARBAGE OFF}
end.

{
TODO:
-If I make a correction on a payment amount to a past statement, the actual balance do not update.

-Highlight the rows as per its status:
  Movements: if status is checked, no color; if status is not checked, mark that field in red.
  Planned, Posted, Cancel
  -Planned red
  -Posted and checked color normal.
  -Posted but not checked yellow
  -Cancelled Ops in light gray (the whole line)

*-In Movements dbgrid, clicking in checked field should be straigforward as when using pasting.
*-Running balance in pasting form is taking its value from the very last movement, no mater if that
 movement is posted or not. If that movement is not posted, the running balance is read as zero.
 Need to correct this; value shoulb be the very last posted movement.
*-Bug: just after canceling an existing old movement, if you try to inser a new one, it looks like
 the fields are readonly and an error msg pops up.
 UPDATE: it looks like this happens when a cancelled movement is selected and you try to insert
 a new one; the fields are locked into read only mode.
}
{$WARN GARBAGE ON}
