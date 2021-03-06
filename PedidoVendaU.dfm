object PedidoVendaF: TPedidoVendaF
  Left = 0
  Top = 0
  Caption = 'Pedido Venda'
  ClientHeight = 487
  ClientWidth = 986
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PenelPedido: TPanel
    Left = 0
    Top = 0
    Width = 986
    Height = 57
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 1
    ExplicitTop = -5
    DesignSize = (
      986
      57)
    object lblCodCliente: TLabel
      Left = 12
      Top = 7
      Width = 76
      Height = 13
      Caption = 'Codigo Cliente: '
    end
    object lblNomeCliente: TLabel
      Left = 183
      Top = 7
      Width = 34
      Height = 13
      Caption = 'Nome: '
    end
    object lblCidade: TLabel
      Left = 12
      Top = 33
      Width = 40
      Height = 13
      Caption = 'Cidade: '
    end
    object lblNPedido: TLabel
      Left = 592
      Top = 7
      Width = 54
      Height = 13
      Caption = 'N'#176' Pedido: '
    end
    object lblUF: TLabel
      Left = 254
      Top = 34
      Width = 17
      Height = 13
      Caption = 'UF:'
    end
    object lblDataEmissao: TLabel
      Left = 310
      Top = 34
      Width = 71
      Height = 13
      Caption = 'Data Emiss'#227'o: '
    end
    object edtCodCliente: TEdit
      Left = 90
      Top = 4
      Width = 87
      Height = 21
      TabOrder = 0
      OnExit = edtCodClienteExit
      OnKeyDown = edtCodClienteKeyDown
    end
    object edtNomeCliente: TEdit
      Left = 216
      Top = 4
      Width = 371
      Height = 21
      Enabled = False
      TabOrder = 1
    end
    object edtCidade: TEdit
      Left = 90
      Top = 31
      Width = 158
      Height = 21
      Enabled = False
      TabOrder = 3
    end
    object edtDataEmissao: TEdit
      Left = 385
      Top = 31
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 5
    end
    object edtNumeroPedido: TEdit
      Left = 648
      Top = 4
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 2
    end
    object edtUF: TEdit
      Left = 277
      Top = 31
      Width = 27
      Height = 21
      Enabled = False
      TabOrder = 4
    end
    object btnDeletarPedido: TButton
      Left = 888
      Top = 2
      Width = 89
      Height = 25
      Anchors = [akTop, akRight, akBottom]
      Caption = 'Deletar Pedido'
      TabOrder = 6
      OnClick = btnDeletarPedidoClick
    end
    object btnBuscaPedido: TButton
      Left = 888
      Top = 29
      Width = 89
      Height = 25
      Anchors = [akTop, akRight, akBottom]
      Caption = 'Buscar Pedido'
      TabOrder = 7
      OnClick = btnBuscaPedidoClick
    end
  end
  object PanelProduto: TPanel
    Left = 0
    Top = 57
    Width = 986
    Height = 367
    Align = alClient
    TabOrder = 1
    ExplicitTop = 97
    ExplicitHeight = 336
    object pnlItem: TPanel
      Left = 1
      Top = 1
      Width = 984
      Height = 41
      Align = alTop
      TabOrder = 0
      ExplicitLeft = 488
      ExplicitTop = 120
      ExplicitWidth = 185
      object lblCodProduto: TLabel
        Left = 11
        Top = 14
        Width = 68
        Height = 13
        Caption = 'Cod. Produto:'
      end
      object LblQtd: TLabel
        Left = 216
        Top = 14
        Width = 22
        Height = 13
        Caption = 'Qtd:'
      end
      object Label3: TLabel
        Left = 380
        Top = 14
        Width = 60
        Height = 13
        Caption = 'Vlr. Unitario:'
      end
      object edtCodigoProduto: TEdit
        Left = 89
        Top = 11
        Width = 121
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object edtVlrUnt: TEdit
        Left = 448
        Top = 11
        Width = 121
        Height = 21
        TabOrder = 2
      end
      object edtQuntidadeProduto: TEdit
        Left = 253
        Top = 11
        Width = 121
        Height = 21
        TabOrder = 1
      end
      object btnAddProduto: TButton
        Left = 577
        Top = 9
        Width = 75
        Height = 25
        Hint = 'Adicinar Item ao Pedido'
        Caption = 'Add Item'
        TabOrder = 3
        OnClick = btnAddProdutoClick
      end
    end
    object gridPedidoPorduto: TDBGrid
      Left = 1
      Top = 42
      Width = 984
      Height = 324
      Align = alClient
      DataSource = dsPedidoProduto
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyDown = gridPedidoPordutoKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'CODPRODUTO'
          Title.Caption = 'c'#243'digo do produto'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCPRODUTO'
          Title.Caption = 'descri'#231#227'o do produto'
          Width = 369
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTIDADE'
          Title.Caption = 'quantidade'
          Width = 76
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VLRUNT'
          Title.Caption = 'vlr. unit'#225'rio'
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VLRTOTAL'
          Title.Caption = 'vlr. total'
          Width = 72
          Visible = True
        end>
    end
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 424
    Width = 986
    Height = 63
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      986
      63)
    object lblTotal: TLabel
      Left = 12
      Top = 21
      Width = 163
      Height = 23
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akBottom]
      Caption = 'Total pedido: 0.0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnGravar: TButton
      Left = 902
      Top = 24
      Width = 75
      Height = 25
      Anchors = [akTop, akRight, akBottom]
      Caption = 'Gravar'
      TabOrder = 0
      OnClick = btnGravarClick
    end
  end
  object qryConsultaCliente: TFDQuery
    Connection = DM.Conexao
    SQL.Strings = (
      'SELECT '
      '* '
      'FROM CADCLIENTE')
    Left = 712
    Top = 120
  end
  object qryConsultaProduto: TFDQuery
    Connection = DM.Conexao
    SQL.Strings = (
      'SELECT '
      '* '
      'FROM CADPRODUTO')
    Left = 808
    Top = 128
  end
  object dsPedidoProduto: TDataSource
    DataSet = MemTablePedidoProduto
    Left = 208
    Top = 241
  end
  object MemTablePedidoProduto: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 392
    Top = 193
    object MemTablePedidoProdutoCODPRODUTO: TIntegerField
      FieldName = 'CODPRODUTO'
    end
    object MemTablePedidoProdutoDESCPRODUTO: TStringField
      FieldName = 'DESCPRODUTO'
    end
    object MemTablePedidoProdutoQUANTIDADE: TFMTBCDField
      FieldName = 'QUANTIDADE'
    end
    object MemTablePedidoProdutoVLRUNT: TFMTBCDField
      FieldName = 'VLRUNT'
    end
    object MemTablePedidoProdutoVLRTOTAL: TFMTBCDField
      FieldName = 'VLRTOTAL'
    end
  end
end
