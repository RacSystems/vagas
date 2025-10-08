unit uClienteDAO;

// -------------------------------------------------------------
// Lê e grava a lista de clientes em um JSON no disco.
// -------------------------------------------------------------

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.Generics.Collections,
  System.IOUtils, uCliente, uClienteList;

type
  TClienteDAO = class
  private
    FNomArq: string;
    procedure EnsureFile;
    function ClienteToJSON(const ACliente: TCliente): TJSONObject;
    function JSONToCliente(const AObj: TJSONObject): TCliente;
  public
    constructor Create(const ANomArq: string = '');
    function Load(ALista: TClienteList): Boolean;
    function Save(ALista: TClienteList): Boolean;
    property NomArq: string read FNomArq;
  end;

implementation

constructor TClienteDAO.Create(const ANomArq: string);
begin
  if ANomArq.Trim <> '' then
    FNomArq := ANomArq
  else
    FNomArq := TPath.Combine(ExtractFilePath(ParamStr(0)), 'clientes.json');

  EnsureFile;
end;

procedure TClienteDAO.EnsureFile;
begin
  if not TFile.Exists(FNomArq) then
    TFile.WriteAllText(FNomArq, '[]', TEncoding.UTF8);
end;

function TClienteDAO.ClienteToJSON(const ACliente: TCliente): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('ID', TJSONNumber.Create(ACliente.ID));
  Result.AddPair('Nome', ACliente.Nome);
  Result.AddPair('Email', ACliente.Email);
  Result.AddPair('Documento', ACliente.Documento);
end;

function TClienteDAO.JSONToCliente(const AObj: TJSONObject): TCliente;
var
  vValor: TJSONValue;
begin
  Result := TCliente.Create;
  try
    Result.ID := AObj.GetValue<Integer>('ID', 0);
    Result.Nome := AObj.GetValue<string>('Nome', '');
    Result.Email := AObj.GetValue<string>('Email', '');
    Result.Documento := AObj.GetValue<string>('Documento', '');
  except
    on E: Exception do
    begin
      raise Exception.CreateFmt('Erro ao buscar os dados: %s', [E.Message]);
    end;
  end;
end;

function TClienteDAO.Load(ALista: TClienteList): Boolean;
var
  vDados: string;
  vArquivo: TJSONValue;
  vArray: TJSONArray;
  vItem: TJSONValue;
begin
  Result := False;
  ALista.Clear;
  EnsureFile;
  try
    vDados := TFile.ReadAllText(FNomArq, TEncoding.UTF8);
    vArquivo := TJSONObject.ParseJSONValue(vDados);

    if (vArquivo is TJSONArray) then
    begin
      vArray := TJSONArray(vArquivo);
      for vItem in vArray do
      begin
        if vItem is TJSONObject then
        begin
          ALista.Add(JSONToCliente(TJSONObject(vItem)));
          Result := True;
        end;
      end;
    end
    else
    begin
      raise Exception.Create('Formato de arquivo JSON inesperado.');
      Result := False;
    end;
  finally
    if Assigned(vArquivo) then
      vArquivo.Free;
  end;
end;

function TClienteDAO.Save(ALista: TClienteList): Boolean;
var
  vArray: TJSONArray;
  vCliente: TCliente;
  vContFor: string;
  vNomArqTemp: string;
begin
  Result := False;
  vArray := TJSONArray.Create;
  try
    for vCliente in ALista do
      vArray.AddElement(ClienteToJSON(vCliente));

    // Formata com identação de 2 espaços
    vContFor := vArray.Format(2) + sLineBreak;
    vNomArqTemp := FNomArq + '.tmp';
    try
      TFile.WriteAllText(vNomArqTemp, vContFor, TEncoding.UTF8);

      if TFile.Exists(FNomArq) then
        TFile.Delete(FNomArq);

      TFile.Move(vNomArqTemp, FNomArq);
      Result := True;
    except
      on E: Exception do
      begin
        if TFile.Exists(vNomArqTemp) then
          TFile.Delete(vNomArqTemp);

        raise Exception.CreateFmt('Erro ao salvar o arquivo JSON: %s',
          [E.Message]);

        Result := False;
      end;
    end;
  finally
    vArray.Free;
  end;
end;

end.
