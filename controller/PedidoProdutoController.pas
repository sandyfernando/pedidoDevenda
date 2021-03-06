unit PedidoProdutoController;

interface

uses
  FireDAC.Comp.Client;
type
  TPedidoProdutoController = class
    private

    public
      procedure setMenTablePedidoProduto(const qry: TFDQuery; const quantidade, vlrUnit: Currency;
        var memTable: TFDMemTable);
  end;

implementation

{ TPedidoProdutoController }

procedure TPedidoProdutoController.setMenTablePedidoProduto(const qry: TFDQuery;
  const quantidade, vlrUnit: Currency; var memTable: TFDMemTable);
begin
  memTable.Append;

  memTable.FieldByName('CODPRODUTO').AsInteger := qry.FieldByName('CODIGO').AsInteger;
  memTable.FieldByName('DESCPRODUTO').AsString := qry.FieldByName('DESCRICAO').AsString;
  memTable.FieldByName('QUANTIDADE').AsCurrency := quantidade;
  memTable.FieldByName('VLRUNT').AsCurrency := vlrUnit;
  memTable.FieldByName('VLRTOTAL').AsCurrency := quantidade * vlrUnit ;

  memTable.Post;
end;

end.
