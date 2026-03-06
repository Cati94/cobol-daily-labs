 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANK-ACCOUNT.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-SALDO            PIC 9(6)V99 VALUE 1000.00.
       01 WS-VALOR            PIC 9(6)V99 VALUE 0.
       01 WS-OPCAO            PIC 9 VALUE 0.

       PROCEDURE DIVISION.

       MAIN-PROGRAM.

           PERFORM UNTIL WS-OPCAO = 4

               PERFORM MOSTRAR-MENU
               PERFORM LER-OPCAO

               IF WS-OPCAO = 1
                   PERFORM CONSULTAR-SALDO
               END-IF

               IF WS-OPCAO = 2
                   PERFORM DEPOSITAR
               END-IF

               IF WS-OPCAO = 3
                   PERFORM LEVANTAR
               END-IF

           END-PERFORM

           DISPLAY "Obrigado por usar o sistema bancario."

           STOP RUN.

       MOSTRAR-MENU.

           DISPLAY "-----------------------------"
           DISPLAY "   SISTEMA BANCARIO COBOL   "
           DISPLAY "-----------------------------"
           DISPLAY "1 - Consultar saldo"
           DISPLAY "2 - Depositar"
           DISPLAY "3 - Levantar"
           DISPLAY "4 - Sair"
           DISPLAY "Escolha uma opcao:".

       LER-OPCAO.

           ACCEPT WS-OPCAO.

       CONSULTAR-SALDO.

           DISPLAY "Saldo atual: " WS-SALDO.

       DEPOSITAR.

           DISPLAY "Valor a depositar:"
           ACCEPT WS-VALOR

           ADD WS-VALOR TO WS-SALDO

           DISPLAY "Deposito realizado.".

       LEVANTAR.

           DISPLAY "Valor a levantar:"
           ACCEPT WS-VALOR

           IF WS-VALOR > WS-SALDO
               DISPLAY "Saldo insuficiente."
           ELSE
               SUBTRACT WS-VALOR FROM WS-SALDO
               DISPLAY "Levantamento realizado."
           END-IF.
