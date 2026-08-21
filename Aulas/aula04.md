## OPERADOR IN 
- Permite que você especifique vários valores em uma cláusula WHERE
- Forma abreviada para múltiplas condições OR.
- Recuperando as informações dos funcionários que recebem 250000 ou 30000 R$
```sql
-- IN
SELECT *
FROM FUNCIONARIO AS F
WHERE F.Salario IN (25000, 30000);
```
- Recuperando os registros dos funcionários que trabalham (TRABALHA_EM) no mesmo projeto e na mesma quantidade de horas do "Fernando" (Fcpf = "3334455587")
```sql
-- QUAIS OS PROEJTOS QUE O FERNANDO TRABALHA??

SELECT F.Cpf
FROM FUNCIONARIO AS F
WHERE F.Pnome = 'Fernando';

SELECT *
FROM TRABALHA_EM AS T
WHERE T.Fcpf = 33344555587;

-- QUEM TRABALHA NO MESMO PROJETO QUE O FERNANDO?

SELECT T.Pnr
FROM TRABALHA_EM AS T 
WHERE T.Fcpf = 33344555587;

SELECT *
FROM TRABALHA_EM AS T
WHERE T.Pnr IN (2, 3, 10, 20);

-- TRANSFORMANDO O CPF NO NOME DO FUNCIONÁRIO

SELECT *
FROM TRABALHA_EM AS T, FUNCIONARIO AS F
WHERE F.Cpf = T.Fcpf AND T.Pnr IN (2, 3,10, 20);

-- LIMPANDO O SELECT

SELECT F.Pnome, T.Pnr
FROM TRABALHA_EM AS T, FUNCIONARIO AS F
WHERE F.Cpf = T.Fcpf AND T.Pnr IN (2, 3,10, 20);

-- TIRANDO O NOME DO FERNANDO DA LISTA

SELECT F.Pnome, T.Pnr
FROM TRABALHA_EM AS T, FUNCIONARIO AS F
WHERE 
	F.Cpf = T.Fcpf
	AND T.Pnr IN (2, 3,10, 20)
	AND F.Pnome <> 'Fernando';


-- ARRUMANDO O SELECT - DEIXANDO ALINHADO  

SELECT F.Pnome, T.Pnr
FROM TRABALHA_EM AS T, FUNCIONARIO AS F
WHERE 
	F.Cpf = T.Fcpf
	AND F.Pnome <> 'Fernando'
	AND T.Pnr IN (
		SELECT T.Pnr 
		FROM TRABALHA_EM AS T 
		WHERE T.Fcpf = 
			(SELECT F.Cpf
			FROM FUNCIONARIO AS F
			WHERE F.Pnome = 'Fernando'));


```
## OPERADOR BETWEEEN
- Seleciona valores dentro de um determinado intervalo, podendo ser números, texto ou datas
- É um operador inclusivo: os valores de início e fim estão incluídos
- Recuperar todos os funcionários no departamento 5 cujo salário esteja entre R$30.000 e R$40.000
```sql
-- BETWEEN
SELECT *
FROM FUNCIONARIO AS F
WHERE F.Dnr = 5 AND F.Salario BETWEEN 30000 AND 40000;
```
## ALIASES
- Dão um nome temporário a uma tabela ou a uma coluna em uma tabela
- É criado com a palavra-chave AS
# JOINS
## INNER JOIN
- Retorna registros que possuem valores correspondentes em ambas as tabelas
<img width="234" height="152" alt="image" src="https://github.com/user-attachments/assets/78238a50-e4f9-47ec-be46-fa7d78d94af1" />

- Selecionando o primeiro nome, último nome, endereço dos funcionários que trabalham no departamento "Pesquisa"
```sql
-- INNER JOIN 

SELECT F.Pnome, F.Unome, F.Endereco, D.Dnome
FROM FUNCIONARIO AS F
INNER JOIN DEPARTAMENTO AS D 
ON F.Dnr = D.Dnumero -- vínculo entre tabela 1 e tabela 2
WHERE D.Dnome = 'Pesquisa';
```

## LEFT JOIN
- Retorna registros da tabela esquerda e os registros correspondentes da tabela direita
<img width="241" height="157" alt="image" src="https://github.com/user-attachments/assets/e3d47ebd-2bff-4b0a-b638-a441035c4505" />

```sql

```

## RIGHT JOIN 
- Retorna registros da tabela direita e os registros correspondentes da tabela esquerda
<img width="267" height="161" alt="image" src="https://github.com/user-attachments/assets/cfaa0e79-3f7e-4cf5-be15-2c7148b117f5" />

```sql

```

## CROSS JOIN
- Retorna todos os registros de ambas as tabelas
<img width="242" height="152" alt="image" src="https://github.com/user-attachments/assets/0fa00de8-2f6c-463c-a8ff-58c0f95874cd" />

```sql

```
