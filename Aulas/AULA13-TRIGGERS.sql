-- AULA 23/10/2026 -- TRIGGERS
CREATE TRIGGER trg_after_insert_dpt
ON departamento
AFTER INSERT 
AS
BEGIN 
	PRINT 'Olá meu primeiro TRIGGER!'
END;
GO

INSERT INTO departamento (Dnumero, Dnome)
VALUES (88, 'Expedição');

SELECT * FROM departamento;

GO

CREATE TRIGGER tg_indteadof_delete_dpt
ON departamento
INSTEAD OF DELETE
AS 
BEGIN
	PRINT 'NÃO DELETEI O REGISTRO';
END

DELETE 
FROM departamento
WHERE Dnumero = 88;

SELECT * FROM departamento;

ALTER TABLE departamento
DISABLE TRIGGER tg_indteadof_delete_dpt;

EXEC sp_helptrigger departamento;

GO

CREATE OR ALTER TRIGGER trg_after_insert_dpt
ON departamento
AFTER INSERT
AS
BEGIN
	DECLARE @nome VARCHAR (40);
	SELECT @nome = I.Dnome
	FROM inserted AS I;

	PRINT 'Novo departamento inserido: ' + @nome
END;
GO

-- EXERCÍCIO DE AULA

-- TRIGGER para não permitir nomes duplicados em DEPARTAMENTO

CREATE OR ALTER TRIGGER trg_insteadof_insert_dpt
ON departamento
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @nome VARCHAR (40);
	-- atribuir a variavel @nome o valor que está no insert
	SELECT @nome = I.Dnome 
	FROM inserted AS I

	IF EXISTS (SELECT 1 FROM departamento WHERE Dnome = @nome	)
		PRINT ('Nome ' +@nome + ' já existente')
	ELSE
		BEGIN
			INSERT INTO departamento (Dnumero, Dnome, Cpf_gerente, Data_inicio_gerente)
			SELECT I.Dnumero, I.Dnome, I.Cpf_gerente, I.Data_inicio_gerente
			FROM inserted AS I
			PRINT 'Novo nome inserio: ' + @nome
		END
		
END;
GO

SELECT * FROM departamento
INSERT INTO departamento (Dnumero, Dnome)
VALUES (100, 'Vendas');

GO

-- CRIANDO UM ERRO

CREATE OR ALTER TRIGGER trg_insteadof_insert_dpt
ON departamento
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @nome VARCHAR (40);
	-- atribuir a variavel @nome o valor que está no insert
	SELECT @nome = I.Dnome 
	FROM inserted AS I

	IF EXISTS (SELECT 1 FROM departamento WHERE Dnome = @nome)
		RAISERROR('Já existe um departamento com esse nome', 16, 1);
	ELSE
		BEGIN
			INSERT INTO departamento (Dnumero, Dnome, Cpf_gerente, Data_inicio_gerente)
			SELECT I.Dnumero, I.Dnome, I.Cpf_gerente, I.Data_inicio_gerente
			FROM inserted AS I
			PRINT 'Novo nome inserio: ' + @nome
		END
		
END;
GO

SELECT * FROM departamento
INSERT INTO departamento (Dnumero, Dnome)
VALUES (100, 'Estoque');

GO

DROP TRIGGER trg_after_insert_dpt;
GO

CREATE OR ALTER TRIGGER trg_after_insert_dpt
ON departamento
AFTER INSERT
AS
BEGIN
	DECLARE @nome VARCHAR (40);
	SELECT @nome = I.Dnome 
	FROM inserted AS I

	SELECT * FROM departamento;

	IF ((SELECT COUNT (Dnome) 
				FROM departamento 
				WHERE Dnome=@nome)>1) 
		BEGIN
			ROLLBACK TRANSACTION;
			RAISERROR('Já existe um departamento com esse nome', 16, 1);
		END
END;
GO

SELECT * FROM departamento
INSERT INTO departamento (Dnumero, Dnome)
VALUES (100, 'Estoque');

GO

-- Função UPDATE()
-- Verificar se um nome foi alterado.

CREATE OR ALTER TRIGGER trg_for_update_nome
ON departamento
FOR UPDATE -- FOR = AFTER 
AS
BEGIN 
	DECLARE @nome_antigo VARCHAR (40),
			@nome_novo VARCHAR (40);

	SELECT @nome_antigo = D.Dnome
	FROM deleted AS D;

	SELECT @nome_novo = I.Dnome
	FROM inserted as I;

	IF UPDATE (Dnome)
		BEGIN
			PRINT 'O nome era: ' + @nome_antigo;
			PRINT 'O novo nome é: ' + @nome_novo;
		END
	ELSE 
		PRINT 'O nome não foi alterado';
END 

GO

UPDATE departamento 
SET Dnome = 'Matriz'
WHERE Dnome = 'Centro'

SELECT * FROM departamento;

UPDATE departamento 
SET Dnumero = '9'
WHERE Dnome = 'Estoque'

GO;

CREATE TABLE LOG_FUNCIOARIO(
	log_id INT IDENTITY (100,1) PRIMARY KEY,
	cpf CHAR (11),
	operacao VARCHAR (10),
	data_hora DATETIME DEFAULT GETDATE()

)
GO

-- TRIGGER de log de insert 

CREATE TRIGGER trg_for_insert_funcionario
ON funcionario
FOR INSERT 
AS
BEGIN
	INSERT INTO LOG_FUNCIOARIO (cpf, operacao)
	SELECT I.Cpf, 'INSERT'
	FROM inserted AS I
END

GO

-- TRIGGER de log de update

CREATE TRIGGER trg_for_update_funcionario
ON funcionario
FOR UPDATE 
AS
BEGIN
	INSERT INTO LOG_FUNCIOARIO (cpf, operacao)
	SELECT I.Cpf, 'UPDATE'
	FROM inserted AS I
END

GO

-- TRIGGER de log de delete

CREATE TRIGGER trg_for_delete_funcionario
ON funcionario
FOR DELETE
AS
BEGIN
	INSERT INTO LOG_FUNCIOARIO (cpf, operacao)
	SELECT D.Cpf, 'DELETE'
	FROM deleted AS D
END

INSERT INTO funcionario (Pnome, Unome, Cpf, Datanasc,Endereco, Sexo, Salario, Bonus, Data_Admissao, Dnr)
VALUES ('Juca', 'da Silva', '11122233344', '2005-06-08', 'Rua sete', 'M', 1100, 0, '2026-10-23', 9);

SELECT * FROM funcionario ORDER BY Pnome;
SELECT * FROM LOG_FUNCIOARIO;

UPDATE funcionario
SET Salario = 500
WHERE Cpf = '11122233344';

DELETE FROM funcionario
WHERE Cpf = '11122233344';

GO

-- TRIGGER de log de insert, update e delete

CREATE TRIGGER trg_for_IDU_funcionario
ON funcionario
FOR DELETE, INSERT, UPDATE
AS
BEGIN
	IF EXISTS (SELECT * FROM inserted)
		BEGIN
			IF EXISTS (SELECT * FROM deleted)
				INSERT INTO LOG_FUNCIOARIO (cpf, operacao)
				SELECT D.Cpf, 'DELETE'
				FROM deleted AS D
			ELSE
				INSERT INTO LOG_FUNCIOARIO (cpf, operacao)
				SELECT I.Cpf, 'INSERT'
				FROM inserted AS I
		END
		ELSE
			INSERT INTO LOG_FUNCIOARIO (cpf, operacao)
			SELECT I.Cpf, 'UPDATE'
			FROM inserted AS I
END

GO;

-- EXIBIÇÃO - VIEW

CREATE VIEW vw_rh_funcionario_dpt
AS
SELECT 
	CONCAT (Pnome, ' ', Minicial, '. ', Unome) AS 'Nome',
	DATEDIFF(YEAR, Datanasc, GETDATE()) AS 'Idade',
	Endereco AS 'Endereço',
	Data_Admissao AS 'Admissão',
	D.Dnome AS 'Departamento'
FROM FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero;

GO

SELECT * FROM vw_rh_funcionario_dpt ORDER BY 'Departamento';

SELECT * FROM vw_rh_funcionario_dpt
WHERE Departamento = 'Matriz';