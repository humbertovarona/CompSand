unit Param;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RZNEdit, ExtCtrls, Buttons;

type
  TParamForm = class(TForm)
    Panel1: TPanel;
    Reserva: TCheckBox;
    RadioGroup1: TRadioGroup;
    Otro: TRealEdit;
    Tolerancia: TCheckBox;
    Nivel: TCheckBox;
    Panel2: TPanel;
    Label1: TLabel;
    NivelMinTeo: TRealEdit;
    Label2: TLabel;
    CalMax: TRealEdit;
    BOK: TBitBtn;
    TolDrag: TRealEdit;
    procedure ReservaClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure OtroChange(Sender: TObject);
    procedure ToleranciaClick(Sender: TObject);
    procedure NivelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    RBQ, TD, NMT, CCM     : Real;
  public
    { Public declarations }
    Rasante               : Real;
  end;

var
  ParamForm: TParamForm;

implementation

uses SandMain, Acercade;

{$R *.DFM}

procedure TParamForm.ReservaClick(Sender: TObject);
begin
  If Reserva.Checked Then
    begin
      RadioGroup1.Enabled := True;
      RBQ := 0.5
    end
  Else
    begin
      RadioGroup1.Enabled := False;
      Otro.Value := 0;
      RBQ := 0
    end
end;

procedure TParamForm.RadioGroup1Click(Sender: TObject);
begin
  Case RadioGroup1.ItemIndex of
    0: begin
         Otro.Enabled := False;
         RBQ := 0.5
       end;
    1: begin
         Otro.Enabled := False;
         RBQ := 1
       end;
    2: begin
         Otro.Enabled := True;
         RBQ := Otro.Value
       end
  end
end;

procedure TParamForm.OtroChange(Sender: TObject);
begin
  RBQ := Otro.Value
end;

procedure TParamForm.ToleranciaClick(Sender: TObject);
begin
  If Tolerancia.Checked Then
    begin
      TolDrag.Enabled := True;
      TD := TolDrag.Value
    end
  Else
    begin
      TolDrag.Enabled := False;
      TolDrag.Value := 0;
    end
end;

procedure TParamForm.NivelClick(Sender: TObject);
begin
  If Nivel.Checked Then
    begin
       NivelMinTeo.Enabled := False;
       NivelMinTeo.Value := 0;
     end
  Else
    NivelMinTeo.Enabled := True
end;

procedure TParamForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);

var
  RasStr   : String[10];

begin
  TD := TolDrag.Value;
  NMT := NivelMinTeo.Value;
  CCM := CalMax.Value;
  Rasante := RBQ + TD + NMT + CCM;
  Str(Rasante:5:2, RasStr);
  RasStr := RasStr + ' m)';
  SandMainForm.Parametros.Caption := '&Parámetros de Dragado (' + RasStr;
  SandMainForm.Rasante.Enabled := True
end;

end.
