       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANK-SYSTEM-D25.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ACCOUNTS-FILE ASSIGN TO "accounts.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT TRANS-FILE ASSIGN TO "transactions.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD ACCOUNTS-FILE.
       01 ACC-REC.
           05 ACC-ID    PIC 9(4).
           05 ACC-NAME  PIC A(30).
           05 ACC-SALDO PIC 9(7)V99.

       FD TRANS-FILE.
       01 TRANS-REC.
           05 TRANS-ID     PIC 9(5).
           05 TRANS-ACCID  PIC 9(4).
           05 TRANS-TYPE   PIC X.
           05 TRANS-AMOUNT PIC 9(7)V99.
           05 TRANS-DATE   PIC 9(8).

       WORKING-STORAGE SECTION.
       01 WS-OPTION       PIC 9 VALUE 0.
       01 EOF-FLAG        PIC X VALUE "N".
       01 WS-NAME-SEARCH  PIC A(30) VALUE SPACES.
       01 WS-DATE-START   PIC 9(8).
       01 WS-DATE-END     PIC 9(8).

       PROCEDURE DIVISION.

MAIN.
       MOVE 0 TO WS-OPTION.

MENU-LOOP.
       DISPLAY "===== PESQUISA ====="
       DISPLAY "1. Procurar conta por nome"
       DISPLAY "2. Filtrar transacoes por data"
       DISPLAY "3. Sair"
       ACCEPT WS-OPTION

       EVALUATE WS-OPTION
           WHEN 1 PERFORM SEARCH-ACCOUNT
           WHEN 2 PERFORM FILTER-TRANS
           WHEN 3 GO TO END-PROG
           WHEN OTHER DISPLAY "Opcao invalida"
       END-EVALUATE

       GO TO MENU-LOOP.

END-PROG.
       STOP RUN.


SEARCH-ACCOUNT.
       MOVE SPACES TO WS-NAME-SEARCH
       DISPLAY "Digite nome (exato):"
       ACCEPT WS-NAME-SEARCH

       OPEN INPUT ACCOUNTS-FILE
       MOVE "N" TO EOF-FLAG

       DISPLAY "Resultados:"

       PERFORM UNTIL EOF-FLAG = "S"
           READ ACCOUNTS-FILE
               AT END
                   MOVE "S" TO EOF-FLAG
               NOT AT END
                   IF ACC-NAME = WS-NAME-SEARCH
                       DISPLAY ACC-ID " " ACC-NAME " " ACC-SALDO
                   END-IF
           END-READ
       END-PERFORM

       CLOSE ACCOUNTS-FILE.


FILTER-TRANS.
       DISPLAY "Data inicio (YYYYMMDD):"
       ACCEPT WS-DATE-START

       DISPLAY "Data fim (YYYYMMDD):"
       ACCEPT WS-DATE-END

       OPEN INPUT TRANS-FILE
       MOVE "N" TO EOF-FLAG

       DISPLAY "Transacoes encontradas:"

       PERFORM UNTIL EOF-FLAG = "S"
           READ TRANS-FILE
               AT END
                   MOVE "S" TO EOF-FLAG
               NOT AT END
                   IF TRANS-DATE >= WS-DATE-START
                      AND TRANS-DATE <= WS-DATE-END
                       DISPLAY TRANS-ID " "
                               TRANS-ACCID " "
                               TRANS-TYPE " "
                               TRANS-AMOUNT " "
                               TRANS-DATE
                   END-IF
           END-READ
       END-PERFORM

       CLOSE TRANS-FILE.
