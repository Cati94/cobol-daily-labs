             IDENTIFICATION DIVISION.
       PROGRAM-ID. BANK-SYSTEM-D21.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ACCOUNTS-FILE ASSIGN TO "accounts.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT TRANSACTIONS-FILE ASSIGN TO "transactions.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD ACCOUNTS-FILE.
       01 ACCOUNT-RECORD.
           05 ACC-ID        PIC 9(4).
           05 ACC-NAME      PIC A(30).
           05 ACC-BALANCE   PIC 9(7)V99.

       FD TRANSACTIONS-FILE.
       01 TRANSACTION-RECORD.
           05 TRANS-ID      PIC 9(5).
           05 TRANS-ACCID   PIC 9(4).
           05 TRANS-TYPE    PIC X.
           05 TRANS-AMOUNT  PIC 9(7)V99.
           05 TRANS-DATE    PIC 9(8).

       WORKING-STORAGE SECTION.
       01 WS-OPTION       PIC 9 VALUE 0.
       01 WS-LAST-ACCID   PIC 9(4) VALUE 1000.
       01 WS-LAST-TRANSID PIC 9(5) VALUE 0.
       01 EOF-FLAG        PIC X VALUE "N".
       01 WS-NAME         PIC A(30).
       01 WS-AMOUNT       PIC 9(7)V99.
       01 WS-TYPE         PIC X.
       01 WS-ACCID        PIC 9(4).
       01 WS-BALANCE      PIC 9(7)V99.
       01 WS-DATE         PIC 9(8) VALUE 20260322.
       01 TOTAL-SALDO     PIC 9(10)V99 VALUE 0.
       01 COUNT-ACCOUNTS  PIC 9(5) VALUE 0.
       01 WS-MEDIO        PIC 9(7)V99.

       PROCEDURE DIVISION.

MAIN-PROGRAM.
       PERFORM UNTIL WS-OPTION = 6
           PERFORM DISPLAY-MENU
       END-PERFORM
       DISPLAY "Saindo..."
       STOP RUN.

DISPLAY-MENU.
       DISPLAY "=============================="
       DISPLAY "1. Criar Conta"
       DISPLAY "2. Listar Contas"
       DISPLAY "3. Depositar / Levantar"
       DISPLAY "4. Histórico de Transações"
       DISPLAY "5. Estatísticas do Banco"
       DISPLAY "6. Sair"
       DISPLAY "Escolha uma opcao (1-6): "
       ACCEPT WS-OPTION
       EVALUATE WS-OPTION
           WHEN 1 PERFORM CREATE-ACCOUNT
           WHEN 2 PERFORM LIST-ACCOUNTS
           WHEN 3 PERFORM TRANSACTIONS-PAR
           WHEN 4 PERFORM SHOW-HISTORY
           WHEN 5 PERFORM BANK-STATS-PAR
           WHEN 6 CONTINUE
           WHEN OTHER DISPLAY "Opcao invalida"
       END-EVALUATE.


CREATE-ACCOUNT.
       PERFORM GET-LAST-ACCID
       ADD 1 TO WS-LAST-ACCID
       DISPLAY "Digite o nome da conta (max 30 chars): "
       ACCEPT WS-NAME
       DISPLAY "Digite o saldo inicial: "
       ACCEPT WS-BALANCE
       OPEN EXTEND ACCOUNTS-FILE
       MOVE WS-LAST-ACCID TO ACC-ID
       MOVE WS-NAME TO ACC-NAME
       MOVE WS-BALANCE TO ACC-BALANCE
       WRITE ACCOUNT-RECORD
       CLOSE ACCOUNTS-FILE
       DISPLAY "Conta criada com sucesso! ID: " WS-LAST-ACCID.

GET-LAST-ACCID.
       OPEN INPUT ACCOUNTS-FILE
       MOVE "N" TO EOF-FLAG
       PERFORM UNTIL EOF-FLAG = "S"
           READ ACCOUNTS-FILE
               AT END MOVE "S" TO EOF-FLAG
               NOT AT END MOVE ACC-ID TO WS-LAST-ACCID
           END-READ
       END-PERFORM
       CLOSE ACCOUNTS-FILE.


LIST-ACCOUNTS.
       OPEN INPUT ACCOUNTS-FILE
       MOVE "N" TO EOF-FLAG
       DISPLAY "Lista de contas:"
       PERFORM UNTIL EOF-FLAG = "S"
           READ ACCOUNTS-FILE
               AT END MOVE "S" TO EOF-FLAG
               NOT AT END
                   DISPLAY "ID: " ACC-ID " | Nome: " ACC-NAME " | Saldo: " ACC-BALANCE
           END-READ
       END-PERFORM
       CLOSE ACCOUNTS-FILE.

TRANSACTIONS-PAR.
       DISPLAY "Digite o ID da conta: "
       ACCEPT WS-ACCID
       OPEN I-O ACCOUNTS-FILE
       MOVE "N" TO EOF-FLAG
       MOVE 0 TO WS-BALANCE
       PERFORM UNTIL EOF-FLAG = "S"
           READ ACCOUNTS-FILE
               AT END MOVE "S" TO EOF-FLAG
               NOT AT END
                   IF ACC-ID = WS-ACCID
                       MOVE ACC-BALANCE TO WS-BALANCE
                       DISPLAY "Digite tipo: C=Credito D=Debito"
                       ACCEPT WS-TYPE
                       DISPLAY "Digite o valor: "
                       ACCEPT WS-AMOUNT
                       IF WS-TYPE = "C"
                           ADD WS-AMOUNT TO WS-BALANCE
                       ELSE
                           SUBTRACT WS-AMOUNT FROM WS-BALANCE
                       END-IF
                       MOVE WS-BALANCE TO ACC-BALANCE
                       REWRITE ACCOUNT-RECORD
                       PERFORM RECORD-TRANSACTION
                       DISPLAY "Operacao realizada."
                       MOVE "S" TO EOF-FLAG
                   END-IF
           END-READ
       END-PERFORM
       CLOSE ACCOUNTS-FILE.


RECORD-TRANSACTION.
       PERFORM GET-LAST-TRANSID
       ADD 1 TO WS-LAST-TRANSID
       MOVE WS-LAST-TRANSID TO TRANS-ID
       MOVE WS-ACCID TO TRANS-ACCID
       MOVE WS-TYPE TO TRANS-TYPE
       MOVE WS-AMOUNT TO TRANS-AMOUNT
       MOVE WS-DATE TO TRANS-DATE
       OPEN EXTEND TRANSACTIONS-FILE
       WRITE TRANSACTION-RECORD
       CLOSE TRANSACTIONS-FILE.

GET-LAST-TRANSID.
       OPEN INPUT TRANSACTIONS-FILE
       MOVE "N" TO EOF-FLAG
       MOVE 0 TO WS-LAST-TRANSID
       PERFORM UNTIL EOF-FLAG = "S"
           READ TRANSACTIONS-FILE
               AT END MOVE "S" TO EOF-FLAG
               NOT AT END MOVE TRANS-ID TO WS-LAST-TRANSID
           END-READ
       END-PERFORM
       CLOSE TRANSACTIONS-FILE.

SHOW-HISTORY.
       DISPLAY "Digite o ID da conta: "
       ACCEPT WS-ACCID
       OPEN INPUT TRANSACTIONS-FILE
       MOVE "N" TO EOF-FLAG
       DISPLAY "Historico de transacoes:"
       PERFORM UNTIL EOF-FLAG = "S"
           READ TRANSACTIONS-FILE
               AT END MOVE "S" TO EOF-FLAG
               NOT AT END
                   IF TRANS-ACCID = WS-ACCID
                       DISPLAY "ID Trans: " TRANS-ID " | Tipo: " TRANS-TYPE " | Valor: " TRANS-AMOUNT " | Data: " TRANS-DATE
                   END-IF
           END-READ
       END-PERFORM
       CLOSE TRANSACTIONS-FILE.


BANK-STATS-PAR.
       OPEN INPUT ACCOUNTS-FILE
       MOVE "N" TO EOF-FLAG
       MOVE 0 TO COUNT-ACCOUNTS
       MOVE 0 TO TOTAL-SALDO
       PERFORM UNTIL EOF-FLAG = "S"
           READ ACCOUNTS-FILE
               AT END MOVE "S" TO EOF-FLAG
               NOT AT END
                   ADD 1 TO COUNT-ACCOUNTS
                   ADD ACC-BALANCE TO TOTAL-SALDO
           END-READ
       END-PERFORM
       CLOSE ACCOUNTS-FILE
       DISPLAY "Total de contas: " COUNT-ACCOUNTS
       DISPLAY "Saldo total do banco: " TOTAL-SALDO
       IF COUNT-ACCOUNTS > 0
           COMPUTE WS-MEDIO = TOTAL-SALDO / COUNT-ACCOUNTS
           DISPLAY "Saldo medio por conta: " WS-MEDIO
       END-IF.
