# Relembrando...
## SQL Join
- A cláusula JOIN é usada para combinar linhas de duas ou mais tabelas, com base em uma coluna relacionada entre elas
<img width="803" height="166" alt="image" src="https://github.com/user-attachments/assets/878433f7-b41d-431b-bc2c-274f157ebf99" />

## SQL UNION/INTERSECT/EXCEPT 
- Union: não trás as duplicidades
- **Union All**: trás tudo
- Exemplo: Imagine que a diretoria da empresa quer uma lista de todas as cidades onde a empresa possui alguma atividade, seja a localização de um departamento ou a localização de um projeto.
  
```sql
--UNION ALL
SELECT P.Projlocal AS 'Local'
FROM PROJETO AS P

UNION ALL

SELECT L.Dlocal AS 'Local'
FROM LOCALIZACAO_DEP AS L;
```

- **Except**
- Exemplo: Listar os CPFs dos funcionários que não são gerentes de nenhum departamento

```sql
-- SQL EXCEPT: conjuntos iguais
SELECT F.Cpf, F.Pnome
FROM FUNCIONARIO AS F

EXCEPT

SELECT D.Cpf_gerente, F.Pnome
FROM DEPARTAMENTO AS D

JOIN FUNCIONARIO AS F
ON D.Cpf_gerente = F.Cpf;
```

- **Intersect**
- Exemplo: Encontre os funcionários que são supervisores 

```sql
-- SQL INTERSECT
SELECT Cpf
FROM FUNCIONARIO

INTERSECT

SELECT Cpf_supervisor
FROM FUNCIONARIO
```

## SQL GROUP BY
- Agrupa linhas com os mesmos valores em linhas de resumo, como "encontre o número de clientes em cada país"
- Frequentemente usada com funções agregadas para agrupar o conjunto de resultados
- Exemplo 01: quantidade de funcionários por sexo
```sql
-- SQL GROUP BY
SELECT COUNT(F.Cpf) AS 'Qtd', F.Sexo
FROM FUNCIONARIO AS F
GROUP BY F.Sexo
```
- Exemplo 02: contar o número de funcionários por departamento
```sql
SELECT COUNT (F.Cpf) AS 'Qtd funcionários', D.Dnome AS 'Nome área'
FROM FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D -- juntando duas tabelas (departamento + funcionario)
ON F.Dnr = D.Dnumero
GROUP BY Dnome;
```
- Exemplo 03: somar os salários por departamento
```sql
SELECT SUM(F.Salario) AS 'Total salários', Dnome AS 'Departamento'
FROM FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero
GROUP BY Dnome;
```
- Exemplo 04: média de horas trabalhadas por projeto
```sql
SELECT AVG(T.Horas) AS 'Média horas', P.Projnome AS 'Projeto'
FROM TRABALHA_EM AS T
JOIN PROJETO AS P
ON T.Pnr = P.Projnumero
GROUP BY P.Projnome
```
- Exemplo 05: maior salário em cada departamento
```sql
SELECT MAX(F.Salario) AS 'Maior salário', Dnome AS 'Departamento' 
FROM FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero
GROUP BY Dnome;
```

## SQL HAVING
- A cláusula HAVING foi adicionada ao SQL porque a palavra-chave WHERE não pode ser usada com funções agregadas.
- Exemplo 01: Encontrar departamentos com mais de 3 funcionários
```sql
-- SQL HAVING
SELECT COUNT(F.Cpf) AS 'Func', Dnome
FROM FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero
GROUP BY D.Dnome
HAVING COUNT(F.Cpf) > 3;
```
- Exemplo 02: Listar projetos que exigem no mínimo 50 horas de trabalho no total
```sql
SELECT SUM(T.Horas) AS 'Horas', P.Projnome AS 'Projeto'
FROM TRABALHA_EM AS T
JOIN PROJETO AS P
ON T.Pnr = P.Projnumero
GROUP BY P.Projnome
HAVING SUM(T.Horas) > 50;
```

## SQL EXISTS
- Usado para testar a existência de qualquer registro em uma subconsulta
- retorna true se a subconsulta retornar um ou mais registros
- Exemplo 01: listar departamentos que possuem projetos associados
```sql
--SQL EXISTS 
SELECT *
FROM DEPARTAMENTO 
WHERE EXISTS(
	SELECT 'OK'
	FROM PROJETO
	WHERE PROJETO.Dnum = DEPARTAMENTO.Dnumero
)
```

## SQL ANY
- retorna um valor booleano como resultado
- retorna true se qualquer um dos valores da subconsulta atender à condição
- ANY significa que a condição será verdadeira se a operação for verdadeira para qualquer um dos valores no intervalo.
- Exemplo: Encontrar funcionários que ganham mais do que qualquer funcionário do departamento de 'Administração'
```sql
--ANY
SELECT Pnome, Salario
FROM FUNCIONARIO
WHERE Salario > ANY (
	SELECT F.Salario
	FROM FUNCIONARIO AS F
	JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero
	WHERE D.Dnome = 'Administração'
	);
```

## SQL ALL
- retorna um valor booleano como resultado
- retorna TRUE se TODOS os valores da subconsulta atenderem à condição
- ALL significa que a condição será verdadeira somente se a operação for verdadeira para todos os valores no intervalo.
- Exemplo:
```sql
SELECT Pnome, Salario
FROM FUNCIONARIO
WHERE Salario > ALL (
	SELECT F.Salario
	FROM FUNCIONARIO AS F
	JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero
	WHERE D.Dnome = 'Administração'
	)
ORDER BY Salario;
```

# VARIÁVEIS 
- Variáveis podem ser declaradas no corpo de um batch ou procedimento.
- Pode-se atribuir-lhes valores usando-se declarações SET ou SELECT
- As variáveis são inicializadas por padrão com NULL
- *batch* refere-se a um grupo de uma ou mais (por exemplo utilizando GO) instruções SQL que são enviadas juntas do cliente para o servidor de banco de dados para serem executadas como uma única unidade de trabalho
- Exemplo 01: aprendendo a declarar e a printar 
```sql
-- VARIÁVEIS --
-- DECLARE 
DECLARE @nome VARCHAR(100),
		@idade INT,
		@salario DECIMAL(10,2),
		@data DATE;
SET @nome = 'Maria Antônia';
SET @idade = 20;
SET @salario = 2400.00;
SET @data = GETDATE();
PRINT 'Nome: ' + @nome + ', Idade: ' + CAST(@idade AS VARCHAR(10));
SELECT 
	@nome AS 'Nome',
	@idade AS 'Idade',
	@salario AS 'Salário',
	@data AS 'Data de hoje';
GO
-- o bloco todo precisa ser executado junto 
```
- Exemplo 02: Recupere o nome do departamento com Dnumero = 4.
```sql
DECLARE @nomeDpt VARCHAR(50);

SELECT @nomeDpt = Dnome
FROM DEPARTAMENTO AS D
WHERE D.Dnumero = 4

PRINT 'Departamento: ' + @nomeDpt;
```

- Exemplo 03: Calculando o novo salário com um aumento de 10%, para a Jennifer
```sql
DECLARE @salario DECIMAL(10,2),
		@novoSalario DECIMAL (10,2),
		@nome VARCHAR(100);
SET @nome = 'Jennifer';
SELECT @salario = F.Salario
FROM FUNCIONARIO AS F
WHERE F.Pnome = @nome;
SET @novoSalario = @salario * 1.1;
PRINT 'Salario: ' + CAST(@salario AS VARCHAR (10));
PRINT 'Novo salario: ' + CAST(@novoSalario AS VARCHAR (10));
```

-Exemplo: calculando a idade da Jennifer
```sql
--calculando a idade da Jennifer
DECLARE @data_nasc DATE,
		@idade INT;

SELECT @data_nasc = F.Datanasc
FROM FUNCIONARIO AS F
WHERE F.Pnome = 'Jennifer';
SET @idade = YEAR(GETDATE()) - YEAR(@data_nasc);
PRINT 'A Jaennifer tem ' + CAST(@idade AS VARCHAR(5)) + ' anos';
```
