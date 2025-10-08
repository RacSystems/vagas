unit uClienteList;

// -------------------------------------------------------------
// Gerencia os dados buscando e filtrando eles.
// -------------------------------------------------------------

interface

uses
  System.Generics.Collections, uCliente, System.SysUtils;

type
  TClienteList = class(TObjectList<TCliente>)
  public
    function BuscaPorID(AID: Integer): TList<TCliente>;
    function BuscaPorNome(const ANome: string): TList<TCliente>;
    function ProximoID: Integer;
    function Buscar(AValor: string): TList<TCliente>;
    function RemovePorID(AID: Integer): Boolean;
  end;

implementation

function TClienteList.BuscaPorID(AID: Integer): TList<TCliente>;
var
  vCliente: TCliente;
begin
  Result := TList<TCliente>.Create;

  for vCliente in Self do
  begin
    if vCliente.ID = AID then
    begin
      Result.Add(vCliente);
      Exit;
    end;
  end;
end;

function TClienteList.BuscaPorNome(const ANome: string): TList<TCliente>;
var
  vCliente: TCliente;
  vListResult: TList<TCliente>;
  vNomeBusca: string;
begin
  vListResult := TList<TCliente>.Create;
  Result := vListResult; // Atribui o resultado antes do loop

  vNomeBusca := LowerCase(ANome.Trim);

  // Se a busca for vazia, retorna a lista completa
  if vNomeBusca.IsEmpty then
  begin
    for vCliente in Self do
      vListResult.Add(vCliente);
  end
  else // Realiza a busca parcial
  begin
    for vCliente in Self do
      if Pos(vNomeBusca, LowerCase(vCliente.Nome)) > 0 then
        vListResult.Add(vCliente);
  end;
end;

function TClienteList.Buscar(AValor: string): TList<TCliente>;
var
  vValorInt: Integer;
begin
  // Se a conversão for bem-sucedida, busca por ID
  if TryStrToInt(AValor, vValorInt) then
    Result := BuscaPorID(vValorInt)
  else
    Result := BuscaPorNome(AValor);
end;

function TClienteList.ProximoID: Integer;
var
  vMaxID: Integer;
  vCliente: TCliente;
begin
  vMaxID := 0;
  for vCliente in Self do
    if vCliente.ID > vMaxID then
      vMaxID := vCliente.ID;
  Result := vMaxID + 1;
end;

function TClienteList.RemovePorID(AID: Integer): Boolean;
var
  vCliente: TCliente;
  vIndex: Integer;
begin
  Result := False;
  for vIndex := Count - 1 downto 0 do
  begin
    vCliente := Items[vIndex];
    if (vCliente <> nil) and (vCliente.ID = AID) then
    begin
      Remove(vCliente);
      Result := True;
      Break;
    end;
  end;
end;

end.
