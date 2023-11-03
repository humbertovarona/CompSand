unit rejilla;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Spin, StdCtrls, RZNEdit, Buttons, Gauges, Surfer;

type
  TRejillaForm = class(TForm)
    GroupBox1: TGroupBox;
    XMin: TRealEdit;
    YMin: TRealEdit;
    XMax: TRealEdit;
    YMax: TRealEdit;
    XEspacio: TRealEdit;
    YEspacio: TRealEdit;
    XNodos: TSpinEdit;
    YNodos: TSpinEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    BOK: TBitBtn;
    BCancel: TBitBtn;
    GroupBox2: TGroupBox;
    SaveDialog: TSaveDialog;
    GroupBox3: TGroupBox;
    Procesos: TGauge;
    Metodos: TComboBox;
    procedure XNodosChange(Sender: TObject);
    procedure YNodosChange(Sender: TObject);
    procedure XEspacioChange(Sender: TObject);
    procedure YEspacioChange(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BOKClick(Sender: TObject);
    procedure XNodosKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RejillaForm : TRejillaForm;

implementation

uses Datos;

{$R *.DFM}

procedure TRejillaForm.FormActivate(Sender: TObject);

begin
  XNodos.Value := 2;
  XEspacio.Value := (Xmax.Value - Xmin.Value) / (XNodos.Value - 1);
  YNodos.Value := 2;
  YEspacio.Value := (Ymax.Value - Ymin.Value) / (YNodos.Value - 1);
  Procesos.MinValue := 1;
  Procesos.Progress := 0;
  GroupBox3.Visible := False;
  RejillaForm.Height := 182
end;

procedure TRejillaForm.XNodosChange(Sender: TObject);
begin
  If XNodos.Value = 0 Then
    XNodos.Value := 2;

  XEspacio.Value := (Xmax.Value - Xmin.Value) / (XNodos.Value - 1)
end;

procedure TRejillaForm.YNodosChange(Sender: TObject);
begin
  If YNodos.Value = 0 Then
    YNodos.Value := 2;
  YEspacio.Value := (Ymax.Value - Ymin.Value) / (YNodos.Value - 1)
end;

procedure TRejillaForm.XEspacioChange(Sender: TObject);
var
  XTemp   : Real;
begin
  If XEspacio.Value = 0 Then
    begin
      XNodos.Value := 2;
      XEspacio.Value := (Xmax.Value - Xmin.Value) / (XNodos.Value - 1)
    end;
  XTemp := (Xmax.Value - Xmin.Value) / XEspacio.Value + 1;
  XNodos.Value := Round(XTemp)
end;

procedure TRejillaForm.YEspacioChange(Sender: TObject);
var
  YTemp   : Real;
begin
  If YEspacio.Value = 0 Then
    begin
      YNodos.Value := 2;
      YEspacio.Value := (Ymax.Value - Ymin.Value) / (YNodos.Value - 1)
    end;
  YTemp := (Ymax.Value - Ymin.Value) / YEspacio.Value + 1;
  YNodos.Value := Round(YTemp)
end;

procedure TRejillaForm.BCancelClick(Sender: TObject);
begin
  Close
end;

procedure PromVecMasCercanos(var data : SurferGrid);

var
  i,j,k, cantidad       : Integer;
  LimXInf, LimXSup,
  LimYInf, LimYSup,
  XAct, YAct, X, Y, Z,
  Suma                  : Real;
begin
  Data.Id := 'DSAA';
  Data.nx := RejillaForm.XNodos.Value;
  Data.ny := RejillaForm.YNodos.Value;
  Data.xmin := RejillaForm.XMin.Value;
  Data.xmax := RejillaForm.XMax.Value;
  Data.ymin := RejillaForm.YMin.Value;
  Data.ymax := RejillaForm.YMax.Value;
  YAct := RejillaForm.YMin.Value;
  RejillaForm.Procesos.MaxValue := Data.ny;
  For j := 1 To Data.ny Do
    begin
      XAct := RejillaForm.XMin.Value;
      LimYInf := YAct - RejillaForm.YEspacio.Value;
      LimYSup := YAct + RejillaForm.YEspacio.Value;
      For i := 1 To Data.nx Do
        begin
          LimXInf := XAct - RejillaForm.XEspacio.Value;
          LimXSup := XAct + RejillaForm.XEspacio.Value;
          Suma := 0;
          cantidad := 0;
          For k := 1 To Datos.MainForm.Datos.RowCount - 1 Do
            begin
              X := StrToFloat(Datos.MainForm.Datos.Cells[0, k]);
              Y := StrToFloat(Datos.MainForm.Datos.Cells[1, k]);
              If (X <= LimXSup) And (X >= LimXInf) And
                 (Y <= LimYSup) And (Y >= LimYInf) Then
                begin
                  Z := StrToFloat(Datos.MainForm.Datos.Cells[Datos.MainForm.Datos.Col, k]);
                  Inc(cantidad);
                  Suma := Suma + Z
                end
            end;
          If cantidad <> 0 Then
            Data.Rejilla[i,j] := Suma / cantidad
          Else
            Data.Rejilla[i,j] := LIMITE;
          XAct := XAct + RejillaForm.XEspacio.Value
        end;
      RejillaForm.Procesos.Progress := j;
      YAct := YAct + RejillaForm.YEspacio.Value
    end;

  YAct := RejillaForm.YMin.Value;
  For j := 1 To Data.ny Do
    begin
      XAct := RejillaForm.XMin.Value;
      For i := 1 To Data.nx Do
        begin
          If Data.Rejilla[i, j] >= LIMITE Then
            begin
              If (j = 1) And (i = 1) Then
                begin
                  Data.Rejilla[i, j] := (Data.Rejilla[i + 1, j] +
                                         Data.Rejilla[i + 1, j + 1] +
                                         Data.Rejilla[i,  j + 1]) / 3
                end;
              If (j = 1) And (i = Data.nx) Then
                begin
                  Data.Rejilla[i, j] := (Data.Rejilla[i + 1, j + 1] +
                                         Data.Rejilla[i - 1, j + 1] +
                                         Data.Rejilla[i - 1,  j]) / 3
                end;
              If (j = Data.ny) And (i = 1) Then
                begin
                  Data.Rejilla[i, j] := (Data.Rejilla[i, j - 1] +
                                         Data.Rejilla[i + 1, j - 1] +
                                         Data.Rejilla[i + 1,  j]) / 3
                end;
              If (j = Data.ny) And (i = Data.nx) Then
                begin
                  Data.Rejilla[i, j] := (Data.Rejilla[i - 1, j] +
                                         Data.Rejilla[i - 1, j - 1] +
                                         Data.Rejilla[i,  j - 1]) / 3
                end;
              If (j = 1) And ((i <> Data.nx) Or (i <> 1)) Then
                begin
                  Data.Rejilla[i, j] := (Data.Rejilla[i + 1, j] +
                                         Data.Rejilla[i + 1, j + 1] +
                                         Data.Rejilla[i,  j + 1] +
                                         Data.Rejilla[i - 1,  j + 1] +
                                         Data.Rejilla[i - 1,  j]) / 5
                end;
              If (j = Data.ny) And ((i <> Data.nx) Or (i <> 1)) Then
                begin
                  Data.Rejilla[i, j] := (Data.Rejilla[i - 1, j] +
                                         Data.Rejilla[i - 1, j - 1] +
                                         Data.Rejilla[i,  j - 1] +
                                         Data.Rejilla[i + 1,  j - 1] +
                                         Data.Rejilla[i + 1,  j]) / 5
                end;
              If ((j <> Data.ny) Or (j <> 1)) And (i = 1) Then
                begin
                  Data.Rejilla[i, j] := (Data.Rejilla[i, j - 1] +
                                         Data.Rejilla[i + 1, j - 1] +
                                         Data.Rejilla[i + 1,  j] +
                                         Data.Rejilla[i + 1,  j + 1] +
                                         Data.Rejilla[i,  j + 1]) / 5
                end;
              If ((j <> Data.ny) Or (j <> 1)) And (i = Data.nx) Then
                begin
                  Data.Rejilla[i, j] := (Data.Rejilla[i, j - 1] +
                                         Data.Rejilla[i - 1, j - 1] +
                                         Data.Rejilla[i - 1,  j] +
                                         Data.Rejilla[i - 1,  j + 1] +
                                         Data.Rejilla[i, j + 1]) / 5
                end;
              If (j <> Data.ny) And (j <> 1) And (i <> Data.nx) And (i <> 1) Then
                begin
                  Data.Rejilla[i, j] := (Data.Rejilla[i - 1, j - 1] +
                                         Data.Rejilla[i, j - 1] +
                                         Data.Rejilla[i + 1,  j - 1] +
                                         Data.Rejilla[i - 1, j + 1] +
                                         Data.Rejilla[i, j + 1] +
                                         Data.Rejilla[i + 1,  j + 1] +
                                         Data.Rejilla[i - 1,  j] +
                                         Data.Rejilla[i + 1, j]) / 8
                end;
            end;
           XAct := XAct + RejillaForm.XEspacio.Value
        end;
      RejillaForm.Procesos.Progress := j;
      YAct := YAct + RejillaForm.YEspacio.Value
    end;
end;

procedure TRejillaForm.BOKClick(Sender: TObject);
var
  Data : SurferGrid;
begin
  GroupBox3.Visible := True;
  RejillaForm.Height := 235;
  PromVecMasCercanos(Data);
  If SaveDialog.Execute Then
    WriteSurferGird(SaveDialog.FileName, Data)
end;

procedure TRejillaForm.XNodosKeyPress(Sender: TObject; var Key: Char);
begin
  key := #0;
end;

end.
