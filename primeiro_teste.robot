*** Settings ***
Documentation     Primeiro teste: cadastro de um colaborador no Organo.
Resource          resources/organo.resource
Test Setup        Abrir o Organo
Test Teardown     Close Browser

*** Test Cases ***
Deve preencher o formulário e criar o card do colaborador
    Criar card e validar no time    Allan    Desenvolvedor    Programação
