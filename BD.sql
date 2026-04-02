CREATE TABLE [propostas] (
  [id_proposta] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [nome_cliente] string,
  [nome_produto] string,
  [valor_proposta] integer,
  [proposta_aceita] bolean
)
GO

CREATE TABLE [orcamentos] (
  [id_orcamento] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [id_produto] integer,
  [nome_produto] integer,
  [valor_orcamento] integer NOT NULL
)
GO

CREATE TABLE [pedidos] (
  [id_pedidos] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [quantidade_pedidos] integer,
  [valor_total_pedidos] integer,
  [nome_cliente] string,
  [cpf_cliente] integer,
  [cnpj_cliente] string
)
GO

CREATE TABLE [clientes] (
  [id_cliente] integer NOT NULL IDENTITY(1, 1),
  [nome_cliente] string,
  [cpf_ciente] integer,
  [endereco_cliente] string,
  [email_cliente] string,
  [nome_empresa] string,
  [cnpj] sring
)
GO

CREATE TABLE [produtos] (
  [id_produto] integer NOT NULL IDENTITY(1, 1),
  [nome_produto] string,
  [tipo_produto] string,
  [preco_produto] integer,
  [quantidade_produto] integer
)
GO

CREATE TABLE [empresas] (
  [id_empresa] integer PRIMARY KEY,
  [razao_social] string,
  [nome_empresa] string
)
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Verdadeiro para aceita e falso para rejeitada',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'propostas',
@level2type = N'Column', @level2name = 'proposta_aceita';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Deve ser puxado do cadastro de clientes como foreign key',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'clientes',
@level2type = N'Column', @level2name = 'id_cliente';
GO

ALTER TABLE [propostas] ADD FOREIGN KEY ([nome_cliente]) REFERENCES [clientes] ([nome_cliente])
GO

ALTER TABLE [propostas] ADD FOREIGN KEY ([nome_produto]) REFERENCES [produtos] ([nome_produto])
GO

ALTER TABLE [orcamentos] ADD FOREIGN KEY ([id_produto]) REFERENCES [produtos] ([id_produto])
GO

ALTER TABLE [orcamentos] ADD FOREIGN KEY ([nome_produto]) REFERENCES [produtos] ([nome_produto])
GO

ALTER TABLE [pedidos] ADD FOREIGN KEY ([valor_total_pedidos]) REFERENCES [orcamentos] ([valor_orcamento])
GO

ALTER TABLE [pedidos] ADD FOREIGN KEY ([nome_cliente]) REFERENCES [clientes] ([nome_cliente])
GO

ALTER TABLE [pedidos] ADD FOREIGN KEY ([cpf_cliente]) REFERENCES [clientes] ([cpf_ciente])
GO

ALTER TABLE [pedidos] ADD FOREIGN KEY ([cnpj_cliente]) REFERENCES [clientes] ([cpf_ciente])
GO

ALTER TABLE [clientes] ADD FOREIGN KEY ([nome_empresa]) REFERENCES [empresas] ([nome_empresa])
GO

ALTER TABLE [clientes] ADD FOREIGN KEY ([cnpj]) REFERENCES [empresas] ([razao_social])
GO
