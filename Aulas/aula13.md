## Transações
- commit 
- rollback
  - **A**tomicidade
  - **C**onsistência
  - **I**solamento
  - **D**urabilidade
- Begin Try
- end
- Begin catch
- end
# Triggers
- Conceito: são regras que especificam ações que são disparadas automaticamente por certos aventos
- "Gatilho ou Armadilha"
- Regras **ECA**: Evento-Condição-Ação
- Vinculado a Insert, Update e Delete
- Há triggers sem condição
- Tipo especial de Stored Procedure
## Dois tipos básicos de Triggers
- **After**: Primeiro eu insiro, depois eu faço o que está no triggers; O código é executado após todas as ações terem sido completadas na tabela especificada
- **Instead Of**: O código presente no trigger é executado no lugar da operação que causou seu disparo
  
<img width="897" height="399" alt="image" src="https://github.com/user-attachments/assets/4e675c80-bbc7-4185-aeec-ec728589861c" />

## Fluxo de Transações
1. Verificação de IDENTITY INSERT
2. Restrição (constraint) de Nulos (null)
3. Checagem de tipos de dados
4. Execução de trigger INSTEAD OF
5. Restrição de Chave Primária
6. Restrição de "Check"
7. Restrição de Chave Estrangeira
8. Execução do DML e atualização do log de transações
9. Execução do trigger AFTER
10. Commit da transação (confirmação)
