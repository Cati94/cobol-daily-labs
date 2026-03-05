# Day 02 — Payroll Calculator

Programa COBOL que calcula salário líquido a partir de um salário bruto,
aplicando deduções de IRS e Segurança Social.

## Funcionalidades

- Cálculo automático de descontos
- Aplicação de percentagens
- Geração de recibo formatado

## Fórmulas

IRS = salário × taxa IRS  
SS = salário × taxa segurança social  

Salário líquido = bruto - IRS - SS

## Conceitos COBOL

- PIC 9V99
- VALUE
- cálculos financeiros
- DISPLAY estruturado

## Limitações

- taxas fixas
- não persiste dados
- apenas um funcionário por execução
