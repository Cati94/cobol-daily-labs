# COBOL Sequential File -- Write and Read

📅 **Dia 7**

Este projeto demonstra como escrever e ler dados de um ficheiro
sequencial em COBOL.

## Objetivo

Aprender os conceitos básicos de: - Escrita de dados em ficheiros
sequenciais - Leitura de dados de ficheiros sequenciais - Estrutura
básica de programas COBOL com ficheiros

## Fluxo do Programa

![Fluxo do
Programa](an_educational_flowchart_style_digital_illustratio.png)

## Funcionamento

1.  O utilizador insere dados.
2.  O programa COBOL de escrita grava os dados num ficheiro sequencial.
3.  O programa COBOL de leitura lê os dados do ficheiro.
4.  Os dados são apresentados ao utilizador.

### Exemplo de dados

    John Smith
    Maria Silva
    Pedro Costa

### Saída esperada

    Customer List:
    John Smith
    Maria Silva
    Pedro Costa
    End of customer list.

## Estrutura do Projeto

    project/
    │
    ├── write.cbl
    ├── read.cbl
    ├── customers.dat
    ├── README.md
    └── an_educational_flowchart_style_digital_illustratio.png

## Compilar e Executar (Linux)

Compilar:

``` bash
cobc -x write.cbl
cobc -x read.cbl
```

Executar:

``` bash
./write
./read
```

## Conceitos COBOL usados

-   OPEN OUTPUT
-   WRITE
-   OPEN INPUT
-   READ
-   AT END
-   Ficheiros sequenciais
