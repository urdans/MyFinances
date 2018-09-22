unit BatchProcessUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBGrids, DBClient, DataModuleUnit, DBCtrls, DB, Mask, ExtCtrls, Grids;

type
  TBatchProcessForm = class(TForm)
    chkType: TCheckBox;
    chkDescription: TCheckBox;
    chkTargetAcc: TCheckBox;
    chkBill: TCheckBox;
    chkNotes: TCheckBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    cbbType: TDBComboBox;
    edtDescription: TDBEdit;
    edtNotes: TDBEdit;
    cbbTargetAcc: TDBLookupComboBox;
    cbbBill: TDBLookupComboBox;
    chkInclude: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure cbbTypeChange(Sender: TObject);
  private
    { Private declarations }
    PastingGrid: TDBGrid;
  public
    { Public declarations }
    constructor Create(aOwner: TComponent; Grid: TDBGrid); reintroduce;
  end;

var
  BatchProcessForm: TBatchProcessForm;

implementation

{$R *.dfm}


procedure TBatchProcessForm.cbbTypeChange(Sender: TObject);
begin
  if cbbType.ItemIndex = 5 then //Payment
  begin
    chkTargetAcc.Checked := False;
    chkBill.Checked := True;
  end
  else if cbbType.ItemIndex = 7 then //Outgoing transfer
  begin
    chkTargetAcc.Checked := True;
    chkBill.Checked := False;
  end
  else
  begin
    chkTargetAcc.Checked := False;
    chkBill.Checked := False;
  end;
end;

procedure TBatchProcessForm.CheckBoxClick(Sender: TObject);
begin
  cbbType.Enabled := chkType.Checked;
  edtDescription.Enabled := chkDescription.Checked;
  cbbTargetAcc.Enabled := chkTargetAcc.Checked;
  cbbBill.Enabled := chkBill.Checked;
  edtNotes.Enabled := chkNotes.Checked;
end;

constructor TBatchProcessForm.Create(aOwner: TComponent; Grid: TDBGrid);
begin
  inherited Create(aOwner);
  PastingGrid := Grid;
end;

procedure TBatchProcessForm.FormCreate(Sender: TObject);
var i: Integer;
begin
  if DM.PastingDSType.Value = BILLPAYMENT then
    cbbType.ItemIndex := 5
  else if DM.PastingDSType.Value = OUTTRANSFER then
    cbbType.ItemIndex := 7;
  cbbTypeChange(nil);
  CheckBoxClick(nil);
  for i := 0 to PastingGrid.Columns.Count - 1 do
    if PastingGrid.Columns.Items[i].FieldName = 'Type' then
    begin
      cbbType.Items.AddStrings(PastingGrid.Columns.Items[i].PickList);
      Break;
    end;
end;

end.
