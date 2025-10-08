program TesteTecnico;

uses
  Vcl.Forms,
  uCadCliente in 'uCadCliente.pas' {CadCliente},
  uCliente in 'Units\uCliente.pas',
  uClienteDAO in 'Units\uClienteDAO.pas',
  uClienteList in 'Units\uClienteList.pas',
  UValidacaoDocumento in 'Units\UValidacaoDocumento.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TCadCliente, CadCliente);
  Application.Run;
end.
