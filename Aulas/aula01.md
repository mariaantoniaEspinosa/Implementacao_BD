- Notas:
  - Nota 1: exercícios em aula (3,0) + prova (7,0);
  - Nota 2: exercícios em aula (3,0) + prova (7,0);
  - Nota 3: atividade avaliativa (10,0).
- *obs*: pode ser trazida uma folha a4 ou a3 para a prova.
# Revisão
- Modelo Entidade Relacionamento Conceitual: serve para eliminar duplicidade de informações 
  - Como representar uma tabela/entidade? Por meio de um retângulo (ex: funcionário);
  - Como representar atributos? Linha com uma bolinha aberta  (ex: nome; cpf; endereço; nascimento...);
  - Não é permitido ter duas linhas iguais em uma tabela; a chave primária é responsável por fazer essa diferenciação; todo campo único é um candidato a uma chave primária;
  - Como representar a chave primária? Por meio de uma bolinha fechada; toda entidade necessita de uma chave primária;
  - Atributos compostos são um conjunto de informações (ex: endereço tem número, cep e rua);
  - Atributos do tipo "telefone(1, n)" significam atributos multivalorados, ou seja, o funcionário pode ter 1 ou n telefones;
  - BRModelo Jar: baixar!
  - Para relacionar mais de uma tabela é necessário colocar um losango entre a linha que conecta ambas, chamado de "alocação".
  - No relacionamento de duas tabelas é necessário definir a cardinalidade entre elas.
  - Na relação de cardinalidade com n, o n puxa a chave estrangeira para ele 
  - Não deve haver uma representação da chave estrangeira no modelo conceitual.
  - Pode haver outro losango representando outro relacionamento, por exemplo "gerência"
  - Na relação de cardinalidade sem n, a chave estrangeira deve ficar do lado que haverá menor nulidade
    - entre 1,1 e 0,1 a chave vai de 1,1 para 0,1
  - Em uma terceira tabela, com uma relação "trabalha", com cardinalidade de Funcionário (n,) e Projeto (n,), é necessário criar uma tabela nova por causa do relacionamento n para n, que pode ser representada por uma "bandeira do brasil" (losango com qudrado = entidade assossiativa).
  - O nome da nova tabela oriunda da relação nXn é a junção dos nomes das duas tabelas relacionadas.
  - A nova tabela terá uma chave primária composta.
  - Posso colocar atributos nas relações (losangos)
 
    
  - Exemplo de Modelo Conceitual, Lógico e Físico
<img width="411" height="198" alt="image" src="https://github.com/user-attachments/assets/8814df82-00b3-4e8c-a105-76386eefbe0f" />
<br>
<img width="227" height="247" alt="image" src="https://github.com/user-attachments/assets/21a7d34b-489e-4884-9ee0-f449764eb7ab" />
<img width="236" height="216" alt="image" src="https://github.com/user-attachments/assets/ccf91a86-74b3-4b92-a878-e9a3c23882e6" />


<img width="880" height="213" alt="image" src="https://github.com/user-attachments/assets/493e2f2e-db9c-421f-8b72-c079e2829a60" />
<br>
<img width="512" height="296" alt="image" src="https://github.com/user-attachments/assets/c18e9cab-d5e1-4d45-ad4c-7801d3ced2b8" />


<img width="988" height="424" alt="image" src="https://github.com/user-attachments/assets/b0913df1-b260-4f66-bbc9-95b39ea52cbe" />
<br>
<img width="1105" height="331" alt="image" src="https://github.com/user-attachments/assets/f61ab1c7-b4dd-4263-a28f-0beba099ea15" />








