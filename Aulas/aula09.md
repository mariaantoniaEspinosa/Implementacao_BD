# STORED PROCEDURE 
-  Crie um procedure que insira um novo funcionário mas antes verifique se já não existe um funcionário com o mesmo nome.
-  Minha resolução:
```sql
CREATE OR ALTER PROCEDURE sp_inserir (
	@func_nome VARCHAR (50),
	@func_Unome VARCHAR (50),
	@func_cpf CHAR (11) 
	)
AS
BEGIN
	IF EXISTS ( SELECT 1 FROM FUNCIONARIO
				WHERE Cpf = @func_cpf)
		BEGIN 
			PRINT 'JÁ EXISTO: ' + @func_cpf;
			RETURN;
		END
	ELSE 
		BEGIN 
			INSERT INTO FUNCIONARIO (Pnome, Unome, Cpf)
			VALUES (@func_nome, @func_Unome, @func_cpf);
			PRINT 'FUNCIONÁRIO INSERIDO: ' + @func_nome + ' ' + @func_Unome
		END
END 
GO

EXEC sp_inserir 'Maria', 'Antônia', 04776751070;

SELECT * FROM FUNCIONARIO AS F
```
- Resolução do professor:
```sql

CREATE OR ALTER PROCEDURE sp_verifica_nome(
	@nome VARCHAR (15),
	@meio_ini CHAR (1),
	@sobrenome VARCHAR (15),
	@cpf CHAR (11))
AS 
BEGIN
	IF EXISTS (SELECT 1 FROM FUNCIONARIO 
	WHERE @nome=Pnome AND @meio_ini=Minicial AND @sobrenome=Unome)
		PRINT 'Já existe alguém com o nome ' + @nome + ' ' + @meio_ini + ' ' + @sobrenome
	ELSE 
		INSERT INTO FUNCIONARIO(Pnome, Minicial, Unome, Cpf)
		VALUES (@nome, @meio_ini, @sobrenome, @cpf)
END 
GO

EXEC sp_verifica_nome 'Maria', 'Z','Oliveira', '98765432301';

SELECT * FROM FUNCIONARIO AS F 
```
