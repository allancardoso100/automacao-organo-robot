# automacao-organo-robot

Testes automatizados com Robot Framework e SeleniumLibrary para o [Organo](https://github.com/alura-cursos/robot-framework-organo), feitos no curso de Robot Framework da Alura.

## Estrutura

```
resources/organo.resource   variáveis, seletores e keywords compartilhados
primeiro_teste.robot        cadastro básico de um colaborador
cadastro_organo.robot       cobertura completa do formulário (14 testes)
```

## O que é testado

- Lista suspensa com os 7 times e uma seção para cada time
- Criação de card em cada time, com nome, cargo e imagem
- Imagem opcional, formulário limpo após o envio, vários cards no mesmo time
- Mensagens de erro dos campos obrigatórios (nome, cargo e time)
- Remoção do erro e criação do card após corrigir o formulário

## Como executar

Requisitos: Python 3, Google Chrome e Node.js.

1. Suba o Organo em `http://localhost:3000`:
   ```
   git clone https://github.com/alura-cursos/robot-framework-organo
   cd robot-framework-organo
   npm install
   npm start
   ```
2. Instale as dependências dos testes:
   ```
   pip install robotframework robotframework-seleniumlibrary
   ```
3. Rode os testes na raiz deste projeto:
   ```
   robot .
   ```

Os resultados ficam em `report.html` e `log.html`.
