              IDENTIFICATION DIVISION.
       PROGRAM-ID. BANK-SYSTEM-D26.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ACCOUNTS-FILE ASSIGN TO "accounts.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL.

           SELECT TRANS-FILE ASSIGN TO "transactions.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL.

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
       01 WS-OPTION     PIC 9 VALUE 0.
       01 WS-FROM       PIC 9(4).
       01 WS-TO         PIC 9(4).
       01 WS-AMOUNT     PIC 9(7)V99.
       01 EOF-FLAG      PIC X VALUE "N".
       01 FOUND-FROM    PIC X VALUE "N".
       01 FOUND-TO      PIC X VALUE "N".
       01 VALID-TRANS   PIC X VALUE "Y".
       01 WS-LAST-TRANS PIC 9(5) VALUE 0.
       01 WS-DATE       PIC 9(8).

       PROCEDURE DIVISION.

MAIN.
       PERFORM MENU-LOOP
       STOP RUN.

MENU-LOOP.
       DISPLAY "===== TRANSFERENCIAS ====="
       DISPLAY "1. Transferir dinheiro"
       DISPLAY "2. Sair"
       ACCEPT WS-OPTION

       EVALUATE WS-OPTION
           WHEN 1 PERFORM TRANSFER
           WHEN 2 EXIT PARAGRAPH
           WHEN OTHER DISPLAY "Opcao invalida"
       END-EVALUATE

       GO TO MENU-LOOP.

TRANSFER.
       MOVE "N" TO FOUND-FROM
       MOVE "N" TO FOUND-TO
       MOVE "Y" TO VALID-TRANS

       DISPLAY "Conta origem:"
       ACCEPT WS-FROM

       DISPLAY "Conta destino:"
       ACCEPT WS-TO

       DISPLAY "Valor:"
       ACCEPT WS-AMOUNT

       OPEN I-O ACCOUNTS-FILE

       PERFORM UNTIL EOF-FLAG = "S"
           READ ACCOUNTS-FILE
               AT END MOVE "S" TO EOF-FLAG
               NOT AT END
                   IF ACC-ID = WS-FROM
                       MOVE "S" TO FOUND-FROM
                       IF ACC-SALDO < WS-AMOUNT
                           DISPLAY "Saldo insuficiente!"
                           MOVE "N" TO VALID-TRANS
                       ELSE
                           SUBTRACT WS-AMOUNT FROM ACC-SALDO
                           REWRITE ACC-REC
                       END-IF
                   END-IF

                   IF ACC-ID = WS-TO
                       MOVE "S" TO FOUND-TO
                       ADD WS-AMOUNT TO ACC-SALDO
                       REWRITE ACC-REC
                   END-IF
           END-READ
       END-PERFORM

       CLOSE ACCOUNTS-FILE

       IF FOUND-FROM = "N" OR FOUND-TO = "N"
           DISPLAY "Conta nao encontrada!"
           MOVE "N" TO VALID-TRANS
       END-IF

       IF VALID-TRANS = "Y"
           PERFORM SAVE-TRANSFERS
           DISPLAY "Transferencia realizada!"
       ELSE
           DISPLAY "Transferencia cancelada."
       END-IF.

SAVE-TRANSFERS.
       PERFORM GET-LAST-TRANS
       PERFORM GET-DATE

       OPEN EXTEND TRANS-FILE

       ADD 1 TO WS-LAST-TRANS
       MOVE WS-LAST-TRANS TO TRANS-ID
       MOVE WS-FROM TO TRANS-ACCID
       MOVE "D" TO TRANS-TYPE
       MOVE WS-AMOUNT TO TRANS-AMOUNT
       MOVE WS-DATE TO TRANS-DATE
       WRITE TRANS-REC

       ADD 1 TO WS-LAST-TRANS
       MOVE WS-LAST-TRANS TO TRANS-ID
       MOVE WS-TO TO TRANS-ACCID
       MOVE "C" TO TRANS-TYPE
       MOVE WS-AMOUNT TO TRANS-AMOUNT
       MOVE WS-DATE TO TRANS-DATE
       WRITE TRANS-REC

       CLOSE TRANS-FILE.

GET-LAST-TRANS.
       MOVE 0 TO WS-LAST-TRANS
       OPEN INPUT TRANS-FILE
       MOVE "N" TO EOF-FLAG

       PERFORM UNTIL EOF-FLAG = "S"
           READ TRANS-FILE
               AT END MOVE "S" TO EOF-FLAG
               NOT AT END MOVE TRANS-ID TO WS-LAST-TRANS
           END-READ
       END-PERFORM

       CLOSE TRANS-FILE.

GET-DATE.
       ACCEPT WS-DATE FROM DATE YYYYMMDD.
