CREATE TABLE [clientes] (
  [id] bigint PRIMARY KEY IDENTITY(1, 1),
  [tipo] enum(PF,PJ) NOT NULL,
  [nome] nvarchar(255),
  [nome_fantasia] nvarchar(255),
  [razao_social] nvarchar(255),
  [cpf] nvarchar(255) UNIQUE,
  [cnpj] nvarchar(255) UNIQUE,
  [rg] nvarchar(255),
  [inscricao_estadual] nvarchar(255),
  [email] nvarchar(255) UNIQUE NOT NULL,
  [telefone] nvarchar(255),
  [data_nascimento] date,
  [status] enum(ATIVO,INATIVO),
  [criado_em] timestamp,
  [atualizado_em] timestamp
)
GO

CREATE TABLE [enderecos] (
  [id] bigint PRIMARY KEY IDENTITY(1, 1),
  [cliente_id] bigint NOT NULL,
  [cep] nvarchar(255),
  [logradouro] nvarchar(255),
  [numero] nvarchar(255),
  [complemento] nvarchar(255),
  [bairro] nvarchar(255),
  [cidade] nvarchar(255),
  [estado] nvarchar(255),
  [pais] nvarchar(255),
  [origem_dados] enum(MANUAL,API_CEP)
)
GO

CREATE TABLE [cliente_score] (
  [id] bigint PRIMARY KEY IDENTITY(1, 1),
  [cliente_id] bigint UNIQUE NOT NULL,
  [frequencia_pedidos] int,
  [ticket_medio] decimal,
  [inadimplencia_score] decimal,
  [score_final] decimal,
  [atualizado_em] timestamp
)
GO

CREATE TABLE [documentos] (
  [id] bigint PRIMARY KEY IDENTITY(1, 1),
  [cliente_id] bigint NOT NULL,
  [nome_arquivo] nvarchar(255),
  [tipo] enum(PDF,IMAGEM),
  [caminho] text,
  [criado_em] timestamp
)
GO

CREATE TABLE [pedidos] (
  [id] bigint PRIMARY KEY IDENTITY(1, 1),
  [cliente_id] bigint NOT NULL,
  [valor_total] decimal,
  [status] enum(PAGO,PENDENTE,CANCELADO),
  [data_pedido] timestamp
)
GO

CREATE TABLE [pagamentos] (
  [id] bigint PRIMARY KEY IDENTITY(1, 1),
  [pedido_id] bigint NOT NULL,
  [valor] decimal,
  [status] enum(PAGO,ATRASADO,PENDENTE),
  [data_pagamento] timestamp
)
GO

ALTER TABLE [enderecos] ADD FOREIGN KEY ([cliente_id]) REFERENCES [clientes] ([id])
GO

ALTER TABLE [cliente_score] ADD FOREIGN KEY ([cliente_id]) REFERENCES [clientes] ([id])
GO

ALTER TABLE [documentos] ADD FOREIGN KEY ([cliente_id]) REFERENCES [clientes] ([id])
GO

ALTER TABLE [pedidos] ADD FOREIGN KEY ([cliente_id]) REFERENCES [clientes] ([id])
GO

ALTER TABLE [pagamentos] ADD FOREIGN KEY ([pedido_id]) REFERENCES [pedidos] ([id])
GO
