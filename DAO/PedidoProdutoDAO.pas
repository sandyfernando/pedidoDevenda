unit PedidoProdutoDAO;

interface

uses
  FireDAC.Comp.Client, PedidoU;
type
  TPedidoProdutoDAO = class
    public
      procedure gravar(const memTable: TFDMemTable; const conexao: TFDConnection;
        const pedido: TPedido);
      procedure delete(const NumeroPedido: Integer; const conexao: TFDConnection);

  end;

implementation

uses
  System.SysUtils;

{ TPedidoProdutoDAO }

procedure TPedidoProdutoDAO.delete(const NumeroPedido: Integer;
  const conexao: TFDConnection);
var
  qry: TFDQuery;
begin

  qry := TFDQuery.Create(nil);
  try

    qry.Connection := conexao;

    qry.SQL.Text := 'DELETE FROM PEDIDOPRODUTOS WHERE NUMEROPEDIDO = :NUMEROPEDIDO ';

    qry.Params[0].AsInteger := NumeroPedido;

    QRY.ExecSQL

  finally
    FreeAndNil(qry);
  end;
end;

procedure TPedidoProdutoDAO.gravar(const memTable: TFDMemTable;
  const conexao: TFDConnection; const pedido: TPedido);
var
  qry: TFDQuery;
begin

  qry := TFDQuery.Create(nil);
  try
    try

      qry.Connection := conexao;

      memTable.First;

      while not(memTable.Eof) do
      begin

        qry.SQL.Text :=
          ' INSERT INTO PEDIDOPRODUTOS ( '+
          '  NUMEROPEDIDO, '+
          '  CODIGOPRODUTO, '+
          '  QUANTIDADE, '+
          '  VLRUNITARIO, '+
          '  VLRTOTAL )'+
          ' VALUES ('+
          '  :NUMEROPEDIDO, '+
          '  :CODIGOPRODUTO, '+
          '  :QUANTIDADE, '+
          '  :VLRUNITARIO, '+
          '  :VLRTOTAL )';

        qry.ParamByName('NUMEROPEDIDO').AsInteger := pedido.numeroPedido;
        qry.ParamByName('CODIGOPRODUTO').AsInteger := memTable.FieldByName('CODPRODUTO').AsInteger;
        qry.ParamByName('QUANTIDADE').AsCurrency := memTable.FieldByName('QUANTIDADE').AsCurrency;
        qry.ParamByName('VLRUNITARIO').AsCurrency := memTable.FieldByName('VLRUNT').AsCurrency;;
        qry.ParamByName('VLRTOTAL').AsCurrency := memTable.FieldByName('VLRTOTAL').AsCurrency;;

        qry.ExecSQL;

        memTable.Next;
      end;

    except
      on E: Exception do
      begin
        raise
      end;
    end;

  finally

    FreeAndNil(qry);

  end;

end;

end.
