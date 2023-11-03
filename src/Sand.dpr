program Sand;

uses
  Forms,
  SandMain in 'SandMain.pas' {SandMainForm},
  Nuevo in 'Nuevo.pas' {NuevoForm},
  Fecha in 'fecha.pas' {FechaForm},
  controles in 'controles.pas',
  Surfer in 'Surfer.pas',
  Splash in 'Splash.pas' {SplashForm},
  Acercade in 'Acercade.pas' {AboutBox},
  Param in 'Param.pas' {ParamForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Sand';
  Application.CreateForm(TSandMainForm, SandMainForm);
  Application.CreateForm(TNuevoForm, NuevoForm);
  Application.CreateForm(TFechaForm, FechaForm);
  Application.CreateForm(TSplashForm, SplashForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TParamForm, ParamForm);
  Application.Run;
end.
