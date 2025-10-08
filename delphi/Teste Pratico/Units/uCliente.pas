unit uCliente;

// -------------------------------------------------------------
// Modelo dos dados.
// -------------------------------------------------------------

interface

type
  TCliente = class
  private
    FID: Integer;
    FNome: string;
    FEmail: string;
    FDocumento: string;
  public
    property ID: Integer read FID write FID;
    property Nome: string read FNome write FNome;
    property Email: string read FEmail write FEmail;
    property Documento: string read FDocumento write FDocumento;

    function ToCSV: string;
    class function FromCSV(const ALine: string): TCliente;
  end;

implementation

uses
  System.SysUtils;

function TCliente.ToCSV: string;
begin
  Result := Format('%d;%s;%s;%s', [FID, FNome, FEmail, FDocumento]);
end;

class function TCliente.FromCSV(const ALine: string): TCliente;
var
  vParts: TArray<string>;
begin
  vParts := ALine.Split([';']);
  Result := TCliente.Create;
  Result.ID := StrToIntDef(vParts[0], 0);
  Result.Nome := vParts[1];
  Result.Email := vParts[2];
  Result.Documento := vParts[3];
end;

end.
