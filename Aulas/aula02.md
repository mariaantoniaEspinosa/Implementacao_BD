# Revisão pt2 
- Modelo entidade - relacionamento: conceitual X lógico
- Ferramenta CASE
- Conceitos trabalhados na aula passada:
  - entidade (retângulo)
  - atributos (bolinha pintada)
    - identificador
    - natural
    - composto
  - associações/relacionamentos/cardinalidades (losango)
    - 1 pra 1
    - 1 pra muitos
    - muitos pra muitos
    - o N puxa a chave estrangeira (FK)
    - quando não tem N, a chave estrangeira fica do lado que não há valor nulo (0)
    - N pra N -> se torna uma entidade (associativa) -> se torna uma nova tabela com o nome composto das outras duas entidades
      - chaves estrangeiras vão para essa nova tabela
      - pode haver atributos
  - entidade fraca: chave primária é composta -> a dele e a da entidade em que se relaciona (quadrado duplicado com linha em negrito)
    - é dependente de outra entidade
  - auto relacionamento: cria-se uma nova chave estrangeira
# MySQL
*obs*: ctrl + alt + del: selecionar gerenciador de tarefas, clicar no quebra-cabeça e iniciar o MySQL
- é um servidor conectado na rede que pode ser conectado pelo ip da máquina
## DDL
- Data Definition Language 
- create
- alter
- drop
- truncate
- criação de objetos do banco de dados
## DML
- Data Manipulation Language
- select
- insert
- update
- delete
## DCL
- Data Control Language
- grant
- revoke
## TCL
- Tool Command Language
- save point
- roll back
- commit
### DDL 
# Prática de aula
```sql

-- Criando meu banco
CREATE DATABASE biblioteca;
-- Colocar o banco criado em uso
USE biblioteca;

-- Criando minha primeira tabela
CREATE TABLE autor(
	id INT PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    nacionalidade VARCHAR(100)
);

-- Criando minha segunda tabela com chave estrangeira
CREATE TABLE livro(
	id INT PRIMARY KEY,
    titulo TEXT,
    ano_publicacao YEAR,
    fk_id_autor INT, 
    FOREIGN KEY (fk_id_autor) REFERENCES autor(id)
);

-- Excluindo uma tabela
DROP TABLE nome_tabela;

-- Adicionando FK via alteração
ALTER TABLE livro
ADD CONSTRAINT fk_autor -- nome da restrição
FOREIGN KEY (fk_id_autor) REFERENCES autor(id);

-- Adicionando uma coluna
ALTER TABLE livro
ADD genero VARCHAR(100) NOT NULL;

-- Remover uma coluna
ALTER TABLE livro
DROP COLUMN genero;

-- Modificar tipo de uma coluna
ALTER TABLE autor
MODIFY COLUMN nacionalidade CHAR(2);

-- Alterando nome de uma coluna
ALTER TABLE livro
CHANGE id ISBN VARCHAR(20);

```
<img width="387" height="188" alt="image" src="https://github.com/user-attachments/assets/9d50f32d-634b-4df4-b818-3d289d27703b" />

# Exemplo 02
```sql
CREATE DATABASE biblioteca;
USE biblioteca;

CREATE TABLE autor(
	id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL,
    nacionalidade VARCHAR(100) NOT NULL,
    ano_nascimento YEAR
);

CREATE TABLE livro(
	ISBN CHAR(13) PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    ano_publicacao YEAR,
    fk_id_autor INT,
    fk_id_editora INT,
    FOREIGN KEY (fk_id_autor) REFERENCES autor(id_autor),
    FOREIGN KEY (fk_id_editora) REFERENCES editora(id)
);

CREATE TABLE editora(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(50),
    site VARCHAR(100),
    ano_fundacao YEAR
);

INSERT INTO autor (nome, nacionalidade, ano_nascimento)
VALUES ("Machado de Assis", "brasileiro", 1939);

INSERT INTO autor
VALUES (NULL, "George Orwell", "britânico", 1903);

INSERT INTO autor
VALUES (NULL, "Juca da silva", "brasileiro", 2010);

-- Recuperando as informações
SELECT * FROM autor;

INSERT INTO editora (nome, cidade, site, ano_fundacao)
VALUES 
	("Companhia das Letras", "São Paulo", "www.cdl.br", 1986),
	("Penguin Books", "Londres", "www.pmg.ldm", 1935);
    
SELECT * FROM editora;

INSERT INTO livro (titulo, ISBN, ano_publicacao, fk_id_autor, fk_id_editora)
VALUES 
	("Dom Casmurro", "987456", 1910, 1, 1),
	("1984", "123456", 1949, 2, 2);
    
TRUNCATE livro;

DELETE FROM autor
WHERE autor.id_autor = 3;

UPDATE autor
SET autor.nacionalidade = "Brasileiro"
WHERE autor.id_autor = 1;

-- operadores WHERE: =, <, <=, >, >=, <> OU !=, BETWEEN, LIKE, AND , OR

SELECT l.titulo, l.ano_publicacao
FROM livro AS l
WHERE l.titulo LIKE "%Dom%";

SELECT 
	l.titulo AS "Titulo",
    l.ano_publicacao AS "Ano",
	CONCAT (a.nome, "/", a.nacionalidade) AS "Autor/Nacionalidade",
    e.nome AS "Editora"
FROM livro AS l
JOIN autor AS a ON l.fk_id_autor = a.id_autor -- junção das duas tabelas 
JOIN editora AS e ON l.fk_id_editora = e.id 
               
```

<img width="695" height="213" alt="image" src="https://github.com/user-attachments/assets/e3c356af-d615-4ead-908a-ef39d717ba4f" />

