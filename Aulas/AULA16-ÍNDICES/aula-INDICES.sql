create database indice;
use indice;

create table funcionario(
	id int primary key,
	nome varchar(100),
	cargo varchar(50),
	salario decimal(10,2),
	dataAdmissao date
);

insert into funcionario
values 
	(1, 'João', 'Adm', 3500, GETDATE()),
	(2, 'Paulo', 'Tec', 3500, GETDATE()),
	(3, 'Juca', 'TI', 250, GETDATE()),
	(4, 'Maria', 'TI', 12500, GETDATE()),
	(5, 'Cezar', 'Tec', 2500, GETDATE())

select * from funcionario;

declare @contador int = 1;
declare @id int;

select @id = ISNULL(MAX(id), 0) from funcionario;

while @contador <= 300000
begin
	set @id = @id + 1;

	insert into funcionario
	values
	(
		@id,
		'funcionario ' + CAST(@id as varchar(10)),
		case @contador % 5 
			when 0 then 'gerente'
			when 1 then 'desenvolvedor'
			when 2 then 'analista'
			when 3 then 'suporte'
			else 'financeiro'
		end, 
		FLOOR(10000*RAND()) + 1600, 

		DATEADD(DAY, @contador % 3650, '20150101')
	)
	
	set @contador = @contador + 1;
end

select * from funcionario;

set statistics io on;
set statistics time on;

select *
from funcionario
where id = 255000;

select *
from funcionario
where nome like '%255000';

select *
from funcionario
where nome = 'funcionario 255000';

insert into funcionario
values (300100, 'jão', 'adm', 3500, GETDATE());

create nonclustered index ix_funcionario_nome
on funcionario(nome);

select *
from funcionario
where 
	dataAdmissao > '20150101' and 
	dataAdmissao <= '20150201'

drop index ix_funcionario_nome on funcionario;

