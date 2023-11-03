unit Nuevo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls;

type
  TNuevoForm = class(TForm)
    GroupBox1: TGroupBox;
    LBRejillas: TListBox;
    LBFechas: TListBox;
    Adicionar: TBitBtn;
    Eliminar: TBitBtn;
    Cerrar: TBitBtn;
    OpenDialog: TOpenDialog;
    BFecha: TBitBtn;
    Pronosticar: TBitBtn;
    Calcular: TBitBtn;
    SaveDialog: TSaveDialog;
    BDiferencia: TBitBtn;
    GroupBox2: TGroupBox;
    AdicPrj: TCheckBox;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    BSuma: TBitBtn;
    BRasante: TBitBtn;
    procedure CerrarClick(Sender: TObject);
    procedure AdicionarClick(Sender: TObject);
    procedure LBRejillasClick(Sender: TObject);
    procedure EliminarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PronosticarClick(Sender: TObject);
    procedure BFechaClick(Sender: TObject);
    procedure CalcularClick(Sender: TObject);
    procedure BDiferenciaClick(Sender: TObject);
    procedure BSumaClick(Sender: TObject);
    procedure BRasanteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NuevoForm                : TNuevoForm;

implementation

uses Fecha, controles, SandMain, Surfer, Param;

Var
  Data1, Data2, DataCoef,
  DataPronost              : SurferGrid;


{$R *.DFM}

procedure TNuevoForm.CerrarClick(Sender: TObject);

begin
  Close
end;

procedure TNuevoForm.AdicionarClick(Sender: TObject);
begin
  If OpenDialog.Execute Then
    begin
      FechaForm.ShowModal;
      LBRejillas.Items.Add(OpenDialog.FileName);
      LBFechas.Items.Add(FechaForm.BOk.Caption);
    end;
end;

procedure TNuevoForm.LBRejillasClick(Sender: TObject);
begin
  If LBRejillas.Focused Then
    Eliminar.Enabled := True
end;

procedure TNuevoForm.EliminarClick(Sender: TObject);
begin
  If LBRejillas.ItemIndex > -1 Then
    begin
      LBFechas.Items.Delete(LBRejillas.ItemIndex);
      LBRejillas.Items.Delete(LBRejillas.ItemIndex);
      Eliminar.Enabled := False;
    end
end;

procedure TNuevoForm.FormActivate(Sender: TObject);
begin
  If Not Editor Then
    begin
      LBFechas.Items.Clear;
      LBRejillas.Items.Clear
    end
end;

procedure TNuevoForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  SandMainForm.Editar.Enabled := True
end;

procedure TNuevoForm.PronosticarClick(Sender: TObject);

var
  i            : Integer;
  d            : Real;
  FechaBat     : TipoFecha;
  NombBat      : String[80];

begin
  If LBRejillas.Items.Count = 0 Then
    ShowMessage('Proyecto vacío')
  Else
    begin
      For i:=0 To LBRejillas.Items.Count - 1 Do
        If LBRejillas.Selected[i] Then
          begin
            FechaBat := LBFechas.Items[i];
            NombBat := LBRejillas.Items[i]
          end;
      ReadSurferGird(NombBat, Data1);
      d := Dias(BFecha.Caption, FechaBat);

      If BFecha.Caption < FechaBat Then
        d := -d;
      MultEscalarSurferGird(DataCoef, d);
      DiferenciaSurferGird(Data1, DataCoef, DataPronost);
      If SaveDialog.Execute Then
        begin
          WriteSurferGird(SaveDialog.FileName, DataPronost);
          If AdicPrj.Checked Then
            begin
              LBRejillas.Items.Add(SaveDialog.FileName);
              LBFechas.Items.Add(BFecha.Caption);
              AdicPrj.Checked := False;
              AdicPrj.Visible := False;
              GroupBox2.Visible := False;
              StaticText1.Visible := False;
              StaticText2.Visible := False;
              Pronosticar.Enabled := False;
              BFecha.Caption := '&Fecha';
            end
        end
    end
end;

procedure TNuevoForm.BFechaClick(Sender: TObject);
begin
  FechaForm.ShowModal;
  BFecha.Caption := FechaForm.BOk.Caption;
  Pronosticar.Enabled := True;
  AdicPrj.Visible := True;
  GroupBox2.Visible := True;
  StaticText1.Visible := True;
  StaticText2.Visible := True;
end;

procedure TNuevoForm.CalcularClick(Sender: TObject);

var
  i, j     : Integer;
  d        : Real;

begin
  If LBRejillas.Items.Count = 0 Then
    ShowMessage('Proyecto vacío')
  Else
  If LBRejillas.SelCount <> 2 Then
    ShowMessage('Debe elejir 2 rejillas')
  Else
    begin
      j := 0;
      For i:=0 To LBRejillas.Items.Count - 1 Do
        If LBRejillas.Selected[i] Then
          begin
            Inc(j);
            Info[j].Fecha := LBFechas.Items[i];
            Info[j].NombRejilla := LBRejillas.Items[i]
          end;
      If ReadSurferGird(Info[1].NombRejilla, Data1) And
         ReadSurferGird(Info[2].NombRejilla, Data2) Then
        Begin
        If Info[2].Fecha < Info[1].Fecha Then
          begin
            DiferenciaSurferGird(Data2, Data1, DataCoef);
            d := Dias(Info[2].Fecha, Info[1].Fecha);
          end
        Else
          begin
            DiferenciaSurferGird(Data1, Data2, DataCoef);
            d := Dias(Info[1].Fecha, Info[2].Fecha);
          end;
          d := 1 / d;
        MultEscalarSurferGird(DataCoef, d);
        If SaveDialog.Execute Then
          begin
            WriteSurferGird(SaveDialog.FileName, DataCoef);
            If AdicPrj.Checked Then
              begin
                LBRejillas.Items.Add(SaveDialog.FileName);
                LBFechas.Items.Add('----/--/--');
                AdicPrj.Checked := False;
                AdicPrj.Visible := False;
                GroupBox2.Visible := False;
                StaticText1.Visible := False;
                StaticText2.Visible := False;
              end
          end
        end;
      SandMainForm.Pronostico.Enabled := True
    end
end;

procedure TNuevoForm.BDiferenciaClick(Sender: TObject);

var
  i, j     : Integer;

begin
  If LBRejillas.Items.Count = 0 Then
    ShowMessage('Proyecto vacío')
  Else
  If LBRejillas.SelCount <> 2 Then
    ShowMessage('Debe elejir 2 rejillas')
  Else
    begin
      j := 0;
      For i:=0 To LBRejillas.Items.Count - 1 Do
        If LBRejillas.Selected[i] Then
          begin
            Inc(j);
            Info[j].Fecha := LBFechas.Items[i];
            Info[j].NombRejilla := LBRejillas.Items[i]
          end;
      ReadSurferGird(Info[1].NombRejilla, Data1);
      ReadSurferGird(Info[2].NombRejilla, Data2);
      If Info[1].Fecha < Info[2].Fecha Then
        DiferenciaSurferGird(Data1, Data2, DataCoef)
      Else
        DiferenciaSurferGird(Data2, Data1, DataCoef);
      If SaveDialog.Execute Then
        begin
          WriteSurferGird(SaveDialog.FileName, DataCoef);
          If AdicPrj.Checked Then
            begin
              LBRejillas.Items.Add(SaveDialog.FileName);
              LBFechas.Items.Add('----/--/--');
              AdicPrj.Checked := False;
              AdicPrj.Visible := False;
              GroupBox2.Visible := False;
              StaticText1.Visible := False;
              StaticText2.Visible := False;
            end
        end;
      SandMainForm.Pronostico.Enabled := True
    end
end;

procedure TNuevoForm.BSumaClick(Sender: TObject);

var
  i, j     : Integer;

begin
  If LBRejillas.Items.Count = 0 Then
    ShowMessage('Proyecto vacío')
  Else
  If LBRejillas.SelCount <> 2 Then
    ShowMessage('Debe elejir 2 rejillas')
  Else
    begin
      j := 0;
      For i:=0 To LBRejillas.Items.Count - 1 Do
        If LBRejillas.Selected[i] Then
          begin
            Inc(j);
            Info[j].Fecha := LBFechas.Items[i];
            Info[j].NombRejilla := LBRejillas.Items[i]
          end;
      ReadSurferGird(Info[1].NombRejilla, Data1);
      ReadSurferGird(Info[2].NombRejilla, Data2);
      If Info[1].Fecha < Info[2].Fecha Then
        SumaSurferGird(Data1, Data2, DataCoef)
      Else
        SumaSurferGird(Data2, Data1, DataCoef);
      If SaveDialog.Execute Then
        begin
          WriteSurferGird(SaveDialog.FileName, DataCoef);
          If AdicPrj.Checked Then
            begin
              LBRejillas.Items.Add(SaveDialog.FileName);
              LBFechas.Items.Add('----/--/--');
              AdicPrj.Checked := False;
              AdicPrj.Visible := False;
              GroupBox2.Visible := False;
              StaticText1.Visible := False;
              StaticText2.Visible := False;
            end
        end;
      SandMainForm.Pronostico.Enabled := True
    end
end;

procedure TNuevoForm.BRasanteClick(Sender: TObject);

var
  i, j     : Integer;

begin
  If LBRejillas.Items.Count = 0 Then
    ShowMessage('Proyecto vacío')
  Else
    begin
      j := 0;
      For i:=0 To LBRejillas.Items.Count - 1 Do
        If LBRejillas.Selected[i] Then
          begin
            Inc(j);
            Info[j].NombRejilla := LBRejillas.Items[i]
          end
    end;
  ReadSurferGird(Info[1].NombRejilla, Data1);
  //SurferGird(Data1, ParamForm.Rasante);
  If SaveDialog.Execute Then
    begin
      WriteSurferGird(SaveDialog.FileName, DataCoef);
      If AdicPrj.Checked Then
        begin
          LBRejillas.Items.Add(SaveDialog.FileName);
          LBFechas.Items.Add('----/--/--');
          AdicPrj.Checked := False;
          AdicPrj.Visible := False;
          GroupBox2.Visible := False;
          StaticText1.Visible := False;
          StaticText2.Visible := False;
        end
    end;
  SandMainForm.Pronostico.Enabled := True
end;

end.
