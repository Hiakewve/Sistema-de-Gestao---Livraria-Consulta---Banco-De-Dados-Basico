-- Fazer inserções

INSERT INTO Tb_Categoria (nm_categoria, descricao)
VALUES ('Ficção', 'Livros de ficção em geral');

INSERT INTO Tb_Categoria (nm_categoria, descricao)
VALUES ('Programação', 'Livros sobre desenvolvimento e programação');

INSERT INTO Tb_Categoria (nm_categoria, descricao)
VALUES ('Ciência', 'Livros de ciência e divulgação científica');

INSERT INTO Tb_categoria (nm_categoria, descricao)
VALUES ('Administração', 'Gestão e negócios');

INSERT INTO Tb_Fornecedores (nm_fornecedor, telefone, email)
VALUES ('Editora Alfa', '79-9999-0001', 'contato@alfa.com');

INSERT INTO Tb_Fornecedores (nm_fornecedor, telefone, email)
VALUES ('Livros Brasil', '79-9999-0002', 'vendas@livrosbr.com');

INSERT INTO Tb_Fornecedores (nm_fornecedor, telefone, email)
VALUES ('Distribuidora X', NULL, NULL);

INSERT INTO Tb_Fornecedores (nm_fornecedor, telefone, email)
VALUES ('Editora Beta', '79-9999-0004', 'beta@editora.com');

INSERT INTO Tb_Livro (titulo, autor, cd_categoria, cd_fornecedor, preco, estoque)
VALUES ('O Mundo Perdido', 'Arthur N.', 1, 1, 49.90, 12);

INSERT INTO Tb_Livro (titulo, autor, cd_categoria, cd_fornecedor, preco, estoque)
VALUES ('Banco de Dados Simplificado', 'Carlos Silva', 2, 2, 79.90, 5);

INSERT INTO Tb_Livro (titulo, autor, cd_categoria, cd_fornecedor, preco, estoque)
VALUES ('Aprendendo SQL', 'Fernada Costa', 2, 2, 45.50, 20);

INSERT INTO Tb_Livro (titulo, autor, cd_categoria, cd_fornecedor, preco, estoque)
VALUES ('Ciência Fácil', 'Paulo Mendes', 3, 3, 59.90, 7);

INSERT INTO Tb_Livro (titulo, autor, cd_categoria, cd_fornecedor, preco, estoque)
VALUES ('Gestão Ágil', 'Mariana Sousa', 4, 4, 89.00, 3);

INSERT INTO Tb_Livro (titulo, autor, cd_categoria, cd_fornecedor, preco, estoque)
VALUES ('Algoritmos na Prática', 'Marcos Silva', 2, 1, 120.00, 2);

INSERT INTO Tb_Livro (titulo, autor, cd_categoria, cd_fornecedor, preco, estoque)
VALUES ('Romance Moderno', 'João Silva', 1, 4, 39.90, 10);

INSERT INTO Tb_Livro (titulo, autor, cd_categoria, cd_fornecedor, preco, estoque)
VALUES ('Administração 101', 'Paula Reis', 4, 3, 55.00, 8);

INSERT INTO Tb_Cliente (nm_cliente, email, telefone)
VALUES ('Maria Souza', 'maria@email.com', '79-98888-0001');

INSERT INTO Tb_Cliente (nm_cliente, email, telefone)
VALUES ('João Pereira', 'joao.pereira@email.com', NULL);

INSERT INTO Tb_Cliente (nm_cliente, email, telefone)
VALUES ('Ana Lima', NULL, '79-98888-0003');

INSERT INTO Tb_Cliente (nm_cliente, email, telefone)
VALUES ('Carlos Oliveira', 'carlos@oliveira.com', '79-98888-0004');

INSERT INTO Tb_Cliente (nm_cliente, email, telefone)
VALUES ('Beatriz Santos', 'beatriz@email.com', NULL);

INSERT INTO Tb_Departamento (nm_departamento)
VALUES ('Vendas');

INSERT INTO Tb_Departamento (nm_departamento)
VALUES ('TI');

INSERT INTO Tb_Departamento (nm_departamento)
VALUES ('Financeiro');

INSERT INTO Tb_Funcionario (nm_funcionario, cd_departamento)
VALUES ('Pedro Almeida', 1);

INSERT INTO Tb_Funcionario (nm_funcionario, cd_departamento)
VALUES ('Luiza Costa', 2);

INSERT INTO Tb_Funcionario (nm_funcionario, cd_departamento)
VALUES ('Ricardo Nunes', 1);

INSERT INTO Tb_Funcionario (nm_funcionario, cd_departamento)
VALUES ('Sofia Ramos', NULL)

INSERT INTO Tb_Pedido (cd_cliente, status)
VALUES (1, 'ABERTO');

INSERT INTO Tb_Pedido (cd_cliente, status)
VALUES (2, 'PAGO');

INSERT INTO Tb_Pedido (cd_cliente, status)
VALUES (3, 'CANCELADO');

INSERT INTO Tb_Pedido (cd_cliente, status)
VALUES (1, 'ABERTO');

INSERT INTO Tb_ItemPedido (cd_pedido, cd_livro, quantidade, vl_unitario)
VALUES (1,3,2,45.50);

INSERT INTO Tb_ItemPedido (cd_pedido, cd_livro, quantidade, vl_unitario)
VALUES (1,3,2,45.50),
(1,7,1,39.90);

INSERT INTO Tb_ItemPedido (cd_pedido, cd_livro, quantidade, vl_unitario)
VALUES (2,6,1,120.00);

INSERT INTO Tb_ItemPedido (cd_pedido, cd_livro, quantidade, vl_unitario)
VALUES (3,1,1,49.90);

INSERT INTO Tb_ItemPedido (cd_pedido, cd_livro, quantidade, vl_unitario)
VALUES (4,2,1,79.90),
(4,3,1,45.00);

-- inserir itens de pedidos, atualize valor_total de cada pedido somando vl_item dos seus itens
UPDATE dbo.Tb_Pedido
set valor_total = (
	SELECT SUM(vl_item) FROM dbo.Tb_ItemPedido
	WHERE cd_pedido = Tb_Pedido.cd_pedido
);

-- Tente inserir um livro com preco = -10.00 e observe o resultado (verifique a restrição CHECK, se houver).
INSERT INTO dbo.Tb_Livro (titulo, autor, cd_categoria, cd_fornecedor, preco, estoque)
VALUES ('O Brabo do BD', 'Hiakewve', 2, 2, -10.00, 10);

-- Tente inserir um fornecedor com nome duplicado (deve falhar devido a UNIQUE).
INSERT INTO Tb_Fornecedores (nm_fornecedor, telefone, email)
VALUES ('Editora Alfa', '79-9999-0001', 'contato@alfa.com');

-- Remova o cliente João e verifique se os pedidos desse cliente (e itens) foram removidos (por causa do ON DELETE CASCADE).
DELETE FROM dbo.Tb_Cliente
WHERE cd_cliente = 2;

-- Atualize o estoque do livro "Aprendendo SQL": subtraia 3 unidades (simule venda).
UPDATE dbo.Tb_Livro 
SET estoque = estoque - 3
WHERE titulo = 'Aprendendo SQL' AND cd_livro = 3;

-- Altere o status do Pedido 1 para 'PAGO'.
UPDATE dbo.Tb_Pedido
SET status = 'PAGO'
WHERE cd_pedido = 1;

-- Delete o livro "Administração 101" (cd_livro 8)
DELETE FROM dbo.Tb_Livro
WHERE cd_livro = 8;

-- Liste todos os livros (todas as colunas).
SELECT * FROM dbo.Tb_Livro;

-- Liste titulo, autor, preco dos livros da categoria “Programação”.
SELECT titulo, autor, preco FROM dbo.Tb_Livro
WHERE cd_categoria = 2;

-- Liste os clientes com emails (não nulos).
SELECT email FROM dbo.Tb_Cliente
WHERE email IS NOT NULL;

-- Liste os pedidos com o nome do cliente (use JOIN e alias).
SELECT cd_pedido, dt_pedido, status, nm_cliente FROM dbo.Tb_Pedido p
JOIN dbo.Tb_Cliente c ON p.cd_cliente = c.cd_cliente;

-- Liste os itens do Pedido 1 com titulo, quantidade, vl_unitario, vl_item (use JOIN entre Tb_ItemPedido e Tb_Livro).

-- Liste os funcionários e o nome do departamento (use LEFT JOIN para ver quem não tem departamento).

-- Liste os 3 livros mais caros (TOP 3) ordenados por preço decrescente.

-- Liste os fornecedores (nome) que não possuem telefone (telefone IS NULL).

-- Liste os autores distintos cadastrados.

-- Liste os livros cujo autor contenha 'Silva' (use LIKE).

-- Liste os pedidos com valor_total maior que 100 (use where com value).

-- Use ORDER BY para listar clientes por dt_cadastro (mais recente primeiro).

-- Use DISTINCT para listar todos os valores distintos de status em Tb_Pedido.