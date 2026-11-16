*** Settings ***
Documentation     Variáveis e keywords compartilhadas pelos testes do Organo.
Library           SeleniumLibrary
Library           Collections

*** Variables ***
${URL}                http://localhost:3000/
${BROWSER}            Chrome
${CAMPO_NOME}         id:form-nome
${CAMPO_CARGO}        id:form-cargo
${CAMPO_IMAGEM}       id:form-imagem
${CAMPO_TIME}         css:.lista-suspensa select
${BOTAO_CARD}         id:form-botao
${ERRO_NOME}          id:form-nome-erro
${ERRO_CARGO}         id:form-cargo-erro
${ERRO_TIME}          id:form-times-erro
${IMAGEM}             https://picsum.photos/200/300
@{TIMES}              Programação    Front-End    Data Science    Devops
...                   UX e Design    Mobile    Inovação e Gestão

*** Keywords ***
Abrir o Organo
    Open Browser    ${URL}    ${BROWSER}
    Wait Until Element Is Visible    ${CAMPO_NOME}

Preencher formulário
    [Arguments]    ${nome}    ${cargo}    ${time}    ${imagem}=${EMPTY}
    IF    $nome      Input Text    ${CAMPO_NOME}      ${nome}
    IF    $cargo     Input Text    ${CAMPO_CARGO}     ${cargo}
    IF    $imagem    Input Text    ${CAMPO_IMAGEM}    ${imagem}
    IF    $time      Select From List By Label    ${CAMPO_TIME}    ${time}

Card deve estar no time
    [Arguments]    ${nome}    ${time}
    Wait Until Element Is Visible
    ...    xpath://section[@class='time'][h3[text()='${time}']]//div[@class='colaborador'][.//h4[text()='${nome}']]

Criar card e validar no time
    [Arguments]    ${nome}    ${cargo}    ${time}
    Preencher formulário    ${nome}    ${cargo}    ${time}    ${IMAGEM}
    Click Element    ${BOTAO_CARD}
    Card deve estar no time    ${nome}    ${time}
