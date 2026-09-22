## entrega e correção da prova
### questão 7
```SQL
-- MINHA RESOLUÇÃO
SELECT A.Nome, HE.Nota AS Nota_BD
FROM HISTORICO_ESCOLAR AS HE
INNER JOIN ALUNO AS A
ON HE.Numero_aluno = A.Numero_aluno
WHERE HE.Identificacao_turma = (select T.Identificacao_turma
								FROM DISCIPLINA AS D
								inner join Turma as T
								on D.Numero_disciplina = t.Numero_disciplina
								WHERE D.Nome_disciplina = 'Banco de dados');
```
```SQL
-- HERYSSON
SELECT A.Nome, HE.Nota, D.Nome_disciplina
FROM ALUNO as A
JOIN HISTORICO_ESCOLAR AS he ON HE.Numero_aluno = A.Numero_aluno
JOIN TURMA AS T ON T.Identificacao_turma = HE.Identificacao_turma
JOIN DISCIPLINA AS D ON T.Numero_disciplina = D.Numero_disciplina
WHERE D.Nome_disciplina LIKE 'Banco de dados';
```

### questão 8
```SQL
-- 8) Quais são as disciplinas que têm pré-requisitos e quais são seus respctivos pré-requisitos
-- minha resolução
SELECT D.Nome_disciplina AS Disciplina_com_Pré_Requisito, Dd.Nome_disciplina as pré_quequisito
FROM PRE_REQUISITO AS PQ
INNER JOIN DISCIPLINA AS D
ON PQ.Numero_disciplina = D.Numero_disciplina
INNER JOIN DISCIPLINA AS Dd
ON PQ.Numero_pre_requisito = Dd.Numero_disciplina;
```
```SQL
 -- HERYSSON
SELECT D.Numero_disciplina, D.Nome_disciplina AS 'Disciplina',PR.Numero_pre_requisito, DPR.Nome_disciplina AS 'Pré-Requisito'
FROM DISCIPLINA AS D
JOIN PRE_REQUISITO AS PR ON PR.Numero_disciplina = D.Numero_disciplina
JOIN DISCIPLINA AS DPR ON PR.Numero_pre_requisito = DPR.Numero_disciplina

```
### questão 9
```sql
--9)Liste todas as disciplinas cursadas pelo aluno 'Silva', mostrando o nome da disciplina, o semestre, o ano e a nota final
DECLARE @N_ALUNO INT
select @N_ALUNO = a.Numero_aluno
from ALUNO AS a
where a.Nome = 'Silva'

select  D.Nome_disciplina, T.Semestre, T.Ano, he.Nota
from  TURMA as T
inner join DISCIPLINA AS D
ON T.Numero_disciplina = D.Numero_disciplina
INNER JOIN HISTORICO_ESCOLAR AS HE
ON HE.Numero_aluno = @N_ALUNO
WHERE T.Identificacao_turma IN (select he.Identificacao_turma 
								from HISTORICO_ESCOLAR as he
								where he.Numero_aluno = @N_ALUNO)
```
```SQL
-- Herysson
SELECT A.Nome, D.Nome_disciplina, t.Semestre, t.Ano, he.Nota
FROM ALUNO AS A
JOIN HISTORICO_ESCOLAR AS he ON HE.Numero_aluno = A.Numero_aluno
JOIN TURMA AS T ON T.Identificacao_turma = HE.Identificacao_turma
JOIN DISCIPLINA AS D ON T.Numero_disciplina = D.Numero_disciplina
WHERE A.Nome LIKE 'Silva';
```

### questão 10
```sql
--10) Crie uma funçao (recebe o nome do aluno em questão, e a respectiva disciplina) que verifique se o aluno APROVADO,esta em RECUPERAÇÃO, ou REPROVADO com base na nota final:
-- A e B = APROVADO, C = RECUPERAÇÃO, F = REPROVADO

CREATE FUNCTION fn_situacaoAluno (@nome varchar(100), @disciplina varchar(15))
RETURNS VARCHAR (15)
AS
BEGIN
	DECLARE @situacao varchar(15)
	DECLARE @nota varchar(1)
	select @nota = HE.Nota
	from HISTORICO_ESCOLAR as HE
	where he.Numero_aluno = (select a.Numero_aluno from aluno as a where a.Nome = @nome) 
	 AND HE.Identificacao_turma in (select t.Identificacao_turma 
									from turma as T
									where t.Numero_disciplina = @disciplina)

	IF @nota = 'A' OR @nota = 'B'
		set @situacao = 'APROVADO'
	ELSE IF @nota = 'C'
		set @situacao = 'EM RECUPERAÇÃO'
	ELSE IF @nota = 'F'
		SET @situacao = 'REPROVADO'
	RETURN @situacao
END	

select dbo.fn_situacaoAluno ('Alice Oliveira','MAT2410') as situacao
select dbo.fn_situacaoAluno ('Carla Souza','CC3380') as situacao

```
```sql
-- correçção
CREATE FUNCTION fn_situacaoAlunos (@nome varchar(100), @disciplina varchar(15))
RETURNS VARCHAR (15)
AS
BEGIN
	DECLARE @situacao varchar(15)
	DECLARE @nota char(1)

	select @nota = HE.Nota
	from aluno as a
	join HISTORICO_ESCOLAR as he on he.Numero_aluno = a.Numero_aluno
	join TURMA as t on t.Identificacao_turma = he.Identificacao_turma
	join DISCIPLINA as d on t.Numero_disciplina = d.Numero_disciplina
	where a.Nome = @nome and d.Nome_disciplina = @disciplina;
	

	IF @nota IN ('A','B')
		set @situacao = 'APROVADO'
	ELSE IF @nota = 'C'
		set @situacao = 'EM RECUPERAÇÃO'
	ELSE IF @nota = 'F'
		SET @situacao = 'REPROVADO'
	ELSE
		SET @situacao = 'SEM REGISTRO'

	RETURN @situacao
END	
select dbo.fn_situacaoAlunos ('Silva','Matemática Discreta') as situacao
```
### questão 11
```sql
-- QUESTÃO 11
CREATE FUNCTION fn_NotaParaNumero (@nota char (1))
returns int
as
begin
	declare @n INT;
	IF @nota = 'A'
		SET @n = 10;
	IF @nota = 'B'
		SET @n = 9;
	IF @nota = 'C'
		SET @n = 8;
	IF @nota = 'F'
		SET @n = 0;
	RETURN @n;
end;

go
select a.Nome, d.Nome_disciplina, he.Nota, dbo.fn_NotaParaNumero(he.Nota) as nota
from aluno as a
join HISTORICO_ESCOLAR as he on he.Numero_aluno = a.Numero_aluno
join turma as t on t.Identificacao_turma = he.Identificacao_turma
join DISCIPLINA as d on t.Numero_disciplina = d.Numero_disciplina
```

### questão 12
```sql
-- QUESTÃO 12
alter FUNCTION fn_situacaoTurma (@turma int)
RETURNS VARCHAR(30)
AS
BEGIN
	DECLARE @situacao varchar(30)
	DECLARE @qtd_alunos int
	SELECT @qtd_alunos = COUNT (he.Numero_aluno)
	FROM HISTORICO_ESCOLAR AS HE
	WHERE HE.Identificacao_turma = @turma

	if @qtd_alunos >=5
		set @situacao = 'COMPLETAMENTE LOTADA'
	else if @qtd_alunos = 3 or @qtd_alunos = 4
			set @situacao = 'QUASE CHEIA'
	else if @qtd_alunos < 3
		set @situacao = 'COM VAGAS'

	return @situacao
END

--- consulta
DECLARE @qtd_alunos int
SELECT @qtd_alunos = COUNT (he.Numero_aluno)
FROM HISTORICO_ESCOLAR AS HE
where he.Identificacao_turma = 85

SELECT D.Nome_disciplina,T.Identificacao_turma, @qtd_alunos as n_alunos, dbo.fn_situacaoTurma (85) as situação
from turma as t
INNER JOIN DISCIPLINA AS D
ON T.Numero_disciplina = D.Numero_disciplina
where t.Identificacao_turma = 85


```
```sql
-- correção
create function fn_statusLotacao (@idTurma INT)
returns varchar(30)
as
begin
	declare @qtd int, @status varchar(30);
	select @qtd = COUNT(he.Numero_aluno) 
	from HISTORICO_ESCOLAR as he
	where he.Identificacao_turma = @idTurma

	if @qtd >=5
		set @status = 'Completamente Lotada'
	else if @qtd BETWEEN 3 AND 4
		set @status = 'Quase cheia'
	else 
		set @status = 'Há vagas'
	return @status;
end;


go
select distinct HE.Identificacao_turma, DBO.fn_statusLotacao(HE.Identificacao_turma)
from HISTORICO_ESCOLAR as he

```













