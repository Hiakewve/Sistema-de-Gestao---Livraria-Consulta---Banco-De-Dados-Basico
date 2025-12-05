-- Criar Tabelas

CREATE TABLE Tb_Categoria (
	cd_categoria int IDENTITY(1,1) PRIMARY KEY,
	nm_categoria varchar(50) NOT NULL,
	descricao varchar(200) NULL
)

CREATE TABLE Tb_Fornecedores (
	cd_fornecedor int IDENTITY(1,1) PRIMARY KEY,
	nm_fornecedor varchar(100) UNIQUE NOT NULL,
	telefone varchar(20) NULL,
	email varchar(100) NULL
)

CREATE TABLE Tb_Livro (
	cd_livro int IDENTITY(1,1) PRIMARY KEY,
	titulo varchar(150) NOT NULL,
	autor varchar(100) NOT NULL,
	cd_categoria int NULL,
	FOREIGN KEY (cd_categoria) REFERENCES Tb_Categoria(cd_categoria),
	cd_fornecedor int NULL, 
	FOREIGN KEY (cd_fornecedor) REFERENCES Tb_Fornecedores(cd_fornecedor),
	preco numeric(10,2) NOT NULL,
	estoque int NOT NULL DEFAULT 0,
	vl_estoque AS (preco * estoque) PERSISTED
)

CREATE TABLE Tb_Cliente (
	cd_cliente int IDENTITY(1,1) PRIMARY KEY,
	nm_cliente varchar(100) NOT NULL,
	email varchar(100) NULL UNIQUE,
	telefone varchar(20) NULL, 
	dt_cadastro datetime DEFAULT GETDATE()
)

CREATE TABLE Tb_Pedido (
	cd_pedido int IDENTITY(1,1) PRIMARY KEY,
	cd_cliente int NOT NULL, 
	FOREIGN KEY (cd_cliente) REFERENCES Tb_Cliente(cd_cliente) ON DELETE CASCADE,
	dt_pedido datetime DEFAULT GETDATE(),
	status varchar(20) DEFAULT 'ABERTO' CHECK(status IN ('ABERTO', 'PAGO', 'CANCELADO')),
	valor_total numeric(15,2) DEFAULT 0.00
)

CREATE TABLE Tb_ItemPedido (
	cd_item int IDENTITY(1,1) PRIMARY KEY,
	cd_pedido int NOT NULL,
	FOREIGN KEY (cd_pedido) REFERENCES Tb_Pedido (cd_pedido) ON DELETE CASCADE,
	cd_livro int NOT NULL,
	FOREIGN KEY (cd_livro) REFERENCES Tb_Livro (cd_livro),
	quantidade int NOT NULL CHECK (quantidade > 0),
	vl_unitario numeric(10,2) NOT NULL,
	vl_item AS (quantidade * vl_unitario) PERSISTED
)

CREATE TABLE Tb_Departamento (
	cd_departamento int IDENTITY(1,1) PRIMARY KEY,
	nm_departamento varchar(50) NOT NULL UNIQUE,
)

CREATE TABLE Tb_Funcionario (
	matricula int IDENTITY(1000,1) PRIMARY KEY,
	nm_funcionario varchar(100) NOT NULL,
	cd_departamento int NULL,
	FOREIGN KEY (cd_departamento) REFERENCES Tb_Departamento (cd_departamento),
	dt_admissao datetime DEFAULT GETDATE()
)

