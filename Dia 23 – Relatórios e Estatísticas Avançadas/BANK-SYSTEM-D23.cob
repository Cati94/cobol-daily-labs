        IDENTIFICATION DIVISION.
       PROGRAM-ID. BANK-SYSTEM-D23.

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
       01 EOF-FLAG          PIC X VALUE "N".
       01 TOTAL-SALDO       PIC 9(12)V99 VALUE 0.
       01 COUNT-ACCOUNTS    PIC 9(5) VALUE 0.
       01 MAX-SALDO         PIC 9(7)V99 VALUE 0.
       01 MIN-SALDO         PIC 9(7)V99 VALUE 9999999.99.
       01 TOTAL-CREDITO     PIC 9(12)V99 VALUE 0.
       01 TOTAL-DEBITO      PIC 9(12)V99 VALUE 0.
       01 COUNT-CREDITO     PIC 9(5) VALUE 0.
       01 COUNT-DEBITO      PIC 9(5) VALUE 0.

       PROCEDURE DIVISION.

MAIN-PROGRAM.
       PERFORM ACCOUNT-STATS
       PERFORM TRANSACTION-STATS
       STOP RUN.

ACCOUNT-STATS.
       OPEN INPUT ACCOUNTS-FILE
       MOVE "N" TO EOF-FLAG
       PERFORM UNTIL EOF-FLAG = "S"
           READ ACCOUNTS-FILE
               AT END
                   MOVE "S" TO EOF-FLAG
               NOT AT END
                   ADD 1 TO COUNT-ACCOUNTS
                   ADD ACC-BALANCE TO TOTAL-SALDO

                   IF COUNT-ACCOUNTS = 1
                       MOVE ACC-BALANCE TO MAX-SALDO
                       MOVE ACC-BALANCE TO MIN-SALDO
                   ELSE
                       IF ACC-BALANCE > MAX-SALDO
                           MOVE ACC-BALANCE TO MAX-SALDO
                       END-IF
                       IF ACC-BALANCE < MIN-SALDO
                           MOVE ACC-BALANCE TO MIN-SALDO
                       END-IF
                   END-IF
           END-READ
       END-PERFORM
       CLOSE ACCOUNTS-FILE

       DISPLAY "===== ESTATISTICAS CONTAS ====="
       DISPLAY "Total de contas: " COUNT-ACCOUNTS
       DISPLAY "Saldo total: " TOTAL-SALDO
       DISPLAY "Maior saldo: " MAX-SALDO
       DISPLAY "Menor saldo: " MIN-SALDO.

TRANSACTION-STATS.
       OPEN INPUT TRANSACTIONS-FILE
       MOVE "N" TO EOF-FLAG
       PERFORM UNTIL EOF-FLAG = "S"
           READ TRANSACTIONS-FILE
               AT END
                   MOVE "S" TO EOF-FLAG
               NOT AT END

                   EVALUATE FUNCTION UPPER-CASE(TRANS-TYPE)
                       WHEN "C"
                           ADD TRANS-AMOUNT TO TOTAL-CREDITO
                           ADD 1 TO COUNT-CREDITO
                       WHEN "D"
                           ADD TRANS-AMOUNT TO TOTAL-DEBITO
                           ADD 1 TO COUNT-DEBITO
                       WHEN OTHER
                           CONTINUE
                   END-EVALUATE
           END-READ
       END-PERFORM
       CLOSE TRANSACTIONS-FILE

       DISPLAY "===== ESTATISTICAS TRANSACOES ====="
       DISPLAY "Total Creditos: " TOTAL-CREDITO
       DISPLAY "Total Debitos: " TOTAL-DEBITO
       DISPLAY "Numero de Creditos: " COUNT-CREDITO
       DISPLAY "Numero de Debitos: " COUNT-DEBITO.
