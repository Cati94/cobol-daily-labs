# Dia 20 – Sistema de Faturação em COBOL

## Descrição

Neste exercício do desafio **30 Dias de COBOL**, desenvolvemos um **sistema de faturação** que permite:

- Gestão de produtos com preço e stock.
- Criação de faturas associadas a clientes.
- Cálculo automático de valores totais.
- Registo persistente de produtos e faturas em ficheiros sequenciais.

O objetivo é praticar **ficheiros sequenciais**, **cálculos aritméticos** e **menus interativos**.

---

## Ficheiros

- `products.dat` – Dados dos produtos:

PROD-ID, PROD-NAME, PROD-PRICE, PROD-QTY

- `invoices.dat` – Faturas geradas:

INV-ID, INV-DATE, INV-PROD-ID, INV-QTY, INV-TOTAL


> Exemplos incluídos para teste rápido.

---

## Como Executar

1. Compila o programa:

```bash
cobc -x INVOICE-SYSTEM.cob

    Executa:

./INVOICE-SYSTEM

    Usa o menu interativo para:

    Listar produtos

    Criar faturas

    Listar faturas

    Adicionar produtos

Funcionalidades

    Listagem de produtos e faturas.

    Adição de produtos com preço e stock.

    Criação de faturas com cálculo automático do total.

    Validação de stock disponível.

    Registo persistente de dados em ficheiros sequenciais.

Objetivos de Aprendizagem

    Manipulação de ficheiros em COBOL.

    Cálculos automáticos e validação de dados.

    Criação de menus interativos.

    Registo histórico de transações e faturas.

Autor

Catarina – Desafio 30 Dias de COBOL – Dia 20
