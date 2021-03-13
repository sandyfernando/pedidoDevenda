unit PedidoU;

interface

uses
  System.SysUtils;
type
  TPedido = Class
    private
    FNumeroPedido: Integer;
    FCodigoCliente: Integer;
    FValorTotal: Double;
    FDataEmissao: TDate;

    public

    published
      property numeroPedido:  Integer read FNumeroPedido  write FNumeroPedido;
      property dataEmissao:   TDate   read FDataEmissao   write FDataEmissao;
      property codigoCliente: Integer read FCodigoCliente write FCodigoCliente;
      property valorTotal :   Double  read FValorTotal    write FValorTotal;

  End;


implementation


end.
