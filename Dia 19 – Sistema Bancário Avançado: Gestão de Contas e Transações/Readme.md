Dia 19 – Sistema Bancário Avançado em COBOL
Descrição

Neste exercício do desafio 30 Dias de COBOL, criámos um sistema bancário completo que permite gerir contas, realizar transações e manter um histórico detalhado. O objetivo é praticar a manipulação de ficheiros sequenciais, validação de dados e construção de um menu interativo em COBOL.

O programa suporta:

Criação de novas contas com ID único e saldo inicial.
Consulta de contas existentes.
Depósitos e levantamentos com validação de saldo.
Histórico de transações com data, tipo e valor.
Listagem de todas as contas.
Validação de entradas e prevenção de duplicação de contas.
Estrutura de Ficheiros

accounts.dat – Ficheiro sequencial com os dados das contas:

ID do Cliente (4 dígitos), Nome do Titular (30 caracteres), Saldo (7 dígitos + 2 decimais)

transactions.dat – Ficheiro sequencial com o histórico de transações:

ID da Transação, Data (YYYY-MM-DD), Tipo (Depósito/Levantamento), Valor, ID da Conta

Exemplos incluídos nos ficheiros accounts.dat e transactions.dat para teste rápido.

Como Executar
Certifica-te que tens um compilador COBOL instalado (ex: GnuCOBOL).
Compila o programa:
cobc -x BANK-SYSTEM.cob
Executa o programa:
./BANK-SYSTEM
Segue o menu interativo para: criar contas, consultar contas, efetuar transações, ver histórico ou listar todas as contas.
Funcionalidades do Código
Menu interativo com navegação entre todas as funcionalidades.
Validação de IDs duplicados antes da criação de uma nova conta.
Depósitos e levantamentos seguros, sem permitir valores negativos.
Registo automático de transações no ficheiro transactions.dat.
Listagem de contas com saldo atualizado.
Objetivos de Aprendizagem
Manipulação de ficheiros sequenciais em COBOL.
Criação de menus interativos e loops.
Validação de entradas de utilizador.
Registo de histórico e manipulação de dados persistentes.
Autor

Catarina – Desafio 30 Dias de COBOL – Dia 19
