# Day 6 – Write to a Sequential File in COBOL

## 🎯 Objetivos

- Aprender a criar e escrever num ficheiro
- Usar `OPEN OUTPUT` e `WRITE`
- Criar registos antes de gravar no ficheiro
- Simular um pequeno processo batch

## 🧠 Conceito

Este programa permite inserir nomes de clientes e guardá-los num ficheiro sequencial chamado `customers.txt`.  
O utilizador pode inserir múltiplos nomes até decidir sair.

Exemplo de ficheiro gerado (`customers.txt`):

```
John Smith
Maria Silva
Pedro Costa
```

## 📚 Conceitos COBOL usados

- `OPEN OUTPUT`
- `WRITE`
- `ACCEPT`
- `PERFORM UNTIL`
- `FILE STATUS`

## 🧾 Exemplo de interação

```
Enter customer name: John Smith
Add another? (Y/N): Y

Enter customer name: Maria Silva
Add another? (Y/N): Y

Enter customer name: Pedro Costa
Add another? (Y/N): N

Customers saved successfully.
```

## 🚀 Skills que vais ganhar

- Criar ficheiros em COBOL
- Escrever registos sequenciais
- Simular batch job básico
- Base para processamento de dados real

## 💡 Estrutura de repositório recomendada

```
day06/
│
├── day06-write-file.cob
├── customers.txt
└── README.md
```
