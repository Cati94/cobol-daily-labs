        IDENTIFICATION DIVISION.
       PROGRAM-ID. INVENTORY.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-OPCAO       PIC 9 VALUE 0.
       01 WS-ID          PIC 9 VALUE 0.
       01 WS-QTD         PIC 9(4) VALUE 0.

       01 WS-PRODUTOS.
           05 WS-PRODUTO OCCURS 5 TIMES.
               10 WS-NOME  PIC X(20).
               10 WS-STOCK PIC 9(4).

       PROCEDURE DIVISION.

       MAIN-PROGRAM.
           PERFORM INICIALIZAR

           PERFORM UNTIL WS-OPCAO = 6
               PERFORM MENU-PARAGRAPH
               ACCEPT WS-OPCAO
               EVALUATE WS-OPCAO
                   WHEN 1
                       PERFORM LISTAR
                   WHEN 2
                       PERFORM ADICIONAR_STOCK
                   WHEN 3
                       PERFORM REMOVER_STOCK
                   WHEN 4
                       PERFORM CONSULTAR
                   WHEN 5
                       PERFORM NOVO_PRODUTO
                   WHEN OTHER
                       DISPLAY "Opcao invalida."
               END-EVALUATE
           END-PERFORM

           STOP RUN.

       INICIALIZAR.
           MOVE "Laptop"   TO WS-NOME (1)
           MOVE 10         TO WS-STOCK (1)
           MOVE "Mouse"    TO WS-NOME (2)
           MOVE 50         TO WS-STOCK (2)
           MOVE "Teclado"  TO WS-NOME (3)
           MOVE 20         TO WS-STOCK (3)
           MOVE "Monitor"  TO WS-NOME (4)
           MOVE 15         TO WS-STOCK (4)
           MOVE "Cabo USB" TO WS-NOME (5)
           MOVE 100        TO WS-STOCK (5)
           .

       MENU-PARAGRAPH.
           DISPLAY "---------------------"
           DISPLAY " INVENTORY SYSTEM "
           DISPLAY "---------------------"
           DISPLAY "1 - Listar produtos"
           DISPLAY "2 - Adicionar stock"
           DISPLAY "3 - Remover stock"
           DISPLAY "4 - Consultar produto"
           DISPLAY "5 - Novo produto"
           DISPLAY "6 - Sair"
           DISPLAY "Opcao: "
           .

       LISTAR.
           PERFORM VARYING WS-ID FROM 1 BY 1 UNTIL WS-ID > 5
               DISPLAY WS-ID " - " WS-NOME(WS-ID) " Stock: " WS-STOCK(WS-ID)
           END-PERFORM
           .

       ADICIONAR_STOCK.
           DISPLAY "Numero do produto:"
           ACCEPT WS-ID
           DISPLAY "Quantidade a adicionar:"
           ACCEPT WS-QTD
           ADD WS-QTD TO WS-STOCK(WS-ID)
           DISPLAY "Stock atualizado."
           .

       REMOVER_STOCK.
           DISPLAY "Numero do produto:"
           ACCEPT WS-ID
           DISPLAY "Quantidade a remover:"
           ACCEPT WS-QTD
           SUBTRACT WS-QTD FROM WS-STOCK(WS-ID)
           DISPLAY "Stock atualizado."
           .

       CONSULTAR.
           DISPLAY "Numero do produto:"
           ACCEPT WS-ID
           DISPLAY "Produto: " WS-NOME(WS-ID)
           DISPLAY "Stock: " WS-STOCK(WS-ID)
           .

       NOVO_PRODUTO.
           DISPLAY "Posicao do produto (1-5):"
           ACCEPT WS-ID
           DISPLAY "Nome do produto:"
           ACCEPT WS-NOME(WS-ID)
           DISPLAY "Stock inicial:"
           ACCEPT WS-STOCK(WS-ID)
           DISPLAY "Produto criado."
           .
