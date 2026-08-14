# Usando o SQL Server
- Banco de dados utilizado:
```sql

CREATE DATABASE EMPRESA;
GO
	
USE EMPRESA;
GO
	
--Criação da tabela FUNCIONARIO
CREATE TABLE FUNCIONARIO (
	Pnome VARCHAR(15) NOT NULL,
    Minicial CHAR,
    Unome VARCHAR(15) NOT NULL,
    Cpf CHAR(11),
    Datanasc DATE,
    Endereco VARCHAR(255),
    Sexo CHAR,
    Salario DECIMAL(10,2),
    Cpf_supervisor CHAR(11),
    Dnr INT,
    PRIMARY KEY (Cpf),
    FOREIGN KEY (Cpf_supervisor) REFERENCES FUNCIONARIO(Cpf)
);
GO

--Tablea de DEPARTAMENTO
CREATE TABLE DEPARTAMENTO (
	Dnome VARCHAR(15) NOT NULL,
    Dnumero INT,
    Cpf_gerente CHAR(11),
    Data_inicio_gerente DATE,
    PRIMARY KEY (Dnumero),
    UNIQUE (Dnome),
    FOREIGN KEY (Cpf_gerente) REFERENCES FUNCIONARIO(CPF)
);

--Adiconando restição referencial em FUNCIONARO de DEPARTAMENTO
--Criando uma ALTERAÇÃO de Tabela
ALTER TABLE FUNCIONARIO
ADD CONSTRAINT Dnr
FOREIGN KEY (Dnr) REFERENCES DEPARTAMENTO (Dnumero);

--Criação da tabela de LOCALIZACAO_DEP
CREATE TABLE LOCALIZACAO_DEP (
	Dnumero INT NOT NULL,
	Dlocal VARCHAR (15) NOT NULL,
    PRIMARY KEY (Dnumero, Dlocal),
    FOREIGN KEY (Dnumero) REFERENCES DEPARTAMENTO (Dnumero)
);

--Criacao da tabela PROJETO
CREATE TABLE PROJETO(
	Projnome VARCHAR (15) NOT NULL,
	Projnumero INT NOT NULL,
    Projlocal VARCHAR(15),
    Dnum INT,
    PRIMARY KEY (Projnumero),
    UNIQUE (Projnome),
    FOREIGN KEY (Dnum) REFERENCES DEPARTAMENTO (Dnumero)
);

--Criação da tabela TRABALHA_EM
CREATE TABLE TRABALHA_EM(
	Fcpf CHAR(11) NOT NULL,
    Pnr INT NOT NULL,
    Horas DECIMAL (3,1) NOT NULL,
    PRIMARy KEY (Fcpf, Pnr),
    FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO (Cpf),
    FOREIGN KEY (Pnr) REFERENCES PROJETO(Projnumero)
);

--Criação da tabela DEPENDENTE sem seleção do esquema
CREATE TABLE DEPENDENTE(
	Fcpf CHAR(11) NOT NULL,
    Nome_dependente VARCHAR(15) NOT NULL,
    Sexo CHAR,
    Datanasc DATE,
    Parentesco VARCHAR(8),
    PRIMARY KEY (Fcpf, Nome_dependente),
    FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO(Cpf)
);

--Inserindo valores no Departamento
INSERT INTO DEPARTAMENTO (Dnome, Dnumero) VALUES('Pesquisa', 5);
INSERT INTO DEPARTAMENTO (Dnome, Dnumero) VALUES('Administração', 4);
INSERT INTO DEPARTAMENTO (Dnome, Dnumero) VALUES('Matriz', 1);
SELECT * FROM DEPARTAMENTO;

--Inserindo funcionarios com cargo de gerencia DATE AAAA-MM-DD
INSERT INTO FUNCIONARIO VALUES ( 'Jorge', 'E', 'Brito', '88866555576', '1937-11-10', 'Rua do Horto, 35, São Paulo, SP', 'M', 55000, NULL , 1 );
INSERT INTO FUNCIONARIO VALUES ( 'Jennifer', 'S', 'Souza', '98765432168', '1941-06-20', 'Av Arthur de Lima, 54, Santo André, SP', 'F', 43000, '88866555576' , 4 );
INSERT INTO FUNCIONARIO VALUES ( 'Fernando', 'T', 'Wong', '33344555587', '1955-12-08', 'Rua da Lapa, 34, São Paulo, SP', 'M', 40000, '88866555576' , 5 );
INSERT INTO FUNCIONARIO VALUES ( 'João', 'B', 'Silva', '12345678966', '1965-01-09', 'Rua das Flores, 751, São Paulo, SP', 'M', 30000, '33344555587' , 5 );
INSERT INTO FUNCIONARIO VALUES ( 'Alice', 'J', 'Zelaya', '99988777767', '1968-01-19', 'Rua Souza Lima, 35, Curitiba, PR', 'F', 25000, '98765432168' , 4 );
INSERT INTO FUNCIONARIO VALUES ( 'Ronaldo', 'K', 'Lima', '66688444476', '1962-09-15', 'Rua Rebouças, 65, Piracicaba, SP', 'M', 38000, '33344555587' , 5 );
INSERT INTO FUNCIONARIO VALUES ( 'Joice', 'A', 'Leite', '45345345376', '1972-07-31', 'Av. Lucas Obes, 74, São Paulo, SP', 'F', 25000, '33344555587' , 5 );
INSERT INTO FUNCIONARIO VALUES ( 'André', 'E', 'Brito', '98798798733', '1969-03-29', 'Rua Timbira, 35, São Paulo, SP', 'M', 25000, '98765432168' , 4 );

--Corrigindo erro de inserção
UPDATE FUNCIONARIO
SET Endereco = 'Rua Reboucas, 65, Piracicaba, SP'
WHERE Cpf = '66688444476';

--Recupera todas as informações de funcionários
SELECT * FROM FUNCIONARIO;

--Finzalindo o preenchimento da tabela DEPTARTAMENTO
UPDATE DEPARTAMENTO
SET Cpf_gerente = '33344555587', Data_inicio_gerente = '1988-05-22'
WHERE Dnumero = 5;
UPDATE DEPARTAMENTO
SET Cpf_gerente = '98765432168', Data_inicio_gerente = '1995-01-01'
WHERE Dnumero = 4;
UPDATE DEPARTAMENTO
SET Cpf_gerente = '88866555576', Data_inicio_gerente = '1981-06-19'
WHERE Dnumero = 1;
--Recuperar todas as informações de departamento
SELECT * FROM DEPARTAMENTO;

--Prrencher a tabela LOCALIZACAO_DEP
INSERT INTO LOCALIZACAO_DEP VALUES (1, 'São Paulo');
INSERT INTO LOCALIZACAO_DEP VALUES (4, 'Mauá');
INSERT INTO LOCALIZACAO_DEP VALUES (5, 'Santo André');
INSERT INTO LOCALIZACAO_DEP VALUES (5, 'Itu');
INSERT INTO LOCALIZACAO_DEP VALUES (5, 'São Paulo');
--Recuperando informações de LOCALIZACAO_DEP
SELECT * FROM LOCALIZACAO_DEP;

--Preenchendo a table PROJETO
INSERT INTO PROJETO VALUES ('ProdutoX', 1, 'Santo André', 5);
INSERT INTO PROJETO VALUES ('ProdutoY', 2, 'Itu', 5);
INSERT INTO PROJETO VALUES ('ProdutoZ', 3, 'São Paulo', 5);
INSERT INTO PROJETO VALUES ('Informatização', 10, 'Mauá', 4);
INSERT INTO PROJETO VALUES ('Reorganização', 20, 'São Paulo', 1);
INSERT INTO PROJETO VALUES ('Novosbenefícios', 30, 'Mauá', 4);
--Recuperando informações de PROJETO
SELECT * FROM PROJETO;

--Preenchento TRABALHA_EM
INSERT INTO TRABALHA_EM VALUES ('12345678966',1,32.5);
INSERT INTO TRABALHA_EM VALUES ('12345678966',2,7.5);
INSERT INTO TRABALHA_EM VALUES ('66688444476',3,40);
INSERT INTO TRABALHA_EM VALUES ('45345345376',1,20);
INSERT INTO TRABALHA_EM VALUES ('45345345376',2,20);
INSERT INTO TRABALHA_EM VALUES ('33344555587',2,10);
INSERT INTO TRABALHA_EM VALUES ('33344555587',3,10);
INSERT INTO TRABALHA_EM VALUES ('33344555587',10,10);
INSERT INTO TRABALHA_EM VALUES ('33344555587',20,10);
INSERT INTO TRABALHA_EM VALUES ('99988777767',10,10);
INSERT INTO TRABALHA_EM VALUES ('99988777767',30,30);
INSERT INTO TRABALHA_EM VALUES ('98798798733',10,35);
INSERT INTO TRABALHA_EM VALUES ('98798798733',30,5);
INSERT INTO TRABALHA_EM VALUES ('98765432168',30,20);
INSERT INTO TRABALHA_EM VALUES ('98765432168',20,15);

--Preenchendo a tabela de DEPENDENTES
INSERT INTO DEPENDENTE VALUES ('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha');
INSERT INTO DEPENDENTE VALUES ('33344555587', 'Tiago', 'M', '1983-10-25', 'Filh0');
INSERT INTO DEPENDENTE VALUES ('33344555587', 'Janaina', 'F', '1958-05-03', 'Eposa');
INSERT INTO DEPENDENTE VALUES ('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido');
INSERT INTO DEPENDENTE VALUES ('12345678966', 'Michael', 'M', '1988-01-04', 'Filho');
INSERT INTO DEPENDENTE VALUES ('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha');
INSERT INTO DEPENDENTE VALUES ('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');

-- Estes comando para a aula de IF/ELSE
-- Adicionando a coluna Bonus
ALTER TABLE FUNCIONARIO
ADD Bonus DECIMAL(10, 2) NULL;
GO

-- Adicionando a coluna Data_Admissao
ALTER TABLE FUNCIONARIO
ADD Data_Admissao DATE NULL;
GO


-- Inserindo novos registros com valores para as colunas Bonus e Data_Admissao
INSERT INTO FUNCIONARIO (Pnome, Minicial, Unome, Cpf, Datanasc, Endereco, Sexo, Salario, Cpf_supervisor, Dnr, Data_Admissao, Bonus)
VALUES
('Carlos', 'A', 'Silva', '98765432100', '1985-04-12', 'Rua A, 123', 'M', 4500.00, NULL, 1, '2023-03-01', 1000.00),
('Ana', 'B', 'Sousa', '98765432200', '1990-06-23', 'Rua B, 456', 'F', 6500.00, '98765432100', 1, '2022-01-15', 0.00),
('Maria', 'C', 'Oliveira', '98765432300', '1978-09-17', 'Rua C, 789', 'F', 7500.00, '98765432200', 5, '2024-02-01', 1500.00),
('Paulo', 'D', 'Silva', '98765432400', '1982-11-05', 'Rua D, 101', 'M', 7000.00, '98765432300', 4, '2024-05-15', 500.00);
GO


--Novos funcionario e departaemtneo para Aula 03
INSERT INTO FUNCIONARIO (Pnome, Minicial, Unome, Cpf, Datanasc, Endereco, Sexo, Salario, Cpf_supervisor, Dnr)
VALUES ('Carlos', 'M', 'Ferreira', '12312312311', '1980-02-15', 'Av. Paulista, 1000, São Paulo, SP', 'M', 45000, NULL, NULL),
('Mariana', 'L', 'Gomes', '32132132122', '1985-06-22', 'Rua das Acácias, 500, Rio de Janeiro, RJ', 'F', 42000, NULL, NULL),
('Pedro', 'A', 'Silva', '65465465433', '1990-11-10', 'Rua da Praia, 200, Salvador, BA', 'M', 47000, NULL, NULL);
GO

INSERT INTO DEPARTAMENTO (Dnome, Dnumero)
VALUES ('Vendas', 6),
('RH', 7),
('TI', 8);
GO

```

<img width="960" height="708" alt="image" src="https://github.com/user-attachments/assets/7e34c9de-49e8-4c9b-ada6-2e320eb2f2cc" />

# Consultas Complexas Joins
### Revisando
```sql
SELECT <Lista de atributos>
FROM <Lista de tabelas>
WHERE <Condição>
```
###

## Select DISTINCT
- Usada para retornar apenas valores distintos (diferentes). Dentro de uma tabela, uma coluna muitas vezes contém muitos valores duplicados e, às vezes, você só deseja listar os valores diferentes (distintos).
- Listando as diferentes faixas salariais dos funcionarios
```sql
SELECT *
FROM FUNCIONARIO;

SELECT DISTINCT F.SALARIO 
FROM FUNCIONARIO AS F;

SELECT DISTINCT F.SEXO
FROM FUNCIONARIO AS F;
```

## Cláusula WHERE 
- Usada para extrair apenas os registros que atendem a uma condição especifica.
- Recuperando todas as informações dos funcionários com primeiro nome "João"
```sql
SELECT *
FROM FUNCIONARIO AS F 
WHERE F.Pnome = 'João';
```

## SQL AND, OR and NOT
- Usados para filtrar registros com base em mais de uma condição:
  - AND: exige um registro se todas as condições separadas por "and" forem **verdadeiras*
  - OR: exibe um registro se alguma das condições separadas por "or" for **verdadeira*
  - NOT: exibe um registro se as condições forem **falsas**
- Listando todos os funcionários do sexo masculino com (AND) salário maior ou igual a 30.000,00R$
```sql
SELECT *
FROM FUNCIONARIO AS F
WHERE  F.Sexo = 'M' AND F.Salario >= 30000;
```
- Listando todos os funcionários que moram em São Paulo ou (OR) Curitiba
```sql
SELECT *
FROM FUNCIONARIO AS F
WHERE F.Endereco LIKE '%São Paulo%' OR F.Endereco LIKE '%Curitiba%';
```
- Listando os funcionários que não (NOT) moram em São Paulo
```sql
SELECT *
FROM FUNCIONARIO AS F
WHERE NOT F.Endereco LIKE '%São Paulo%';
```

## ORDER BY
- Usada para classificar o conjunto de resultados em ordem ascendente ou descendente
- Listando os funcionários em ordem decrescente de salário
```sql
SELECT F.Pnome, F.Endereco, F.Salario
FROM FUNCIONARIO AS F
ORDER BY F.Salario DESC;
```
- Listando nome completo dos funcionários e seu custo anual em ordem decrescente
```sql
SELECT 
	F.Pnome AS 'Nome',
	F.Unome AS 'Sobrenome',
	F.Salario,
	F.Salario*12 AS 'CustoAnual'
FROM FUNCIONARIO AS F
ORDER BY F.Salario DESC;
```

## VALORES NULOS/NULL
- É um campo **sem valor**
- Registro sem adição de um valor específico ao campo = foi deixado em branco durante a criação do registro
- operadores: IS NULL e IS NOT NULL
- Encontrando os funcionários que não possuem supervisores
```sql
SELECT *
FROM FUNCIONARIO AS F 
WHERE F.Cpf_supervisor IS NULL;
```
- Encontrando os funcionários que possuem supervisores
```sql
SELECT *
FROM FUNCIONARIO AS F 
WHERE F.Cpf_supervisor IS NOT NULL;
```

## SELECT TOP 
- Específica o número de registros a serem retornados
- operador: TOP
- MySQL: Limit
- Recuperando o registro dos 3 funcionários que têm maior salário
```sql
SELECT TOP 3 *
FROM FUNCIONARIO AS F 
ORDER BY F.Salario DESC;
```

###

## FUNÇÃO MIN() MAX()
- Min(): retorna o valor mais baixo da coluna selecionada
- Max(): retorna o valor mais alto da coluna selecionada
- Recuperando as informações do funcionário com menor salário
```sql
SELECT MIN (Salario)
FROM FUNCIONARIO;

-- SELECT ALINHADO 

SELECT *
FROM FUNCIONARIO AS F
WHERE F.Salario = (SELECT MIN(Salario) FROM FUNCIONARIO);

-- OUTRA FORMA DE FAZER

DECLARE @salario_min DECIMAL(10,2)
SET @salario_min = (SELECT MIN(Salario) FROM FUNCIONARIO);
PRINT @salario_min;

SELECT *
FROM FUNCIONARIO AS F 
WHERE F.Salario = @salario_min;
```

## FUNÇÕES COUNT(), AVG() E SUM()
- Count(): retorna o numero de linhas que correspondem a um critério específico
- Avg(): retorna um valor médio de uma coluna numérica
- Sum(): retorna a soma total de uma coluna numérica
- Quantos funcionários possuímos cadastrados no banco?
```sql
-- COUNT ()
SELECT COUNT (F.Cpf)
FROM FUNCIONARIO AS F;

SELECT COUNT (D.Nome_dependente)
FROM DEPENDENTE AS D;

SELECT 
	(SELECT COUNT (F.Cpf) FROM FUNCIONARIO AS F) + 
	(SELECT COUNT (D.Nome_dependente) FROM DEPENDENTE AS D)
	AS "Qtd Pessoas";
```

- Qual a média salarial dos meus funcionários?
```sql
-- AVG()
SELECT AVG (F.Salario)
FROM FUNCIONARIO AS F;

SELECT *
FROM FUNCIONARIO AS F
WHERE F.Salario < (SELECT AVG (F.Salario) FROM FUNCIONARIO AS F)
ORDER BY F.Salario ASC;
```

- Qual o custo mensal com a folha de pagamento dos funcionários?
```sql
-- SUM()
SELECT SUM (F.Salario)
FROM FUNCIONARIO AS F; 
```

## OPERADOR LIKE
- Usado em uma cláusula WHERE para pesquisar um padrão específico em uma coluna
<img width="823" height="261" alt="image" src="https://github.com/user-attachments/assets/253a32eb-a825-4561-a901-9c26c84c58e1" />

- Recuperando os funcionários nascidos no ano de 72
```sql
-- LIKE 
SELECT *
FROM FUNCIONARIO AS F
WHERE F.Datanasc LIKE '__72%';
```
