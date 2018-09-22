program MyFinances;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  DataModuleUnit in 'DataModuleUnit.pas' {DM: TDataModule},
  PastingUnit in 'PastingUnit.pas' {PastingForm},
  BatchProcessUnit in 'BatchProcessUnit.pas' {BatchProcessForm},
  BillPickList in 'BillPickList.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
