unit PedidoVendaU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, PedidoU, Vcl.StdCtrls,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids;

type
  TPedidoVendaF = class(TForm)
    PenelPedido: TPanel;
    PanelProduto: TPanel;
    pnlRodape: TPanel;
    pnlItem: TPanel;
    qryConsultaCliente: TFDQuery;
    qryConsultaProduto: TFDQuery;
    edtCodCliente: TEdit;
    edtNomeCliente: TEdit;
    edtCidade: TEdit;
    edtDataEmissao: TEdit;
    edtNumeroPedido: TEdit;
    lblCodCliente: TLabel;
    lblNomeCliente: TLabel;
    lblCidade: TLabel;
    lblNPedido: TLabel;
    lblUF: TLabel;
    lblDataEmissao: TLabel;
    edtUF: TEdit;
    edtCodigoProduto: TEdit;
    edtVlrUnt: TEdit;
    edtQuntidadeProduto: TEdit;
    lblCodProduto: TLabel;
    LblQtd: TLabel;
    Label3: TLabel;
    btnAddProduto: TButton;
    gridPedidoPorduto: TDBGrid;
    dsPedidoProduto: TDataSource;
    MemTablePedidoProduto: TFDMemTable;
    MemTablePedidoProdutoCODPRODUTO: TIntegerField;
    MemTablePedidoProdutoDESCPRODUTO: TStringField;
    MemTablePedidoProdutoQUANTIDADE: TFMTBCDField;
    MemTablePedidoProdutoVLRUNT: TFMTBCDField;
    MemTablePedidoProdutoVLRTOTAL: TFMTBCDField;
    lblTotal: TLabel;
    btnGravar: TButton;
    btnDeletarPedido: TButton;
    btnBuscaPedido: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAddProdutoClick(Sender: TObject);
    procedure gridPedidoPordutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure btnDeletarPedidoClick(Sender: TObject);
    procedure edtCodClienteExit(Sender: TObject);
    procedure btnBuscaPedidoClick(Sender: TObject);
  private
    { Private declarations }
    FPedido: TPedido;

    procedure setDadosPedido();
    procedure calcularTotal();
    procedure cleanItem();
    procedure cleanPedido();
    procedure cleanMemTable();
    procedure carregaParceiro;
  public
    { Public declarations }
  end;

var
  PedidoVendaF: TPedidoVendaF;

implementation

{$R *.dfm}

uses DMU, PedidoDAO, PedidoController, System.SysUtils,
  PedidoProdutoController, PedidoProdutoDAO;

procedure TPedidoVendaF.btnAddProdutoClick(Sender: TObject);
var
  pedidoProdutoController: TPedidoProdutoController;
begin

  if (Trim(edtCodCliente.Text) <> '') and
  (qryConsultaProduto.Locate('CODIGO',StrToInt(edtCodigoProduto.Text), [])) then
  begin

    pedidoProdutoController := TPedidoProdutoController.Create;
    try

      pedidoProdutoController.setMenTablePedidoProduto(qryConsultaProduto, StrToCurrDef(edtQuntidadeProduto.Text, 0
        ), StrToCurrDef(edtVlrUnt.Text,0), MemTablePedidoProduto);

      calcularTotal();

      cleanItem();

    finally
      FreeAndNil(pedidoProdutoController);
    end;

  end
  else if (Trim(edtCodCliente.Text) = '') then
    ShowMessage('Para adicionar um item ? necess?rio informar o Cliente!')
  else
    ShowMessage('Produto n?o encontrado na base!');
end;

procedure TPedidoVendaF.btnBuscaPedidoClick(Sender: TObject);
var
 numeroPedido: String;
 pedidoDAO: TPedidoDAO;
begin
  if not InputQuery('Numero Pedido:','Pedido', numeroPedido) then
    Exit;

  pedidoDAO := TPedidoDAO.Create;
  try

    pedidoDAO.buscaVenda(FPedido, MemTablePedidoProduto, StrToInt(numeroPedido));

    calcularTotal();

    qryConsultaCliente.Locate('CODIGO', FPedido.codigoCliente, []);

    setDadosPedido();

  finally

    FreeAndNil(pedidoDAO);

  end;
end;

procedure TPedidoVendaF.btnDeletarPedidoClick(Sender: TObject);
var
  numeroPedido: String;
  pedidoProdutoDAO: TPedidoProdutoDAO;
  pedidoDAO: TPedidoDAO;
begin
  if not InputQuery('Numero Pedido:','Pedido', numeroPedido) then
    Exit;

  pedidoProdutoDAO := TPedidoProdutoDAO.Create();
  pedidoDAO := TPedidoDAO.Create();
  try

    try

      DM.Conexao.StartTransaction;

      pedidoProdutoDAO.delete(StrToInt(numeroPedido), DM.Conexao );
      pedidoDAO.deleta(StrToInt(numeroPedido), DM.Conexao);

      DM.Conexao.Commit;

    except
      on E: Exception do
      begin

        DM.Conexao.Rollback;
        ShowMessage('Erro ao Deleta pedido :' + E.Message);
      end;
    end;

  finally

    FreeAndNil(pedidoProdutoDAO);
    FreeAndNil(pedidoDAO);

  end;




end;

procedure TPedidoVendaF.btnGravarClick(Sender: TObject);
var
  pedidoDAO: TPedidoDAO;
  pedidoProdutoDAO: TPedidoProdutoDAO;
begin

  pedidoDAO := TPedidoDAO.Create;
  pedidoProdutoDAO := TPedidoProdutoDAO.Create;
  try
    DM.Conexao.StartTransaction;
    try

      pedidoDAO.gravarPedido(FPedido, DM.Conexao);
      pedidoProdutoDAO.gravar(MemTablePedidoProduto, DM.Conexao, FPedido);

      DM.Conexao.Commit;

      ShowMessage('Pedido salvo com sucesso!');

    except
      on E: Exception do
      begin
        DM.Conexao.Rollback;
        ShowMessage('Erro ao salvar pedido : '+ e.Message);
      end;
    end;

  finally
    FreeAndNil(pedidoDAO);
    FreeAndNil(pedidoProdutoDAO);

    cleanItem();
    cleanPedido();
    cleanMemTable();
  end;

end;

procedure TPedidoVendaF.calcularTotal;
var
  total: Currency;
begin

  Total := 0;

  MemTablePedidoProduto.First;

  while not (MemTablePedidoProduto.Eof) do
  begin

    total := total + MemTablePedidoProdutoVLRTOTAL.AsCurrency;

    MemTablePedidoProduto.Next

  end;

  lblTotal.Caption := 'Total Pedido: ' + CurrToStr(total);

  FPedido.valorTotal := total;

end;

procedure TPedidoVendaF.cleanItem;
begin

  edtCodigoProduto.Clear;
  edtQuntidadeProduto.Clear;
  edtVlrUnt.Clear;

end;

procedure TPedidoVendaF.cleanMemTable;
begin

  MemTablePedidoProduto.First;

  while not(MemTablePedidoProduto.Eof) do
  begin

    MemTablePedidoProduto.Delete;

    MemTablePedidoProduto.Next;

  end;
end;

procedure TPedidoVendaF.carregaParceiro;
var
  pedidoController: TPedidoController;
begin

  if qryConsultaCliente.Locate('CODIGO', StrToInt(edtCodCliente.Text), []) then
  begin
    pedidoController := TPedidoController.Create;
    try
      pedidoController.setPedido(qryConsultaCliente, FPedido);
      setDadosPedido;
    finally
      FreeAndNil(pedidoController);
    end;
  end
  else
    ShowMessage('Cliente com o codigo  ' + edtCodCliente.Text + 'n?o encontrado na base!');
end;

procedure TPedidoVendaF.cleanPedido;
begin

  edtCodCliente.Clear;
  edtNomeCliente.Clear;
  edtCidade.Clear;
  edtDataEmissao.Clear;
  edtNumeroPedido.Clear;
  edtUF.Clear;
  edtCodigoProduto.Clear;
  edtVlrUnt.Clear;
  edtQuntidadeProduto.Clear;
  btnDeletarPedido.Enabled := True;
  btnBuscaPedido.Enabled := True;

end;

procedure TPedidoVendaF.edtCodClienteExit(Sender: TObject);
begin
  if (Trim( edtCodCliente.Text) <> '') then
  begin
    carregaParceiro();
    btnDeletarPedido.Enabled := False;
    btnBuscaPedido.Enabled := False;
  end;
end;

procedure TPedidoVendaF.edtCodClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_RETURN then
  begin
    carregaParceiro();;
  end;

end;

procedure TPedidoVendaF.FormDestroy(Sender: TObject);
begin

  FreeAndNil(FPedido);

end;

procedure TPedidoVendaF.FormShow(Sender: TObject);
var
  pedidoDAO: TPedidoDAO;
begin

  pedidoDAO := TPedidoDAO.Create;
  try
    pedidoDAO.AbreQRY(qryConsultaCliente);
    pedidoDAO.AbreQRY(qryConsultaProduto);
  finally
    FreeAndNil(pedidoDAO);
  end;

  FPedido := TPedido.Create;

  MemTablePedidoProduto.Close;
  MemTablePedidoProduto.Open;

end;

procedure TPedidoVendaF.gridPedidoPordutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_DELETE then
  begin
    if Application.MessageBox(PChar('Deseja realmente deletar o tiem de codigo :'+ MemTablePedidoProdutoCODPRODUTO.AsString),
      'Alerta',mb_yesno + mb_iconquestion) = id_yes then
    begin

      MemTablePedidoProduto.Delete;
      calcularTotal();

    end;
  end;

end;

procedure TPedidoVendaF.setDadosPedido;
begin

  edtNomeCliente.Text := qryConsultaCliente.FieldByName('NOME').AsString;
  edtCidade.Text := qryConsultaCliente.FieldByName('CIDADE').AsString;
  edtCodCliente.Text := qryConsultaCliente.FieldByName('CODIGO').AsString;
  edtDataEmissao.Text := FormatDateTime('DD/MM/YYYY', FPedido.dataEmissao);
  edtNumeroPedido.Text := IntToStr(FPedido.numeroPedido);
  edtUF.Text := qryConsultaCliente.FieldByName('UF').AsString;

end;

end.
