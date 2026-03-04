# Day 01 — Invoice Generator

## 📦 Overview

Primeiro exercício do desafio **30 Days of COBOL**.

Implementação de um gerador de faturas simples com cálculo automático de:

- Subtotal
- IVA
- Total final

O objetivo é consolidar fundamentos de estrutura COBOL e operações aritméticas com decimais.

---

## 🎯 Functional Requirements

O programa deve:

1. Receber via input:
   - Nome do cliente
   - Produto
   - Quantidade
   - Preço unitário
   - IVA (%)

2. Calcular:
   - `SUBTOTAL = QUANTIDADE × PRECO`
   - `VALOR_IVA = SUBTOTAL × (IVA / 100)`
   - `TOTAL = SUBTOTAL + VALOR_IVA`

3. Apresentar fatura formatada no terminal.

---

## 🧠 Data Model

```cobol
01 WS-CLIENTE        PIC X(30).
01 WS-PRODUTO        PIC X(30).
01 WS-QUANTIDADE     PIC 9(4).
01 WS-PRECO          PIC 9(5)V99.
01 WS-IVA            PIC 9(2)V99.

01 WS-SUBTOTAL       PIC 9(7)V99.
01 WS-VALOR-IVA      PIC 9(7)V99.
01 WS-TOTAL          PIC 9(7)V99.
```

### Notas Técnicas

- `V` representa posição decimal implícita.
- Todos os cálculos são feitos com aritmética inteira com ponto decimal virtual.
- Percentagem é ajustada com `DIVIDE 100`.

---

## 🏗 Program Structure

```
IDENTIFICATION DIVISION
DATA DIVISION
WORKING-STORAGE SECTION
PROCEDURE DIVISION
```

Fluxo lógico:

```
INICIO
  → Captura de dados (ACCEPT)
  → Cálculo de subtotal (MULTIPLY)
  → Cálculo de IVA
  → Cálculo de total (ADD)
  → Output formatado (DISPLAY)
STOP RUN
```

---

## 🖨 Example Output

```
-------------------------------
            FATURA
-------------------------------
Cliente: Catarina Silva
Produto: Teclado Mecânico
Quantidade: 2
Preço Unitário: 45.00

Subtotal: 90.00
IVA (23%): 20.70
-------------------------------
TOTAL: 110.70
-------------------------------
```

---

## ⚙️ Concepts Applied

- PIC 9(n)V99
- ACCEPT
- DISPLAY
- MULTIPLY
- DIVIDE
- ADD
- Structured procedural flow
- Terminal formatting

---

## 🧪 Compilation

```bash
cobc -x invoice.cob -o invoice
```

Run:

```bash
./invoice
```

---

## 📉 Current Limitations

- Apenas um produto por fatura
- Não persiste dados em ficheiro
- Sem validação de input
- Sem número automático de fatura
- Sem tratamento de erros

---

## 🚀 Possible Improvements

- Loop para múltiplos produtos
- Sistema de descontos
- Geração automática de número de fatura
- Escrita em ficheiro sequencial
- Formatação monetária avançada
- Separação em parágrafos modulares

---

## 📌 Commit Message

```
Day 01 — Invoice Generator (calculations and formatted output)
```

---

Este primeiro dia foca-se em **precisão numérica e estrutura formal COBOL**, estabelecendo base sólida para exercícios com ficheiros e processamento batch nos próximos dias.
