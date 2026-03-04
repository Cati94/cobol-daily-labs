# Day 01 — Invoice Generator

🎯 **Objetivo**  

Simular a geração de uma fatura simples com:

- Nome do cliente  
- Produto  
- Quantidade  
- Preço unitário  
- IVA (%)  
- Cálculo de subtotal  
- Cálculo de imposto  
- Total final formatado  

Este exercício é real, prático e empresarial.

---

## 🧠 Modelo de Dados

```cobol
WORKING-STORAGE
01 WS-CLIENTE        PIC X(30).
01 WS-PRODUTO        PIC X(30).
01 WS-QUANTIDADE     PIC 9(4).
01 WS-PRECO          PIC 9(5)V99.
01 WS-IVA            PIC 9(2)V99.

01 WS-SUBTOTAL       PIC 9(7)V99.
01 WS-VALOR-IVA      PIC 9(7)V99.
01 WS-TOTAL          PIC 9(7)V99.
```

---

## 🔢 Fórmulas

```
SUBTOTAL = QUANTIDADE × PREÇO
VALOR_IVA = SUBTOTAL × (IVA / 100)
TOTAL = SUBTOTAL + VALOR_IVA
```

---

## 🏗 Estrutura do Programa

1. **IDENTIFICATION DIVISION** — Nome do programa  
2. **DATA DIVISION** — WORKING-STORAGE com todos os campos  
3. **PROCEDURE DIVISION** — Fluxo:

```
INICIO
 ↓
Ler dados
 ↓
Calcular subtotal
 ↓
Calcular IVA
 ↓
Calcular total
 ↓
Mostrar fatura formatada
 ↓
Terminar
```

---

## 🖨 Output Esperado

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

## ⚙️ Conceitos Técnicos Aplicados

- PIC 9V99  
- Cálculos com decimais  
- MOVE  
- MULTIPLY  
- DIVIDE  
- DISPLAY estruturado  

---

## 📈 Limitações

- Não guarda ficheiro  
- Não valida input  
- Apenas um produto  
- Não suporta múltiplas linhas  

---

## 🚀 Desafio Extra (opcional)

- Permitir múltiplos produtos  
- Permitir repetir o processo  
- Adicionar desconto  
- Criar número automático de fatura  

---

## ⚡ Commit

```bash
git add day01-invoice-generator/invoice.cob
git commit -m "Day 01 — Invoice Generator (calculations and formatted output)"
```
