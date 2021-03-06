unit PedidoController;

interface

uses
  FireDAC.Comp.Client, PedidoU;
type
  TPedidoController = class
    private

    public
      procedure setPedido(const qry: TFDQuery; var pedido: TPedido);

  end;

implementation

uses
  System.SysUtils, PedidoDAO;

{ TPedidoController }


procedure TPedidoController.setPedido(const qry: TFDQuery; var pedido: TPedido);
var
  pedidoDAO: TPedidoDAO;
begin

  pedidoDAO := TPedidoDAO.Create;
  try

    pedido.codigoCliente := qry.FieldByName('CODIGO').AsInteger;
    pedido.dataEmissao := now;
    pedido.numeroPedido := pedidoDAO.retornaUltimoNumPedido;

  finally
   FreeAndNil(pedidoDAO)
  end;

end;

end.
