CREATE DATABASE CAIXA;
USE CAIXA;

CREATE TABLE conta(
	id INT PRIMARY KEY,
	Nome VARCHAR (50),
	Saldo MONEY
);

INSERT INTO conta
VALUES  (10, 'Maria', 500),
		(20, 'João', 1500),
		(30, 'Paulo', 30000),
		(40, 'Maria', 50000);

SELECT * FROM conta;
GO;

-- PRIMEIRA TRANSAÇÃO
BEGIN TRAN;

DECLARE @erro INT = 0;

INSERT INTO conta
VALUES  (50, 'Pedro', 50);

SET @erro = @erro+ @@ERROR;

INSERT INTO conta
VALUES  (10, 'Judas', 666);

SET @erro = @erro+ @@ERROR;

SELECT * FROM conta;

IF @erro <> 0
BEGIN
	PRINT 'Transação revertida';
	ROLLBACK TRAN;
END
ELSE 
BEGIN 
	PRINT 'Transação concluída com sucesso!';
	COMMIT TRAN;
END

SELECT * FROM conta;
GO;

BEGIN TRAN;

UPDATE conta
SET Saldo = Saldo + 10000
WHERE Nome = 'Maria';

IF @@ROWCOUNT <> 1
BEGIN
	SELECT * FROM conta;
	ROLLBACK TRAN
	SELECT * FROM conta;
END
ELSE 
	COMMIT TRAN
GO;

-- TRANSFERIR DINHEIRO PARA OUTRA
BEGIN TRAN;

DECLARE @saldo_origem MONEY;
SELECT @saldo_origem = Saldo 
FROM conta
WHERE id = 40;
PRINT @saldo_origem;

IF (@saldo_origem -1000 < 0 )
BEGIN
	ROLLBACK TRAN
	SELECT * FROM conta
END
ELSE
BEGIN
	UPDATE conta
	SET Saldo = Saldo + 1000
	WHERE id = 20;
	COMMIT TRAN
	SELECT * FROM conta
END
GO

-- CORREÇÃO PROFESSOR
CREATE OR ALTER PROCEDURE usp_transferencia
	@id_origem INT,
	@id_destino INT,
	@valor MONEY
AS
BEGIN
	BEGIN TRAN;
	-- TIRANDO DINHEIRO DA CONTA DE ORIGEM
	UPDATE conta
	SET Saldo = Saldo - @valor
	WHERE id = @id_origem;
	-- DEPOSITAR NA CONTA DESTINO
	UPDATE conta
	SET Saldo = Saldo + @valor
	WHERE id = @id_destino;
	-- VER POSSÍVEL ESTADO DA TABELA CONTA
	SELECT * FROM conta;
	-- CONDIÇÃO PARA ROLLBACK
	IF (SELECT Saldo FROM conta WHERE id = @id_origem) < 0
		BEGIN
			ROLLBACK TRAN
			SELECT * FROM conta
			PRINT 'TRANSFERÊNCIA NÃO REALIZADA'
		END
	ELSE 
	-- CONDIÇÃO PARA COMMIT 
		COMMIT TRAN
		SELECT * FROM conta;
		PRINT 'TRANSFERÊNCIA REALIZADA'
END
GO
SELECT * FROM conta
EXEC usp_transferencia 40, 10, 500;
GO

-- SAVE POINT 
BEGIN TRAN;

INSERT INTO conta
VALUES (50, 'Pedro', 50);

SAVE TRAN pedroOK


INSERT INTO conta
VALUES (10, 'Juca', -200);

IF @@ERROR <> 0
	BEGIN 
		ROLLBACK TRAN pedroOK
		COMMIT TRAN;
		PRINT 'VOLTAMOS PARA O SAVEPOINT'
	END
ELSE 
	BEGIN
		COMMIT TRAN;
	END
SELECT * FROM conta;
GO

-- TRY CATCH

BEGIN TRY
	PRINT 'Olá TRY CATCH!';
	SELECT 1/0; -- ERRO
	PRINT 'NÃO CHEGUEI AQUI!';
END TRY
BEGIN CATCH
	PRINT 'Deu ERRO!'
	PRINT 'Número: ' + CAST (ERROR_NUMBER() AS VARCHAR(10));
	PRINT 'Mensagem de ERRO: ' + ERROR_MESSAGE();
END CATCH
GO

-- TRANSACTION + TRY CATCH
BEGIN TRAN;
	BEGIN TRY;
		INSERT INTO conta
		VALUES (60, 'Mateus', 15);
		SELECT * FROM conta;
		INSERT INTO conta
		VALUES (10, 'Juca', -200); --ERRO
		COMMIT TRAN;
		SELECT * FROM conta;
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN;
		PRINT 'ERRO!'
		PRINT 'Número: ' + CAST (ERROR_NUMBER() AS VARCHAR(10));
		PRINT 'Mensagem de ERRO: ' + ERROR_MESSAGE();
	END CATCH
SELECT * FROM conta;
