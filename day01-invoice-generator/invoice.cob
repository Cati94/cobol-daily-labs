       IDENTIFICATION DIVISION.
       PROGRAM-ID. INVOICE-GENERATOR.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-CLIENTE        PIC X(30).
       01 WS-PRODUTO        PIC X(30).
       01 WS-QUANTIDADE     PIC 9(4).
       01 WS-PRECO          PIC 9(5)V99.
       01 WS-IVA            PIC 9(2)V99.

       01 WS-SUBTOTAL       PIC 9(7)V99.
       01 WS-VALOR-IVA      PIC 9(7)V99.
       01 WS-TOTAL          PIC 9(7)V99.

       PROCEDURE DIVISION.
       

           DISPLAY "==============================="
           DISPLAY "           FATURA"
           DISPLAY "==============================="

           DISPLAY "Cliente: "
           ACCEPT WS-CLIENTE

           DISPLAY "Produto: "
           ACCEPT WS-PRODUTO

           DISPLAY "Quantidade: "
           ACCEPT WS-QUANTIDADE

           DISPLAY "Preço Unitário: "
           ACCEPT WS-PRECO

           DISPLAY "IVA (%): "
           ACCEPT WS-IVA

         
           MULTIPLY WS-PRECO BY WS-QUANTIDADE GIVING WS-SUBTOTAL
           MULTIPLY WS-SUBTOTAL BY WS-IVA GIVING WS-VALOR-IVA
           DIVIDE 100 INTO WS-VALOR-IVA
           ADD WS-SUBTOTAL TO WS-VALOR-IVA GIVING WS-TOTAL

           
           DISPLAY " ".
           DISPLAY "Subtotal: " WS-SUBTOTAL
           DISPLAY "IVA (" WS-IVA "%): " WS-VALOR-IVA
           DISPLAY "-------------------------------"
           DISPLAY "TOTAL: " WS-TOTAL
           DISPLAY "==============================="

           STOP RUN.
