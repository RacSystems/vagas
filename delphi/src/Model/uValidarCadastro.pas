unit uValidarCadastro;

interface

uses
  System.SysUtils, System.RegularExpressions;

type
  EValidacao = class(Exception);

  TValidarCadastro = class
  public
    class procedure ValidarNome(const Nome: string);
    class procedure ValidarEmail(const Email: string);
  end;

implementation

class procedure TValidarCadastro.ValidarNome(const Nome: string);
begin
  if Trim(Nome) = '' then
    raise EValidacao.Create('O campo Nome é obrigatório!');
end;

class procedure TValidarCadastro.ValidarEmail(const Email: string);
const
  EMAIL_REGEX = '^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$';
begin
  if Trim(Email) = '' then
    raise EValidacao.Create('O campo E-mail é obrigatório!');

  if not TRegEx.IsMatch(Email, EMAIL_REGEX, [roIgnoreCase]) then
    raise EValidacao.Create('E-mail inválido!');
end;

end.

