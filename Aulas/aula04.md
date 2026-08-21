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
