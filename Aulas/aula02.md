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

```
<img width="387" height="188" alt="image" src="https://github.com/user-attachments/assets/9d50f32d-634b-4df4-b818-3d289d27703b" />
