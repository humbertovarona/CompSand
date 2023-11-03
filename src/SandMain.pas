unit SandMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, TB97, StdCtrls, RZNEdit;

type
  TSandMainForm = class(TForm)
    MainMenu1: TMainMenu;
    Proyecto: TMenuItem;
    Calculo: TMenuItem;
    Nuevo: TMenuItem;
    Abrir: TMenuItem;
    Terminar: TMenuItem;
    Guardar: TMenuItem;
    VelSed: TMenuItem;
    Pronostico: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Editar: TMenuItem;
    Toolbar: TToolbar97;
    Dock971: TDock97;
    TBNuevo: TToolbarButton97;
    TBEditar: TToolbarButton97;
    TBTerminar: TToolbarButton97;
    TBAbrir: TToolbarButton97;
    TBGuardar: TToolbarButton97;
    Diferencia: TMenuItem;
    Ayuda1: TMenuItem;
    Acercade: TMenuItem;
    Ayuda: TMenuItem;
    Opciones: TMenuItem;
    Parametros: TMenuItem;
    Suma: TMenuItem;
    Rasante: TMenuItem;
    VidaUtil: TRealEdit;
    procedure NuevoClick(Sender: TObject);
    procedure TerminarClick(Sender: TObject);
    procedure EditarClick(Sender: TObject);
    procedure AbrirClick(Sender: TObject);
    procedure VelSedClick(Sender: TObject);
    procedure PronosticoClick(Sender: TObject);
    procedure GuardarClick(Sender: TObject);
    procedure DiferenciaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AcercadeClick(Sender: TObject);
    procedure ParametrosClick(Sender: TObject);
    procedure SumaClick(Sender: TObject);
    procedure RasanteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SandMainForm: TSandMainForm;

implementation

uses Nuevo, controles, Splash, Acercade, Param;

{$R *.DFM}

procedure TSandMainForm.NuevoClick(Sender: TObject);

begin
  Editor := False;
  Guardar.Enabled := True;
  TBGuardar.Enabled := True;
  Editar.Enabled := True;
  TBEditar.Enabled := True;
  Opciones.Enabled :=True;
  NuevoForm.Adicionar.Visible := True;
  NuevoForm.Eliminar.Visible := True;
  NuevoForm.Calcular.Visible := False;
  NuevoForm.Pronosticar.Visible := False;
  NuevoForm.BFecha.Visible := False;
  NuevoForm.BDiferencia.Visible := False;
  NuevoForm.BSuma.Visible := False;
  NuevoForm.BRasante.Visible := False;
  NuevoForm.AdicPrj.Visible := False;
  NuevoForm.GroupBox2.Visible := False;
  NuevoForm.StaticText1.Visible := False;
  NuevoForm.StaticText2.Visible := False;
  NuevoForm.LBRejillas.ExtendedSelect := False;
  NuevoForm.LBRejillas.MultiSelect := False;
  Pronostico.Enabled := False;
  Calculo.Enabled := True;
  NuevoForm.AdicPrj.Visible := False;
  NuevoForm.GroupBox2.Visible := False;
  NuevoForm.StaticText1.Visible := False;
  NuevoForm.StaticText2.Visible := False;
  NuevoForm.Show
end;

procedure TSandMainForm.TerminarClick(Sender: TObject);
begin
  Close
end;

procedure TSandMainForm.EditarClick(Sender: TObject);
begin
  Editor := True;
  NuevoForm.Adicionar.Visible := True;
  NuevoForm.Eliminar.Visible := True;
  NuevoForm.Calcular.Visible := False;
  NuevoForm.Pronosticar.Visible := False;
  NuevoForm.BFecha.Visible := False;
  NuevoForm.BDiferencia.Visible := False;
  NuevoForm.BSuma.Visible := False;
  NuevoForm.BRasante.Visible := False;
  NuevoForm.AdicPrj.Visible := False;
  NuevoForm.GroupBox2.Visible := False;
  NuevoForm.StaticText1.Visible := False;
  NuevoForm.StaticText2.Visible := False;
  NuevoForm.LBRejillas.ExtendedSelect := False;
  NuevoForm.LBRejillas.MultiSelect := False;
  NuevoForm.AdicPrj.Visible := False;
  NuevoForm.GroupBox2.Visible := False;
  NuevoForm.StaticText1.Visible := False;
  NuevoForm.StaticText2.Visible := False;
  NuevoForm.Show
end;

procedure TSandMainForm.AbrirClick(Sender: TObject);

Var
  fIn        : TextFile;
  cant,
  i          : Byte;
  Rejilla    : String[80];
  Fecha      : String[10];

begin
  NuevoForm.LBRejillas.Clear;
  NuevoForm.LBFechas.Clear;
  Pronostico.Enabled := False;
  Opciones.Enabled :=True;
  If OpenDialog.Execute Then
    begin
      AssignFile(fIn, OpenDialog.FileName);
      Reset(fIn);
      Readln(fIn, cant);
      For i:=1 To cant Do
        begin
          Readln(fIn, Rejilla, Fecha);
          NuevoForm.LBRejillas.Items.Add(Rejilla);
          NuevoForm.LBFechas.Items.Add(Fecha);
        end;
      CloseFile(fIn);
      Calculo.Enabled := True;
      Editor := True;
      Editar.Enabled := True;
      Guardar.Enabled := True;
      TBGuardar.Enabled := True;
      TBEditar.Enabled := True
    end
end;

procedure TSandMainForm.VelSedClick(Sender: TObject);
begin
  Editor := True;
  NuevoForm.Adicionar.Visible := False;
  NuevoForm.Eliminar.Visible := False;
  NuevoForm.Calcular.Visible := True;
  NuevoForm.Pronosticar.Visible := False;
  NuevoForm.BFecha.Visible := False;
  NuevoForm.BDiferencia.Visible := False;
  NuevoForm.BSuma.Visible := False;
  NuevoForm.BRasante.Visible := False;
  NuevoForm.LBRejillas.ExtendedSelect := True;
  NuevoForm.LBRejillas.MultiSelect := True;
  NuevoForm.AdicPrj.Visible := True;
  NuevoForm.GroupBox2.Visible := True;
  NuevoForm.StaticText1.Visible := True;
  NuevoForm.StaticText2.Visible := True;
  NuevoForm.ShowModal;
end;

procedure TSandMainForm.PronosticoClick(Sender: TObject);

begin
  Editor := True;
  NuevoForm.Adicionar.Visible := False;
  NuevoForm.Eliminar.Visible := False;
  NuevoForm.Calcular.Visible := False;
  NuevoForm.BSuma.Visible := False;
  NuevoForm.BRasante.Visible := False;
  NuevoForm.Pronosticar.Visible := True;
  NuevoForm.Pronosticar.Enabled := False;
  NuevoForm.BFecha.Visible := True;
  NuevoForm.BDiferencia.Visible := False;
  NuevoForm.AdicPrj.Visible := False;
  NuevoForm.GroupBox2.Visible := False;
  NuevoForm.StaticText1.Visible := False;
  NuevoForm.StaticText2.Visible := False;
  NuevoForm.Show;
end;

procedure TSandMainForm.GuardarClick(Sender: TObject);
Var
  fOut  : TextFile;
  i, j  : Byte;

begin
  If SaveDialog.Execute Then
    begin
      If NuevoForm.LBRejillas.Items.Count > 0 Then
        begin
          AssignFile(fOut, SaveDialog.FileName);
          Rewrite(fOut);
          Writeln(fOut, NuevoForm.LBRejillas.Items.Count);
          For i:=0 To NuevoForm.LBRejillas.Items.Count - 1 Do
            begin
              Write(fOut, NuevoForm.LBRejillas.Items[i]);
              If Length(NuevoForm.LBRejillas.Items[i]) < 80 Then
                For j := 1 To 80 - Length(NuevoForm.LBRejillas.Items[i]) Do
                  Write(fOut, ' ');
              Writeln(fOut, NuevoForm.LBFechas.Items[i]);
             end;
          CloseFile(fOut)
        end;
      Calculo.Enabled := True
    end
end;

procedure TSandMainForm.DiferenciaClick(Sender: TObject);
begin
  Editor := True;
  NuevoForm.Adicionar.Visible := False;
  NuevoForm.Eliminar.Visible := False;
  NuevoForm.Calcular.Visible := True;
  NuevoForm.Pronosticar.Visible := False;
  NuevoForm.BFecha.Visible := False;
  NuevoForm.BDiferencia.Visible := True;
  NuevoForm.BSuma.Visible := False;
  NuevoForm.BRasante.Visible := False;
  NuevoForm.AdicPrj.Visible := False;
  NuevoForm.GroupBox2.Visible := False;
  NuevoForm.StaticText1.Visible := False;
  NuevoForm.StaticText2.Visible := False;
  NuevoForm.LBRejillas.ExtendedSelect := True;
  NuevoForm.LBRejillas.MultiSelect := True;
  NuevoForm.AdicPrj.Visible := True;
  NuevoForm.GroupBox2.Visible := True;
  NuevoForm.StaticText1.Visible := True;
  NuevoForm.StaticText2.Visible := True;
  NuevoForm.ShowModal;
end;

procedure TSandMainForm.FormShow(Sender: TObject);
begin
  SplashForm.ShowModal
end;

procedure TSandMainForm.AcercadeClick(Sender: TObject);
begin
  AboutBox.ShowModal
end;

procedure TSandMainForm.ParametrosClick(Sender: TObject);
begin
  ParamForm.ShowModal
end;

procedure TSandMainForm.SumaClick(Sender: TObject);
begin
  Editor := True;
  NuevoForm.Adicionar.Visible := False;
  NuevoForm.Eliminar.Visible := False;
  NuevoForm.Calcular.Visible := True;
  NuevoForm.Pronosticar.Visible := False;
  NuevoForm.BFecha.Visible := False;
  NuevoForm.BDiferencia.Visible := False;
  NuevoForm.BSuma.Visible := True;
  NuevoForm.BRasante.Visible := False;
  NuevoForm.AdicPrj.Visible := False;
  NuevoForm.GroupBox2.Visible := False;
  NuevoForm.StaticText1.Visible := False;
  NuevoForm.StaticText2.Visible := False;
  NuevoForm.LBRejillas.ExtendedSelect := True;
  NuevoForm.LBRejillas.MultiSelect := True;
  NuevoForm.AdicPrj.Visible := True;
  NuevoForm.GroupBox2.Visible := True;
  NuevoForm.StaticText1.Visible := True;
  NuevoForm.StaticText2.Visible := True;
  NuevoForm.ShowModal;
end;

procedure TSandMainForm.RasanteClick(Sender: TObject);
begin
  Editor := True;
  NuevoForm.Adicionar.Visible := False;
  NuevoForm.Eliminar.Visible := False;
  NuevoForm.Calcular.Visible := True;
  NuevoForm.Pronosticar.Visible := False;
  NuevoForm.BFecha.Visible := False;
  NuevoForm.BDiferencia.Visible := True;
  NuevoForm.BSuma.Visible := False;
  NuevoForm.BRasante.Visible := True;
  NuevoForm.AdicPrj.Visible := False;
  NuevoForm.GroupBox2.Visible := False;
  NuevoForm.StaticText1.Visible := False;
  NuevoForm.StaticText2.Visible := False;
  NuevoForm.LBRejillas.ExtendedSelect := False;
  NuevoForm.LBRejillas.MultiSelect := False;
  NuevoForm.AdicPrj.Visible := True;
  NuevoForm.GroupBox2.Visible := True;
  NuevoForm.StaticText1.Visible := True;
  NuevoForm.StaticText2.Visible := True;
  NuevoForm.ShowModal;
end;

end.
