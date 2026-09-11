## Revisando a última aula
### Declaração de Variáveis
```sql
DECLARE @nome VARCHAR, @numero INT;
SET @numero = 10;
----------------------------------------
SELECT @nome = P.nome
FROM PESSOAS as P
WHERE ID = 10
----------------------------------------
IF (condição) -- A>B OR B = C
  beging
    -- bloco de código
  end
ELSE IF (condição)
ELSE
----------------------------------------
IIF (condição, "Verdadeiro", "Falso")
----------------------------------------
CASE
  WHEN condição THEN "_____"
  WHEN condição THEN "_____"
  ELSE
END
-----------------------------------------
WHILE condição
  Beging
  End

```
# Aula 08
## FUNÇÕES
- As funções no SQL Server permitem encapsular lógicas de processamento que podem ser reutilizadas em consultas. Diferente das Stored Procedures, elas retornam obrigatoriamente um valor (escalar ou tabela) e podem ser usadas diretamente em instruções SELECT, WHERE,etc.
```SQL
-- FUNÇÕES: tipo de retorno, nome e parâmetros 

-- CRIANDO UMA FUNÇÃO ESCALAR 
CREATE OR ALTER FUNCTION fn_dobro (@Numero DECIMAL (10,2))
RETURNS DECIMAL (10,2)
AS
BEGIN
	RETURN @Numero * 2
END
GO;

SELECT dbo.fn_dobro(250);

-- DOBRO DO SALÁRIO DA MARIA 
SELECT
	Pnome,
	Unome,
	F.Salario,
	dbo.fn_dobro(F.Salario) AS 'Dobro'
FROM FUNCIONARIO AS F
WHERE F.Pnome = 'Maria';

-- DOBRO DO SALÁRIO DE TODOS OS FUNCIONÁRIOS
SELECT
	Pnome,
	Unome,
	F.Salario,
	dbo.fn_dobro(F.Salario) AS 'Dobro'
FROM FUNCIONARIO AS F;

-- ENOCNTRANDO QUEM RECEBE MAIS QUE O DOBRO DO SALÁRIO DE QUEM MENOS RECEBE 
DECLARE @menor_salario DECIMAL (10,2)
SELECT @menor_salario = MIN (Salario)
FROM FUNCIONARIO
SELECT 
	Pnome,
	Unome,
	F.Salario
FROM FUNCIONARIO AS F
WHERE F.Salario > dbo.fn_dobro (@menor_salario);
GO

-- ENCONTRANDO A IDADE DOS FUNCIONÁRIOS NO BANCO
CREATE FUNCTION fn_calcula_idade(@data_nasc DATE)
RETURNS INT 
AS
BEGIN
	DECLARE @idade INT;
	SET @idade = DATEDIFF(YEAR, @data_nasc, GETDATE())
	IF(MONTH(@data_nasc) > MONTH (GETDATE()))
		OR (MONTH(@data_nasc) = MONTH (GETDATE()) AND
			DAY(@data_nasc) > DAY (GETDATE()))
		SET @idade = @idade - 1;
	RETURN @idade;
END;
GO

--IDADE DOS DEPENDENTES 
SELECT 
	D.Nome_dependente,
	CONVERT (VARCHAR, D.Datanasc, 103) AS 'DATA',
	dbo.fn_calcula_idade(D.Datanasc) AS 'IDADE'
FROM DEPENDENTE AS D;

--IDADE DOS FUNCIONÁRIOS
SELECT 
	F.Pnome,
	CONVERT (VARCHAR, F.Datanasc, 103) AS 'DATA NASC',
	dbo.fn_calcula_idade(F.Datanasc) AS 'IDADE'
FROM FUNCIONARIO AS F;
GO

-- FUNÇÃO INLINE: retornando todos os funcionários de um determinado departamento
CREATE FUNCTION fn_funcionario_dpt(@nome_dpt VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
	SELECT 
		F.Pnome,
		F.Unome
	FROM FUNCIONARIO AS F 
	JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero
	WHERE D.Dnome = @nome_dpt
);
GO;

SELECT * FROM dbo.fn_funcionario_dpt('Pesquisa');
GO;

-- FUNÇÕES MULTI-STATEMENT: criar uma função que retorna nome completo dos funcionários e o valor anual, com férias e décimo terceiro
CREATE FUNCTION fn_salarioAnual()
RETURNS @salAno TABLE
(
	nome_comp VARCHAR (100),
	salario DECIMAL (10,2),
	salario_anual DECIMAL (10,2)
)
AS 
BEGIN 
	INSERT INTO @salAno
	SELECT 
		CONCAT(F.Pnome, ' ', F.Minicial, ' ', F.Unome),
		f.Salario,
		f.Salario * 13 + (f.Salario * 0.3)
	FROM FUNCIONARIO AS F;
	RETURN;
END
GO

SELECT * FROM dbo.fn_salarioAnual();
```
