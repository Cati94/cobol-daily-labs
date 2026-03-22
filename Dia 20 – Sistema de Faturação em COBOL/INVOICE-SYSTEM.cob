       IDENTIFICATION DIVISION.
       PROGRAM-ID. INVOICE-SYSTEM.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PRODUCTS-FILE ASSIGN TO "products.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT INVOICES-FILE ASSIGN TO "invoices.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD PRODUCTS-FILE.
       01 PRODUCT-RECORD.
           05 PROD-ID       PIC 9(4).
           05 PROD-NAME     PIC A(30).
           05 PROD-PRICE    PIC 9(5)V99.
           05 PROD-QTY      PIC 9(4).

       FD INVOICES-FILE.
       01 INVOICE-RECORD.
           05 INV-ID        PIC 9(4).
           05 INV-DATE      PIC A(10).
           05 INV-PROD-ID   PIC 9(4).
           05 INV-QTY       PIC 9(4).
           05 INV-TOTAL     PIC 9(7)V99.

       WORKING-STORAGE SECTION.
       01 WS-OPTION        PIC 9 VALUE 0.
       01 WS-PROD-ID       PIC 9(4).
       01 WS-PROD-NAME     PIC A(30).
       01 WS-PROD-PRICE    PIC 9(5)V99.
       01 WS-PROD-QTY      PIC 9(4).
       01 WS-INV-ID        PIC 9(4).
       01 WS-INV-QTY       PIC 9(4).
       01 WS-TOTAL         PIC 9(7)V99.
       01 WS-FLAG          PIC X VALUE 'N'.
       01 WS-EOF-PROD      PIC X VALUE 'N'.
       01 WS-EOF-INV       PIC X VALUE 'N'.
       01 WS-PRICE-DISP    PIC ZZZZZ.99.
       01 WS-TOTAL-DISP    PIC ZZZZZZZ.99.

       PROCEDURE DIVISION.
       MAIN-PROGRAM.
           PERFORM SHOW-MENU UNTIL WS-OPTION = 5
           STOP RUN.

       SHOW-MENU.
           DISPLAY "=============================="
           DISPLAY " Sistema de Faturacao - Menu"
           DISPLAY "1. Listar produtos"
           DISPLAY "2. Criar fatura"
           DISPLAY "3. Listar faturas"
           DISPLAY "4. Adicionar produto"
           DISPLAY "5. Sair"
           DISPLAY "Escolha uma opcao (1-5): "
           ACCEPT WS-OPTION
           EVALUATE WS-OPTION
               WHEN 1
                   PERFORM LIST-PRODUCTS
               WHEN 2
                   PERFORM CREATE-INVOICE
               WHEN 3
                   PERFORM LIST-INVOICES
               WHEN 4
                   PERFORM ADD-PRODUCT
               WHEN 5
                   DISPLAY "Saindo do sistema..."
               WHEN OTHER
                   DISPLAY "Opcao invalida."
           END-EVALUATE.

       LIST-PRODUCTS.
           OPEN INPUT PRODUCTS-FILE
           MOVE 'N' TO WS-EOF-PROD
           PERFORM UNTIL WS-EOF-PROD = 'Y'
               READ PRODUCTS-FILE
                   AT END MOVE 'Y' TO WS-EOF-PROD
                   NOT AT END
                       MOVE PROD-PRICE TO WS-PRICE-DISP
                       DISPLAY "ID: " PROD-ID
                               " Nome: " PROD-NAME
                               " Preco: " WS-PRICE-DISP
                               " Qtd: " PROD-QTY
               END-READ
           END-PERFORM
           CLOSE PRODUCTS-FILE
           .

       ADD-PRODUCT.
           DISPLAY "Digite ID do produto: "
           ACCEPT WS-PROD-ID
           DISPLAY "Digite nome do produto: "
           ACCEPT WS-PROD-NAME
           DISPLAY "Digite preco unitario: "
           ACCEPT WS-PROD-PRICE
           DISPLAY "Digite quantidade em stock: "
           ACCEPT WS-PROD-QTY
           OPEN EXTEND PRODUCTS-FILE
           MOVE WS-PROD-ID TO PROD-ID
           MOVE WS-PROD-NAME TO PROD-NAME
           MOVE WS-PROD-PRICE TO PROD-PRICE
           MOVE WS-PROD-QTY TO PROD-QTY
           WRITE PRODUCT-RECORD
           CLOSE PRODUCTS-FILE
           DISPLAY "Produto adicionado com sucesso!"
           .

       CREATE-INVOICE.
           DISPLAY "Digite ID da fatura: "
           ACCEPT WS-INV-ID
           DISPLAY "Digite ID do produto: "
           ACCEPT WS-PROD-ID
           DISPLAY "Digite quantidade: "
           ACCEPT WS-INV-QTY

           OPEN INPUT PRODUCTS-FILE
           MOVE 'N' TO WS-FLAG
           MOVE 'N' TO WS-EOF-PROD
           PERFORM UNTIL WS-EOF-PROD = 'Y' OR WS-FLAG = 'Y'
               READ PRODUCTS-FILE
                   AT END MOVE 'Y' TO WS-EOF-PROD
                   NOT AT END
                       IF PROD-ID = WS-PROD-ID
                           MOVE 'Y' TO WS-FLAG
                           IF WS-INV-QTY > PROD-QTY
                               DISPLAY "Quantidade insuficiente no stock."
                               CLOSE PRODUCTS-FILE
                               GO TO SHOW-MENU
                           END-IF
                           COMPUTE WS-TOTAL = WS-INV-QTY * PROD-PRICE
                       END-IF
               END-READ
           END-PERFORM
           CLOSE PRODUCTS-FILE

           OPEN EXTEND INVOICES-FILE
               MOVE WS-INV-ID TO INV-ID
               MOVE FUNCTION CURRENT-DATE(1:10) TO INV-DATE
               MOVE WS-PROD-ID TO INV-PROD-ID
               MOVE WS-INV-QTY TO INV-QTY
               MOVE WS-TOTAL TO INV-TOTAL
               WRITE INVOICE-RECORD
           CLOSE INVOICES-FILE
           MOVE WS-TOTAL TO WS-TOTAL-DISP
           DISPLAY "Fatura criada com sucesso! Total: " WS-TOTAL-DISP
           .

       LIST-INVOICES.
           OPEN INPUT INVOICES-FILE
           MOVE 'N' TO WS-EOF-INV
           PERFORM UNTIL WS-EOF-INV = 'Y'
               READ INVOICES-FILE
                   AT END MOVE 'Y' TO WS-EOF-INV
                   NOT AT END
                       MOVE INV-TOTAL TO WS-TOTAL-DISP
                       DISPLAY "Fatura ID: " INV-ID
                               " Produto ID: " INV-PROD-ID
                               " Quantidade: " INV-QTY
                               " Total: " WS-TOTAL-DISP
               END-READ
           END-PERFORM
           CLOSE INVOICES-FILE
           .
