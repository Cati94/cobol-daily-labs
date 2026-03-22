# Dia 21 – Sistema Bancário em COBOL: Relatórios e Estatísticas

## Descrição

Este programa é um **sistema bancário completo** escrito em COBOL, que permite:

- Criar e consultar contas
- Realizar depósitos e levantamentos
- Consultar histórico de transações com numeração sequencial
- Listar todas as contas
- Gerar relatório de contas com saldo acima de um valor informado (`report.txt`)
- Exibir estatísticas do banco: total de contas, saldo total, maior e menor saldo

Os valores monetários são armazenados com **2 casas decimais** e as datas das transações seguem o formato `DD/MM/YYYY`.

---

## Arquivos usados

- `accounts.dat` – armazena todas as contas do banco
- `transactions.dat` – armazena todas as transações
- `report.txt` – arquivo de relatório gerado para contas com saldo acima do valor filtrado

---

## Como compilar e executar

1. Compilar usando **GnuCOBOL**:

```bash
cobc -x BANK-SYSTEM-D21.cob
