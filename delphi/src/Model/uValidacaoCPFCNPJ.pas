unit uValidacaoCPFCNPJ;

interface

uses System.SysUtils, System.Character;

type
  TValidacaoCPFCNPJ = class
  public
    class function ValidarCPF(const CPF: string): Boolean;
    class function ValidarCNPJ(const CNPJ: string): Boolean;
  end;

implementation

{ TValidacaoCPFCNPJ }

class function TValidacaoCPFCNPJ.ValidarCNPJ(const CNPJ: string): Boolean;
var
   n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12: integer;
   d1,d2: integer;
   digitado, calculado: string;
begin
   n1:=StrToInt(CNPJ[1]);
   n2:=StrToInt(CNPJ[2]);
   n3:=StrToInt(CNPJ[3]);
   n4:=StrToInt(CNPJ[4]);
   n5:=StrToInt(CNPJ[5]);
   n6:=StrToInt(CNPJ[6]);
   n7:=StrToInt(CNPJ[7]);
   n8:=StrToInt(CNPJ[8]);
   n9:=StrToInt(CNPJ[9]);
   n10:=StrToInt(CNPJ[10]);
   n11:=StrToInt(CNPJ[11]);
   n12:=StrToInt(CNPJ[12]);

   d1:=n12*2+n11*3+n10*4+n9*5+n8*6+n7*7+n6*8+n5*9+n4*2+n3*3+n2*4+n1*5;

   d1:=11-(d1 mod 11);

   if d1>=10 then d1:=0;
     d2:=d1*2+n12*3+n11*4+n10*5+n9*6+n8*7+n7*8+n6*9+n5*2+n4*3+n3*4+n2*5+n1*6;
   d2:=11-(d2 mod 11);

   if d2>=10 then d2:=0;
     calculado:=inttostr(d1)+inttostr(d2);
   digitado:=CNPJ[13]+CNPJ[14];

   if calculado=digitado then
     Result := true

   else
     Result := false;
end;

class function TValidacaoCPFCNPJ.ValidarCPF(const CPF: string): Boolean;
var
  CPFCalculado : String;
  Soma, Resto, DigitoVerificador, DigitoVerificado2: Integer;
  i: Integer;
begin
  CPFCalculado := '';

  for I := 1 to Length(CPF) do
  begin
    if CharInSet(CPF[I], ['0'..'9']) then
    begin
      CPFCalculado := CPFCalculado + CPF[i];
    end;
  end;

  Soma := 0;
  for i := 1 to 9 do
    Soma := Soma + StrToInt(CPFCalculado[i]) * (11 - i);
  Resto := (Soma * 10) mod 11;
  if (Resto = 10) or (Resto = StrToInt(CPFCalculado[11])) then
  begin
    Result := False;
    Exit;
  end;

  Result := True;
end;

end.
