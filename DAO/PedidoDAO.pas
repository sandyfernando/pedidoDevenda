unit PedidoDAO;

interface

uses
  FireDAC.Comp.Client, PedidoU;
type
  TPedidoDAO = class
    private

    public
      procedure AbreQRY(var qry: Tfdquery);
      function retornaUltimoNumPedido(): Integer;
      procedure gravarPedido(const pedido: TPedido; const conexao: TFDConnection);
      procedure deleta(const NumeroPedido: Integer; const conexao: TFDConnection);
      procedure buscaVenda(var pedido: TPedido; var memTable:TFDMemTable; const numeroPedido: Integer);
  end;

implementation

uses
  Vcl.Dialogs, DMU, System.SysUtils;

{ TPedidoDAO }

procedure TPedidoDAO.AbreQRY(var qry: Tfdquery);
begin

  qry.Close;
  qry.Open();

  if qry.IsEmpty then
    showmessage(qry.Name + 'N?o resulto dados.')

end;

procedure TPedidoDAO.buscaVenda(var pedido: TPedido; var memTable: TFDMemTable;
  const numeroPedido: Integer);
var
  qry: TFDQuery;
begin

  qry := TFDQuery.Create(nil);
  try

    qry.Connection := DM.Conexao;

    qry.SQL.Text :=
      'SELECT '+
      ' * '+
      'FROM pedidodadosgerais PG '+
      'INNER JOIN pedidoprodutos PP ON PG.NumeroPedido = PP.NumeroPedido '+
      'INNER JOIN cadproduto CP ON PP.CodigoProduto = CP.Codigo '+
      'INNER JOIN cadcliente CC ON PG.CodigoCliente = CC.CODIGO '+
      'WHERE PG.NumeroPedido = :NUMEROPEDIDO ';

    qry.Params[0].AsInteger := numeroPedido;

    qry.Open;

    pedido.numeroPedido := qry.FieldByName('NUMEROPEDIDO').AsInteger;
    pedido.dataEmissao :=  qry.FieldByName('DATAEMISSAO').AsDateTime;
    pedido.codigoCliente := qry.FieldByName('CODIGOCLIENTE').AsInteger;
    pedido.valorTotal := qry.FieldByName('VALORTOTAL').AsCurrency;

    qry.First;

    while not(qry.Eof) do
    begin
      memTable.Append;

      memTable.FieldByName('CODPRODUTO').AsInteger := qry.FieldByName('CODIGOPRODUTO').AsInteger;
      memTable.FieldByName('DESCPRODUTO').AsString := qry.FieldByName('DESCRICAO').AsString;
      memTable.FieldByName('QUANTIDADE').AsCurrency := qry.FieldByName('QUANTIDADE').AsCurrency;
      memTable.FieldByName('VLRUNT').AsCurrency := qry.FieldByName('VLRUNITARIO').AsCurrency;
      memTable.FieldByName('VLRTOTAL').AsCurrency := qry.FieldByName('VLRTOTAL').AsCurrency;

      memTable.Post;

      qry.Next;

    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPedidoDAO.deleta(const NumeroPedido: Integer; const conexao: TFDConnection);
var
  qry: TFDQuery;
begin

  qry := TFDQuery.Create(nil);
  try

    qry.Connection := conexao;

    qry.SQL.Text := 'DELETE FROM PEDIDODADOSGERAIS WHERE NUMEROPEDIDO = :NUMEROPEDIDO ';

    qry.Params[0].AsInteger := NumeroPedido;

    QRY.ExecSQL

  finally
    FreeAndNil(qry);
  end;

end;

procedure TPedidoDAO.gravarPedido(const pedido: TPedido; const conexao: TFDConnection);
var
  qry: TFDQuery;
begin

  qry := TFDQuery.Create(nil);
  try

    try

      qry.Connection := conexao;

      qry.SQL.Text :=
        ' INSERT INTO PEDIDODADOSGERAIS ( '+
        '  NUMEROPEDIDO, '+
        '  DATAEMISSAO, '+
        '  CODIGOCLIENTE, '+
        '  VALORTOTAL )'+
        ' VALUES ('+
        '  :NUMEROPEDIDO, '+
        '  :DATAEMISSAO, '+
        '  :CODIGOCLIENTE, '+
        '  :VALORTOTAL )';

      qry.ParamByName('NUMEROPEDIDO').AsInteger := pedido.numeroPedido;
      qry.ParamByName('DATAEMISSAO').AsDateTime := pedido.dataEmissao;
      qry.ParamByName('CODIGOCLIENTE').AsInteger := pedido.codigoCliente;
      qry.ParamByName('VALORTOTAL').AsCurrency := pedido.valorTotal;

      qry.ExecSQL

    except
      on E: Exception do
      begin
        raise;
      end;
    end;

  finally
    FreeAndNil(qry);
  end;

end;

function TPedidoDAO.retornaUltimoNumPedido: Integer;
var
  qry: TFDQuery;
begin

  qry := TFDQuery.Create(nil);
  try
    qry.Connection := dm.Conexao;

    qry.SQL.Text :=
      'SELECT MAX(NUMEROPEDIDO) '+
      'FROM PEDIDODADOSGERAIS ';

    qry.Open();

    if (qry.Fields[0].AsInteger = 0) then
      result := 1
    else
      result := qry.Fields[0].AsInteger + 1

  finally
    FreeAndNil(qry)
  end;

end;

end.
