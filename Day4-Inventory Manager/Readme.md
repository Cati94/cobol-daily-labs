# Inventory System - COBOL

![Logo](https://github.com/Cati94/cobol-daily-labs/blob/main/Day4-Inventory%20Manager/inventory.png)

Um sistema simples de gestão de inventário desenvolvido em **COBOL**, permitindo listar produtos, adicionar e remover stock, consultar produtos e criar novos produtos.

---

## Funcionalidades

- **Listar produtos:** Exibe todos os produtos cadastrados com o respetivo stock.
- **Adicionar stock:** Permite aumentar a quantidade de um produto existente.
- **Remover stock:** Permite diminuir a quantidade de um produto existente.
- **Consultar produto:** Exibe detalhes de um produto específico.
- **Novo produto:** Permite cadastrar um produto em uma posição específica do inventário.
- **Sair:** Encerra o programa.

---

## Estrutura do Código

- **IDENTIFICATION DIVISION:** Contém o nome do programa.
- **DATA DIVISION:** Define variáveis de armazenamento e arrays para produtos e stock.
- **WORKING-STORAGE SECTION:** Variáveis auxiliares para opções, IDs e quantidades.
- **PROCEDURE DIVISION:** Contém a lógica principal, menu interativo e funções de manipulação do inventário.

---

## Tecnologias

- COBOL (compatível com GNU COBOL/OpenCOBOL)

---

## Como executar

1. Instale o [GNU COBOL](https://www.gnu.org/software/gnucobol/) no seu sistema.
2. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/inventory-cobol.git
   ```
3. Compile o programa:
   ```bash
   cobc -x INVENTORY.cob
   ```
4. Execute o programa:
   ```bash
   ./INVENTORY
   ```

---

## Estrutura inicial do inventário

| ID | Produto   | Stock |
|----|----------|-------|
| 1  | Laptop   | 10    |
| 2  | Mouse    | 50    |
| 3  | Teclado  | 20    |
| 4  | Monitor  | 15    |
| 5  | Cabo USB | 100   |

---

## Observações

- Atualmente, o inventário suporta até 5 produtos fixos.  
- Futuras melhorias podem incluir:
  - Suporte a um número ilimitado de produtos.
  - Validação de entradas inválidas.
  - Persistência em ficheiro para manter dados entre execuções.

---

## Autor

**Catarina** - Professora e entusiasta de programação COBOL
