*** Settings ***
Suite Setup    Conectar a API
Resource    ./resources.robot

*** Test Cases ***
Buscar a Listagem de todos os livros (GET)
    Requisitar todos os livros
    Conferir Statuscode    200
    Conferir o Reason    OK
    Conferir se retorna uma lista de "200" livros

Buscar um Livro especifico (GET)
    Requisitar livro "15"
    Conferir Statuscode    200
    Conferir o Reason    OK
    Conferir se e o id do livro é igual a "15"
    Confere outras informacoes do livro    

Alterar um Livro (PUT)
#Conferir se retorna todos os dados do livro

Deletar um Livro (DELETE)
#conferir se o livro 200 foi deletado 

