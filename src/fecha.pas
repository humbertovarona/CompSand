Unit Fecha;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, Grids, Calendar, Spin;

Type
  TFechaForm = class(TForm)
    Calendar1: TCalendar;
    SEYear: TSpinEdit;
    SEMonth: TSpinEdit;
    BOk: TBitBtn;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    procedure SEYearChange(Sender: TObject);
    procedure BOkClick(Sender: TObject);
    procedure SEMonthChange(Sender: TObject);
    procedure Calendar1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SEMonthKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Var
  FechaForm: TFechaForm;

Implementation

{$R *.DFM}

Procedure TFechaForm.SEYearChange(Sender: TObject);

begin
  Calendar1.Year := SEYear.Value;
end;

Procedure TFechaForm.SEMonthChange(Sender: TObject);

begin
  Calendar1.Month := SEMonth.Value;
end;

Procedure TFechaForm.BOkClick(Sender: TObject);

begin
  Close
end;

Procedure TFechaForm.Calendar1Change(Sender: TObject);

Var
  Mes, Dia     : String[2];

begin
  If Length(IntToStr(Calendar1.Month)) < 2 Then
    Mes := '0' + IntToStr(Calendar1.Month)
  Else
    Mes := IntToStr(Calendar1.Month);
  If Length(IntToStr(Calendar1.Day)) < 2 Then
    Dia := '0' + IntToStr(Calendar1.Day)
  Else
    Dia := IntToStr(Calendar1.Day);

  BOk.Caption := IntToStr(Calendar1.Year)  + '/' +
                 Mes + '/' +
                 Dia;
end;

Procedure TFechaForm.FormCreate(Sender: TObject);

Var
  Mes, Dia     : String[2];

begin
  If Length(IntToStr(Calendar1.Month)) < 2 Then
    Mes := '0' + IntToStr(Calendar1.Month)
  Else
    Mes := IntToStr(Calendar1.Month);
  If Length(IntToStr(Calendar1.Day)) < 2 Then
    Dia := '0' + IntToStr(Calendar1.Day)
  Else
    Dia := IntToStr(Calendar1.Day);
  SEMonth.Value := Calendar1.Month;
  SEYear.Value := Calendar1.Year;
  BOk.Caption := IntToStr(Calendar1.Year)  + '/' +
                 Mes + '/' +
                 Dia;
end;

procedure TFechaForm.SEMonthKeyPress(Sender: TObject; var Key: Char);
begin
  key := #0;
end;

end.
