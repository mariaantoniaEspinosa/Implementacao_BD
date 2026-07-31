/* ModeloLogicoBiblioteca: */

CREATE TABLE Livros (
    Titulo VARCHAR(255),
    Ano INT,
    ISBN INT PRIMARY KEY,
    Editora VARCHAR(255),
    fk_Categoria_Codigo VARCHAR(255)
);

CREATE TABLE Categoria (
    Codigo VARCHAR(255) PRIMARY KEY,
    Descricao VARCHAR(255)
);

CREATE TABLE Autores (
    Nacionalidade VARCHAR(255),
    CPF INT PRIMARY KEY,
    Nome VARCHAR(255)
);

CREATE TABLE Escreve (
    fk_Autores_CPF INT,
    fk_Livros_ISBN INT
);
 
ALTER TABLE Livros ADD CONSTRAINT FK_Livros_2
    FOREIGN KEY (fk_Categoria_Codigo)
    REFERENCES Categoria (Codigo)
    ON DELETE CASCADE;
 
ALTER TABLE Escreve ADD CONSTRAINT FK_Escreve_1
    FOREIGN KEY (fk_Autores_CPF)
    REFERENCES Autores (CPF)
    ON DELETE RESTRICT;
 
ALTER TABLE Escreve ADD CONSTRAINT FK_Escreve_2
    FOREIGN KEY (fk_Livros_ISBN)
    REFERENCES Livros (ISBN)
    ON DELETE SET NULL;