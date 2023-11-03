Unit Controles;

Interface

Type
  TipoFecha = String[10];

  InfoRejilla = Record
    NombRejilla : String[255];
    Fecha       : TipoFecha
  end;

Var
  Editor     : Boolean;
  Info       : Array [1..2] of InfoRejilla;

function Dias(Fecha1, Fecha2 : String) : Real;

Implementation

function Dias(Fecha1, Fecha2 : String) : Real;

var
  Ano1, Mes1, Dia1,
  Ano2, Mes2, Dia2,
  Ano3, Mes3, Dia3, Bisiesto,
  CantDias, code                       : Integer;

begin
  Val(Copy(Fecha1, 1, 4), Ano1, code);
  Val(Copy(Fecha1, 6, 2), Mes1, code);
  Val(Copy(Fecha1, 9, 2), Dia1, code);
  Val(Copy(Fecha2, 1, 4), Ano2, code);
  Val(Copy(Fecha2, 6, 2), Mes2, code);
  Val(Copy(Fecha2, 9, 2), Dia2, code);
  Ano3 := Abs(Ano1 - Ano2);
  Mes3 := Mes1 - Mes2;
  If Mes3 < 0 Then
    begin
      Inc(Mes3,12);
      Dec(Ano3)
    end;
  Dia3 := Dia1 - Dia2;
  If Dia3 < 0 Then
    begin
      Inc(Dia3,30);
      Dec(Mes3)
    end;
  CantDias := Ano3 * 365 + Mes3 * 30 + Dia3;
  If (Mes3 = 0) And ((Ano1 Mod 4 = 0) Or (Ano2 Mod 4 = 0)) Then
    Bisiesto := 1
  Else
    begin
      bisiesto := Ano3 div 4;
      If ((Ano1 Mod 4 = 0) And (Ano2 Mod 4 = 0)) Then
        Inc(bisiesto)
    end;
  Dias := CantDias + bisiesto
end;

end.
