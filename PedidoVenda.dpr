program PedidoVenda;

uses
  Vcl.Forms,
  PedidoVendaU in 'PedidoVendaU.pas' {PedidoVendaF},
  DMU in 'DMU.pas' {DM: TDataModule},
  PedidoDAO in 'DAO\PedidoDAO.pas',
  PedidoU in 'Modelo\PedidoU.pas',
  PedidoController in 'controller\PedidoController.pas',
  PedidoProdutoController in 'controller\PedidoProdutoController.pas',
  PedidoProdutoDAO in 'DAO\PedidoProdutoDAO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPedidoVendaF, PedidoVendaF);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
