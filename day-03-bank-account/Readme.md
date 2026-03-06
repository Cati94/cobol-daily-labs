 
# Sistema Bancário em COBOL

Este é um **programa simples de sistema bancário** implementado em COBOL, desenvolvido como exercício de prática da linguagem. Permite gerenciar clientes, depósitos, levantamentos e consultas de saldo, além de gerar um relatório final com o total de operações.

## Funcionalidades

O programa implementa as seguintes funcionalidades:

1. **Listar clientes** – Exibe os clientes disponíveis no sistema.
2. **Depositar** – Permite depositar um valor na conta de um cliente.
3. **Levantar** – Permite levantar um valor da conta de um cliente, verificando saldo suficiente.
4. **Consultar saldo** – Mostra o saldo atual de um cliente específico.
5. **Sair** – Encerra o programa e apresenta um relatório final com:

   * Total de depósitos realizados
   * Total de levantamentos realizados

## Estrutura do Programa

* **IDENTIFICATION DIVISION** – Define o nome do programa (`BANK-SYSTEM`).
* **DATA DIVISION** – Define as variáveis de trabalho (`WORKING-STORAGE`), incluindo:

  * Lista de clientes e seus saldos
  * Contadores de depósitos e levantamentos
  * Variáveis temporárias para operações
* **PROCEDURE DIVISION** – Contém a lógica principal, incluindo:

  * Inicialização de dados
  * Menu interativo
  * Rotinas para cada operação (listar clientes, depositar, levantar, consultar saldo)
  * Relatório final

## Como usar

1. **Compilar** o programa com um compilador COBOL (ex.: `GnuCOBOL`):

   ```bash
   cobc -x bank-system.cob
   ```

2. **Executar** o programa:

   ```bash
   ./bank-system
   ```

3. Seguir as instruções no menu para realizar operações bancárias.

## Detalhes Técnicos

* O programa suporta até **5 clientes** fixos.
* Os saldos e valores são tratados como **números decimais com duas casas decimais**.
* Todas as entradas são validadas para evitar depósitos negativos ou levantamentos superiores ao saldo.

## Exemplo de Execução

```text
---------------------------
 SISTEMA BANCARIO COBOL
---------------------------
1 - Listar clientes
2 - Depositar
3 - Levantar
4 - Consultar saldo
5 - Sair
Escolha uma opcao: 1

Clientes disponíveis:
1 - Ana
2 - Joao
3 - Maria
4 - Carlos
5 - Sofia
```

## Objetivos do Projeto

* Praticar **estrutura básica de um programa COBOL**
* Implementar **menus interativos e loops**
* Trabalhar com **arrays (`OCCURS`)** e operações aritméticas
* Gerar **relatórios simples** ao final da execução
