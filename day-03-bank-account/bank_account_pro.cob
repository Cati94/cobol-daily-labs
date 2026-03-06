 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANK-SYSTEM.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-OPCAO              PIC 9 VALUE 0.
       01 WS-CLIENTE-ID         PIC 9 VALUE 0.
       01 WS-VALOR              PIC 9(6)V99 VALUE 0.

       01 WS-TOTAL-DEPOSITOS        PIC 9(7)V99 VALUE 0.
       01 WS-TOTAL-LEVANTAMENTOS    PIC 9(7)V99 VALUE 0.

       01 WS-CLIENTES.
          05 WS-CLIENTE OCCURS 5 TIMES.
             10 WS-NOME     PIC X(30).
             10 WS-SALDO    PIC 9(6)V99.

       PROCEDURE DIVISION.

       MAIN-PROGRAM.

           PERFORM INICIALIZAR-DADOS

           PERFORM UNTIL WS-OPCAO = 5

               PERFORM MOSTRAR-MENU
               PERFORM LER-OPCAO

               IF WS-OPCAO = 1
                   PERFORM LISTAR-CLIENTES
               END-IF

               IF WS-OPCAO = 2
                   PERFORM DEPOSITAR
               END-IF

               IF WS-OPCAO = 3
                   PERFORM LEVANTAR
               END-IF

               IF WS-OPCAO = 4
                   PERFORM CONSULTAR-SALDO
               END-IF

           END-PERFORM

           PERFORM RELATORIO-FINAL

           STOP RUN.

       INICIALIZAR-DADOS.

           MOVE "Ana" TO WS-NOME (1)
           MOVE 1000 TO WS-SALDO (1)

           MOVE "Joao" TO WS-NOME (2)
           MOVE 1500 TO WS-SALDO (2)

           MOVE "Maria" TO WS-NOME (3)
           MOVE 800 TO WS-SALDO (3)

           MOVE "Carlos" TO WS-NOME (4)
           MOVE 1200 TO WS-SALDO (4)

           MOVE "Sofia" TO WS-NOME (5)
           MOVE 500 TO WS-SALDO (5).

       MOSTRAR-MENU.

           DISPLAY "---------------------------"
           DISPLAY " SISTEMA BANCARIO COBOL "
           DISPLAY "---------------------------"
           DISPLAY "1 - Listar clientes"
           DISPLAY "2 - Depositar"
           DISPLAY "3 - Levantar"
           DISPLAY "4 - Consultar saldo"
           DISPLAY "5 - Sair"
           DISPLAY "Escolha uma opcao:".

       LER-OPCAO.
           ACCEPT WS-OPCAO.

       LISTAR-CLIENTES.

           DISPLAY "Clientes disponíveis:"

           PERFORM VARYING WS-CLIENTE-ID FROM 1 BY 1
               UNTIL WS-CLIENTE-ID > 5

               DISPLAY WS-CLIENTE-ID " - "
                       WS-NOME (WS-CLIENTE-ID)

           END-PERFORM.

       CONSULTAR-SALDO.

           DISPLAY "Numero do cliente:"
           ACCEPT WS-CLIENTE-ID

           IF WS-CLIENTE-ID >= 1 AND WS-CLIENTE-ID <= 5
               DISPLAY "Cliente: "
                       WS-NOME (WS-CLIENTE-ID)
               DISPLAY "Saldo: "
                       WS-SALDO (WS-CLIENTE-ID)
           ELSE
               DISPLAY "Cliente invalido."
           END-IF.

       DEPOSITAR.

           DISPLAY "Numero do cliente:"
           ACCEPT WS-CLIENTE-ID

           DISPLAY "Valor a depositar:"
           ACCEPT WS-VALOR

           IF WS-VALOR > 0

               ADD WS-VALOR
               TO WS-SALDO (WS-CLIENTE-ID)

               ADD WS-VALOR
               TO WS-TOTAL-DEPOSITOS

               DISPLAY "Deposito realizado."

           ELSE
               DISPLAY "Valor invalido."
           END-IF.

       LEVANTAR.

           DISPLAY "Numero do cliente:"
           ACCEPT WS-CLIENTE-ID

           DISPLAY "Valor a levantar:"
           ACCEPT WS-VALOR

           IF WS-VALOR > WS-SALDO (WS-CLIENTE-ID)
               DISPLAY "Saldo insuficiente."

           ELSE

               SUBTRACT WS-VALOR
               FROM WS-SALDO (WS-CLIENTE-ID)

               ADD WS-VALOR
               TO WS-TOTAL-LEVANTAMENTOS

               DISPLAY "Levantamento realizado."

           END-IF.

       RELATORIO-FINAL.

           DISPLAY "---------------------------"
           DISPLAY " RELATORIO FINAL"
           DISPLAY "---------------------------"
           DISPLAY "Total depositado: "
                   WS-TOTAL-DEPOSITOS
           DISPLAY "Total levantado: "
                   WS-TOTAL-LEVANTAMENTOS
           DISPLAY "Programa terminado.".
