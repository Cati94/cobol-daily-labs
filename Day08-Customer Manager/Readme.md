# Customer Manager

O **Customer Manager** é um programa em COBOL que permite gerenciar clientes de forma simples, com funcionalidades de adicionar, listar e buscar clientes em um arquivo de dados (`customers.dat`).

---

## Funcionalidades

1. **Adicionar Cliente**
   - Solicita ID (3 dígitos), nome e email do cliente.
   - Salva os dados no arquivo `customers.dat`.

2. **Listar Clientes**
   - Exibe todos os clientes cadastrados com ID, nome e email.

3. **Buscar Cliente**
   - Permite buscar um cliente pelo ID.
   - Exibe os dados do cliente encontrado.

4. **Sair**
   - Encerra o programa de forma segura.

---

## Fluxo do Programa

```text
┌───────────────────────────┐
│       CUSTOMER MANAGER     │
├───────────────────────────┤
│ 1 - Add Customer           │
│ 2 - List Customers         │
│ 3 - Search Customer        │
│ 4 - Exit                   │
└───────────────────────────┘
          │
          ▼
Escolhe uma opção
          │
 ┌───────────────┐
 │ Option 1      │
 │ Add Customer  │
 └───────────────┘
          │
Digite ID, Nome e Email
          ▼
Cliente salvo no arquivo
          │
 ┌───────────────┐
 │ Option 2      │
 │ List Customers│
 └───────────────┘
          │
Exibe todos os clientes cadastrados
          │
 ┌───────────────┐
 │ Option 3      │
 │ Search Customer│
 └───────────────┘
          │
Digite ID do cliente → exibe dados se encontrado
          │
 ┌───────────────┐
 │ Option 4      │
 │ Exit          │
 └───────────────┘
          │
          ▼
Programa encerrado

## Fluxo do Programa (Ilustração ASCII)

```text
        ┌───────────────────────────┐
        │       CUSTOMER MANAGER     │
        ├───────────────────────────┤
        │ 1 - Add Customer           │
        │ 2 - List Customers         │
        │ 3 - Search Customer        │
        │ 4 - Exit                   │
        └───────────────────────────┘
                  │
                  ▼
          Escolhe uma opção
                  │
      ┌───────────┼───────────┐
      │           │           │
      ▼           ▼           ▼
 ┌─────────┐ ┌────────────┐ ┌───────────────┐
 │Option 1 │ │Option 2    │ │Option 3       │
 │Add      │ │List        │ │Search         │
 │Customer │ │Customers   │ │Customer by ID │
 └─────────┘ └────────────┘ └───────────────┘
      │           │           │
      ▼           ▼           ▼
 Digita ID,    Exibe todos   Digita ID do
 Nome, Email  os clientes   cliente → se
 e salva no   cadastrados   encontrado,
 arquivo                   exibe dados
      │           │           │
      └───────────┴───────────┘
                  │
                  ▼
            ┌─────────┐
            │Option 4 │
            │Exit     │
            └─────────┘
                  │
                  ▼
          Programa encerrado






Requisitos

Compilador COBOL (ex.: GnuCOBOL)

Terminal/Console para execução interativa

Como Executar

Compile o programa:

cobc -x customer-manager.cob

Execute o programa:

./customer-manager

Siga as instruções do menu interativo.

Observações

O arquivo customers.dat é criado automaticamente se não existir.

IDs de clientes devem ter exatamente 3 dígitos.

O programa é feito para uso em terminal/console, ideal para aprendizado e demonstrações.
