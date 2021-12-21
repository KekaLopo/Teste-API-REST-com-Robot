*** Settings ***
Documentation    Documentacao da API: https://fakerestapi.azurewebsites.net/index.html
Library    RequestsLibrary
Library    Collections

*** Variables *** 
${URL_API}    https://fakerestapi.azurewebsites.net/api/v1



*** Keywords ***
###SETUPS E Teardowns
Conectar a API
    Create Session    fakeAPI    ${URL_API}

###ACOES
Requisitar todos os livros
    ${RESPOSTA}    GET On Session    fakeAPI    Books    
    Log    ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}   

Conferir Statuscode
    [Arguments]    ${STATUSCODE}
    Log    ${RESPOSTA.status_code}
    Should Be Equal As Strings    ${RESPOSTA.status_code}    ${STATUSCODE}
      
Conferir o Reason
    [Arguments]    ${REASON}    
    Log    ${RESPOSTA.reason}
    Should Be Equal As Strings   ${RESPOSTA.reason}    ${REASON}

Conferir se retorna uma lista de "${QNTD_LIVROS}" livros
    Length Should Be    ${RESPOSTA.json()}    ${QNTD_LIVROS}

Requisitar livro "${NUM_LIVRO}"
    ${RESPOSTA}    GET On Session    fakeAPI    Books/${NUM_LIVRO}   
    Log    ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}   
    Set Test Variable    ${NUM_LIVRO} 

Conferir se e o id do livro é igual a "${ID_LIVRO}"
    Dictionary Should Contain Item    ${RESPOSTA.json()}    id    ${ID_LIVRO}

Confere outras informacoes do livro    
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title    Book 15
    Dictionary Should Contain Item    ${RESPOSTA.json()}    pageCount    1500


Cadastrar um novo livro
    ${HEADERS}    Create Dictionary    content-type=application/json
    ${RESPOSTA}   POST On Session   fakeAPI    Books    
    ...                             data={"id": 0,"title": "string","description": "string","pageCount": 0,"excerpt": "string","publishDate": "2021-12-21T14:36:01.222Z"}
    ...                             headers=${HEADERS}
    Log    ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Conferir se retorna todos os dados do livro "${ID_LIVRO}"
    ${HEADERS}    Create Dictionary    content-type=application/json
    ${RESPOSTA}   PUT On Session   fakeAPI    Books/${ID_LIVRO}    
    ...                             data={"id": ${ID_LIVRO} ,"title": "string","description": "string","pageCount": 0,"excerpt": "string","publishDate": "2021-12-21T14:36:01.222Z"}
    ...                             headers=${HEADERS}
    Log    ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Conferir se o livro "${ID_LIVRO}" foi deletado 
    ${RESPOSTA}    DELETE On Session    fakeAPI    Books/${ID_LIVRO}
    Log    ${RESPOSTA.text} 
    Set Test Variable    ${RESPOSTA}