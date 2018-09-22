unit BillPickList;

interface

uses
  Grids, Generics.Collections, Generics.Defaults, UxTheme, Themes, Classes, StdCtrls, Windows, Graphics, Controls,
  SysUtils, Forms, DBGrids, DB;



type
  TLocation = (lAtTop, lAtBottom);
  TSGrid = class (TStringGrid)
  private
    CPaint: procedure of object;
  protected
    procedure Paint; override;
  end;

  TBill = record
  public
    Picked: Boolean;
    PendingAmount: string;
    BillAmount: string;
    DueDate: TDate;
    Description: string;
    BillId: Integer;
    function Make(const aPicked: Boolean; const aPendingAmount, aBillAmount: string;
      const aDueDate: TDate; const aDescription: string; const aBillId: Integer): TBill;
    procedure SetPicked;
    function Text: string;
  end;

  TBillPickList = class
  private
    Grid: TSGrid;
    BillList: TList<TBill>; //the list that contains the bills
    PickedBillIds: TList<Integer>; //the list that contains the picked bills' Ids.
    FOnClickAndHideEvent: TNotifyEvent; // will be called when the Grid is hidden after the user picks a bill.
    SmallRect: TRect;
    FPickedBillId: Integer;
    Location: TLocation;
    procedure CustomPaint;
    procedure DoPickABill;
    procedure FillBillList;
    procedure GridExit(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure GridMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OPENBILLSAfterRefreshListener(Sender: TObject);
    procedure PopulateBillList;
    procedure PopulateGridFromBillList;
    procedure RestorePickedBills;
    procedure SavePickedBillIds;
    procedure SortBills;
  public
    property PickedBillId: Integer read FPickedBillId;
    constructor Create(AOwner: TDBGrid; OnClickAndHideEvent: TNotifyEvent);
    destructor Destroy; override;
    procedure Hide;
    procedure ShowAt(const NearRect: TRect; const BillId: Integer = -1);
  end;

implementation

uses
  DataModuleUnit;

type
  TBillComparer = class(TComparer<TBill>);

{ TBill }
{$REGION 'TBill'}
function TBill.Make(const aPicked: Boolean; const aPendingAmount, aBillAmount: string;
  const aDueDate: TDate; const aDescription: string; const aBillId: Integer): TBill;
begin
  Picked := aPicked;
  PendingAmount := aPendingAmount;
  BillAmount := aBillAmount;
  DueDate := aDueDate;
  Description := aDescription;
  BillId := aBillId;
  Result := Self;
end;

procedure TBill.SetPicked;
begin
  Picked := True;
end;

function TBill.Text: string;
const
  CR = #13#10;
  BillPicked = '1';
  BillNotPicked = '0';
begin
  if Picked then
    Result := BillPicked
  else
    Result := BillNotPicked;
  Result := Result + CR + PendingAmount + CR + BillAmount + CR + DateToStr(DueDate) + CR + Description;
end;
{$ENDREGION}

{ TBillPickList }
{$REGION 'TBillPickList'}
constructor TBillPickList.Create(AOwner: TDBGrid; OnClickAndHideEvent: TNotifyEvent);
begin
  inherited Create;
  FPickedBillId := -1;
  BillList := TList<TBill>.Create;
  PickedBillIds := TList<Integer>.Create;
  FOnClickAndHideEvent := OnClickAndHideEvent;
  Grid := TSGrid.Create(nil);
  Grid.Visible := False;
  Grid.Name := 'Grid';
  Grid.Parent := AOwner;
  Grid.Font.Name := AOwner.Font.Name;
  Grid.Font.Size := AOwner.Font.Size;
  Grid.BorderStyle := bsNone;
  Grid.Left := 150;
  Grid.Top := 97;
  Grid.Width := 473;
  Grid.Height := 88;
  Grid.DefaultRowHeight := 17;
  Grid.DefaultDrawing := False;
  Grid.FixedCols := 0;
  Grid.Options := [goFixedVertLine, goFixedHorzLine, goColSizing, goRowSelect, goFixedHotTrack];
  Grid.ScrollBars := ssVertical;
  Grid.TabOrder := 5;
  Grid.ColWidths[0] := 21;
  Grid.ColWidths[1] := 64;
  Grid.ColWidths[2] := 64;
  Grid.ColWidths[3] := 68;
  Grid.ColWidths[4] := 260;
  Grid.OnDrawCell := GridDrawCell;
  Grid.OnExit := GridExit;
  Grid.OnKeyPress := GridKeyPress;
  Grid.OnMouseUp := GridMouseUp;
  Grid.CPaint := CustomPaint;
  Grid.Cells[1,0]:='Pending';
  Grid.Cells[2,0]:='Bill Amnt';
  Grid.Cells[3,0]:='Date due';
  Grid.Cells[4,0]:='Description';
  DM.OPENBILLSRegisterRefreshListener(OPENBILLSAfterRefreshListener);
end;

procedure TBillPickList.CustomPaint;
{Traces a border line around the Grid and the Cell as suggesting the grid belongs to that cell }
var p0, p1, p2, p3, p4, p5, p6, p7: TPoint; ControlCanvas: TCanvas;
  smrWidth, smrHeight: Integer;
begin
  smrWidth := SmallRect.Right - SmallRect.Left;
  smrHeight := SmallRect.Bottom - SmallRect.Top;
  p0 := Point(Grid.Left - 1, Grid.Top - 1);
  if Location = lAtBottom then
  begin
    p1 := Point(p0.X + Grid.Width - smrWidth, p0.Y);
    p2 := Point(p1.X, p1.Y - smrHeight);
    p3 := Point(p2.X + smrWidth + 1, p2.Y);
    p4 := Point(p3.X, p3.Y + smrHeight + Grid.Height + 1);
    p5 := Point(p0.X, p4.Y);
//    p1 := Point(p0.X + Grid.Width - (SmallRect.Right - SmallRect.Left), p0.Y);
//    p2 := Point(p1.X, p0.Y - (SmallRect.Bottom - SmallRect.Top));
//    p3 := Point(p2.X + (SmallRect.Right - SmallRect.Left) + 1, p2.y);
//    p4 := Point(p3.X, p3.Y + (SmallRect.Bottom - SmallRect.Top));
//    p5 := Point(p0.X + Grid.Width + 1, p0.Y);
//    p6 := Point(p5.X, p5.Y + Grid.Height + 1);
//    p7 := Point(p0.X, p6.Y);
  end
  else
  begin
    p1 := Point(p0.X + Grid.Width + 1, p0.Y);
    p2 := Point(p1.X, p1.Y + Grid.Height + smrHeight + 1);
    p3 := Point(p2.X - smrWidth, p2.y);
    p4 := Point(p3.X, p3.Y - smrHeight);
    p5 := Point(p0.X, p4.y);
  end;

  ControlCanvas := (Grid.Parent as TDBGrid).canvas;
  ControlCanvas.Pen.Style := psSolid;
  ControlCanvas.Pen.Color := clWindowFrame;
  ControlCanvas.MoveTo(p0.X, p0.Y);
  ControlCanvas.LineTo(p1.X, p1.y);
  ControlCanvas.LineTo(p2.X, p2.y);
  ControlCanvas.LineTo(p3.X, p3.y);
  ControlCanvas.LineTo(p4.X, p4.y);
  ControlCanvas.LineTo(p5.X, p5.y);
//  ControlCanvas.LineTo(p6.X, p6.y);
//  ControlCanvas.LineTo(p7.X, p7.y);
  ControlCanvas.LineTo(p0.X, p0.y);
end;

destructor TBillPickList.Destroy;
begin
  DM.OPENBILLSUnRegisterRefreshListener(OPENBILLSAfterRefreshListener);
  BillList.Free;
  PickedBillIds.Free;
  Grid.Free;
  inherited;
end;

procedure TBillPickList.DoPickABill;
begin
  FPickedBillId := BillList[Grid.Row - 1].BillId;
  if Assigned(FOnClickAndHideEvent) then
    FOnClickAndHideEvent(Self);
end;

procedure TBillPickList.FillBillList;
{Fills the list of bills from the table OPENBILLS}
const NotPicked = False;
var Bill: TBill; FilteredState: Boolean;
begin
  BillList.Clear;
  FilteredState := DM.OPENBILLS.Filtered;
  DM.OPENBILLS.Filtered := True;
  DM.OPENBILLS.First;
  while not DM.OPENBILLS.Eof do
  begin
    BillList.Add(Bill.Make(NotPicked, DM.OPENBILLSPendingAmount.DisplayText, DM.OPENBILLSPayment_Due.DisplayText,
      DM.OPENBILLSDue_Date.Value, DM.OPENBILLSName.AsString, DM.OPENBILLSId.Value));
    DM.OPENBILLS.Next;
  end;
  DM.OPENBILLS.Filtered := FilteredState;
end;

procedure TBillPickList.GridExit(Sender: TObject);
begin
  Hide;
end;

procedure TBillPickList.GridKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Hide;
    DoPickABill;
  end
  else if Key =#27 then
    Hide;
end;

procedure TBillPickList.GridMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Hide;
  DoPickABill;
end;

procedure TBillPickList.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Txt, flag: string;
  Frmt: TTextFormat;
  hlcolor: Cardinal;
begin
  //paints the themed background
  GetThemeColor(ThemeServices.Theme[teListView], LVP_LISTITEM, LIS_NORMAL, TMT_FILLCOLOR, hlcolor);
  Grid.Canvas.Brush.Color := hlcolor;
  Grid.Canvas.FillRect(Rect);
  Grid.Canvas.Brush.Style :=  bsClear;
  //for the selected items the background color is blended with the themed selection color
  if gdSelected in State then
    DrawThemeBackground(ThemeServices.Theme[teMenu], Grid.Canvas.Handle, MENU_POPUPITEM, MPI_HOT,
      Rect, {$IFNDEF CLR}@{$ENDIF}Rect);
  //formatting the fixed rows to be centered (horz. and vert.)
  if gdFixed in State then
  begin
    Frmt := [tfCenter, tfVerticalCenter, tfSingleLine];
    Grid.Canvas.Font.Style := [fsBold];
    Grid.Canvas.Font.Color := clWindowText;
  end
  else
  begin
  //the rest of the row, the format is hard coded according to the data type
    Grid.Canvas.Font.Style := [];
    Grid.Canvas.Font.Color := $00323232;
    if ACol in [1, 2, 3] then
      Frmt := [tfRight, tfBottom, tfSingleLine] //numbers and dates at right
    else
      Frmt := [tfLeft, tfBottom, tfSingleLine]; //texts at lefts
  end;
  //getting the text to be displayed
  Txt := Grid.Cells[ACol, ARow];
  Grid.Canvas.Font.Size := Grid.Font.Size;
  if (ACol = 0)and(not(gdFixed in State)) then
  //the fist column is the picking flag
  begin
    if Txt = '1' then  //the flag is raised so we render it
    begin
      Grid.Canvas.Font.Name := 'Wingdings';
      flag := ''; //this is a check mark
      Grid.Canvas.TextRect(Rect, flag, [tfCenter, tfBottom, tfSingleLine]);
    end;
  end
  else //we render the text using the preselected color and brush
  begin
    InflateRect(Rect, -2, 0);
    Grid.Canvas.Font.Name := Grid.Font.Name;
    Grid.Canvas.TextRect(Rect, Txt, Frmt);
  end;
end;

procedure TBillPickList.Hide;
begin
  Grid.Hide;
  Grid.Parent.Invalidate;
end;

procedure TBillPickList.OPENBILLSAfterRefreshListener(Sender: TObject);
begin
  PopulateBillList;
end;

procedure TBillPickList.PopulateBillList;
begin
  SavePickedBillIds;
  FillBillList;
  RestorePickedBills;
  SortBills;
  PopulateGridFromBillList;
end;

procedure TBillPickList.PopulateGridFromBillList;
{Prepares the Grid, by copying the content of BillList into the Grid and adjusting the Grid height accordingly}
const
  ShownRowCount = 7;
var
  i:Integer;
begin
  Grid.RowCount := BillList.Count + 1; //includes the title row
  if Grid.RowCount > ShownRowCount then
    //adjusting the grid height to show ShownRowCount rows
    Grid.ClientHeight := (Grid.DefaultRowHeight + Grid.GridLineWidth) * ShownRowCount + Grid.GridLineWidth
  else
    //adjusting the grid height to match Grid.RowCount rows
    Grid.ClientHeight := (Grid.DefaultRowHeight + Grid.GridLineWidth) * Grid.RowCount + Grid.GridLineWidth;
   for i := 0 to BillList.Count - 1 do
     Grid.Rows[i+1].Text := TBill(BillList[i]).Text;
end;

procedure TBillPickList.RestorePickedBills;
var  BillId, i: Integer; Bill: TBill;
begin
  for BillId in PickedBillIds do
  begin
    for i := 0 to BillList.Count - 1 do
    begin
      if BillList[i].BillId = BillId then
      begin
        Bill := BillList[i];
        Bill.SetPicked;
        BillList[i] := Bill;
      end;
    end;
  end;
end;

procedure TBillPickList.SavePickedBillIds;
var {Bill: TBill;} BM: TBookMark;
begin
  PickedBillIds.Clear;
  BM := DM.PastingDS.GetBookmark;
  DM.PastingDS.DisableControls;
  try
    DM.PastingDS.First;
    while not DM.PastingDS.Eof do
    begin
      if not DM.PastingDSLinked_Bill.IsNull then
        PickedBillIds.Add(DM.PastingDSLinked_Bill.Value);
      DM.PastingDS.Next;
    end;
    DM.PastingDS.GotoBookmark(BM);
  finally
    DM.PastingDS.FreeBookmark(BM);
    DM.PastingDS.EnableControls;
  end;
end;

procedure TBillPickList.ShowAt(const NearRect: TRect; const BillId: Integer = -1);
{Show the bill pick list grid at bottom side of the small NearRect rectangle with the BillId's row selected}
var i: integer;
begin
  PopulateBillList;
  //Locating the grid
  if (NearRect.Bottom + Grid.Height)>Grid.Parent.ClientHeight then
    Location := lAtTop
  else
    Location := lAtBottom;
  SmallRect := NearRect;
  if Location = lAtBottom then
    Grid.Top := NearRect.Bottom
  else
    Grid.Top := NearRect.Top - Grid.Height;
  Grid.Left := NearRect.Right - Grid.Width;
{Original code
  SmallRect := NearRect;
  Grid.Top := NearRect.Bottom;
  Grid.Left := NearRect.Right - Grid.Width;}

  for i := 0 to BillList.Count-1 do
    if BillList[i].BillId = BillId then
    begin
      Grid.Row := i + 1;
      break;
    end;
  Grid.Visible := True;
  Grid.SetFocus;
end;

procedure TBillPickList.SortBills;
begin
  BillList.Sort(TBillComparer.Construct(
    function (const L, R: TBill): integer
    begin
      if L.Picked = R.Picked then
      begin
        if L.DueDate > R.DueDate then
          Result := 1
        else if L.DueDate < R.DueDate then
          Result := -1
        else
          Result := 0;
      end
      else
      begin
        if L.Picked and not R.Picked then
          Result := 1
        else
          Result := -1;
      end;
    end
    ));
end;
{$ENDREGION}

{ TSGrid }
{$REGION 'TSGrid'}
procedure TSGrid.Paint;
begin
  inherited;
  if Assigned(CPaint) then
    CPaint;
end;
{$ENDREGION}
end.
