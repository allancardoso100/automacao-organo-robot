*** Settings ***
Documentation     Cobertura do formulário de cadastro de colaboradores do Organo.
Resource          resources/organo.resource
Test Setup        Abrir o Organo
Test Teardown     Close Browser

*** Test Cases ***
Deve exibir todos os times na lista suspensa
    ${opcoes}=    Get List Items    ${CAMPO_TIME}
    ${esperado}=    Create List    ${EMPTY}    @{TIMES}
    Lists Should Be Equal    ${opcoes}    ${esperado}

Deve exibir uma seção para cada time
    FOR    ${time}    IN    @{TIMES}
        Element Should Be Visible    xpath://section[@class='time']/h3[text()='${time}']
    END

Não deve haver cards antes de cadastrar
    Page Should Not Contain Element    class:colaborador

Deve criar card em cada um dos times
    [Template]    Criar card e validar no time
    Ana Programação     Dev Backend       Programação
    Bruno Front         Dev Frontend      Front-End
    Carla Dados         Cientista         Data Science
    Diego Ops           SRE               Devops
    Elisa UX            Designer          UX e Design
    Fábio Mobile        Dev Android       Mobile
    Gabi Gestão         Gerente           Inovação e Gestão

Deve exibir nome, cargo e imagem no card
    Preencher formulário    Allan    Desenvolvedor    Programação    ${IMAGEM}
    Click Element    ${BOTAO_CARD}
    ${card}=    Set Variable    xpath://div[@class='colaborador'][.//h4[text()='Allan']]
    Element Text Should Be    ${card}//h5    Desenvolvedor
    Element Attribute Value Should Be    ${card}//img    src    ${IMAGEM}
    Element Attribute Value Should Be    ${card}//img    alt    Allan

Deve criar card sem imagem pois o campo é opcional
    Preencher formulário    Sem Foto    Analista    Mobile
    Click Element    ${BOTAO_CARD}
    Card deve estar no time    Sem Foto    Mobile

Deve limpar o formulário após criar o card
    Preencher formulário    Allan    Desenvolvedor    Devops    ${IMAGEM}
    Click Element    ${BOTAO_CARD}
    Textfield Value Should Be    ${CAMPO_NOME}      ${EMPTY}
    Textfield Value Should Be    ${CAMPO_CARGO}     ${EMPTY}
    Textfield Value Should Be    ${CAMPO_IMAGEM}    ${EMPTY}
    List Selection Should Be    ${CAMPO_TIME}    ${EMPTY}

Deve criar vários cards no mesmo time
    FOR    ${nome}    IN    Pessoa 1    Pessoa 2    Pessoa 3
        Preencher formulário    ${nome}    QA    Front-End
        Click Element    ${BOTAO_CARD}
    END
    ${total}=    Get Element Count
    ...    xpath://section[@class='time'][h3[text()='Front-End']]//div[@class='colaborador']
    Should Be Equal As Integers    ${total}    3

Deve exibir todos os erros ao enviar formulário vazio
    Click Element    ${BOTAO_CARD}
    Element Text Should Be    ${ERRO_NOME}     O campo nome deve ser preenchido
    Element Text Should Be    ${ERRO_CARGO}    O campo cargo deve ser preenchido
    Element Text Should Be    ${ERRO_TIME}     Selecione um time para essa pessoa
    Page Should Not Contain Element    class:colaborador

Deve validar nome obrigatório
    Preencher formulário    ${EMPTY}    Desenvolvedor    Programação
    Click Element    ${BOTAO_CARD}
    Element Should Be Visible    ${ERRO_NOME}
    Page Should Not Contain Element    ${ERRO_CARGO}
    Page Should Not Contain Element    ${ERRO_TIME}
    Page Should Not Contain Element    class:colaborador

Deve validar cargo obrigatório
    Preencher formulário    Allan    ${EMPTY}    Programação
    Click Element    ${BOTAO_CARD}
    Element Should Be Visible    ${ERRO_CARGO}
    Page Should Not Contain Element    ${ERRO_NOME}
    Page Should Not Contain Element    ${ERRO_TIME}
    Page Should Not Contain Element    class:colaborador

Deve validar time obrigatório
    Preencher formulário    Allan    Desenvolvedor    ${EMPTY}
    Click Element    ${BOTAO_CARD}
    Element Should Be Visible    ${ERRO_TIME}
    Page Should Not Contain Element    ${ERRO_NOME}
    Page Should Not Contain Element    ${ERRO_CARGO}
    Page Should Not Contain Element    class:colaborador

Deve remover o erro ao preencher o campo
    Click Element    ${BOTAO_CARD}
    Element Should Be Visible    ${ERRO_NOME}
    Input Text    ${CAMPO_NOME}    Allan
    Page Should Not Contain Element    ${ERRO_NOME}

Deve criar o card após corrigir os erros
    Click Element    ${BOTAO_CARD}
    Element Should Be Visible    ${ERRO_NOME}
    Preencher formulário    Allan    Desenvolvedor    Data Science
    Click Element    ${BOTAO_CARD}
    Card deve estar no time    Allan    Data Science
    Page Should Not Contain Element    ${ERRO_NOME}
