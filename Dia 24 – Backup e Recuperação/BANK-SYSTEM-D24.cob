       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANK-SYSTEM-D24.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ACCOUNTS-FILE ASSIGN TO "accounts.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT ACCOUNTS-BACKUP ASSIGN TO "accounts.bak"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT TRANS-FILE ASSIGN TO "transactions.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT TRANS-BACKUP ASSIGN TO "transactions.bak"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD ACCOUNTS-FILE.
       01 ACC-REC.
           05 ACC-ID    PIC 9(4).
           05 ACC-NAME  PIC A(30).
           05 ACC-SALDO PIC 9(7)V99.

       FD ACCOUNTS-BACKUP.
       01 ACC-BKP-REC PIC X(41).

       FD TRANS-FILE.
       01 TRANS-REC PIC X(30).

       FD TRANS-BACKUP.
       01 TRANS-BKP-REC PIC X(30).

       WORKING-STORAGE SECTION.
       01 WS-OPTION PIC 9 VALUE 0.
       01 EOF-FLAG  PIC X VALUE "N".

       PROCEDURE DIVISION.

MAIN.
       MOVE 0 TO WS-OPTION.

MENU-LOOP.
       DISPLAY "===== BACKUP SYSTEM =====".
       DISPLAY "1. Backup Contas".
       DISPLAY "2. Backup Transacoes".
       DISPLAY "3. Restaurar Contas".
       DISPLAY "4. Restaurar Transacoes".
       DISPLAY "5. Sair".
       ACCEPT WS-OPTION.

       EVALUATE WS-OPTION
           WHEN 1 PERFORM BACKUP-ACCOUNTS
           WHEN 2 PERFORM BACKUP-TRANS
           WHEN 3 PERFORM RESTORE-ACCOUNTS
           WHEN 4 PERFORM RESTORE-TRANS
           WHEN 5 GO TO END-PROG
           WHEN OTHER DISPLAY "Opcao invalida"
       END-EVALUATE.

       GO TO MENU-LOOP.

END-PROG.
       STOP RUN.


BACKUP-ACCOUNTS.
       OPEN INPUT ACCOUNTS-FILE.
       OPEN OUTPUT ACCOUNTS-BACKUP.
       MOVE "N" TO EOF-FLAG.

       PERFORM UNTIL EOF-FLAG = "S"
           READ ACCOUNTS-FILE
               AT END MOVE "S" TO EOF-FLAG
               NOT AT END
                   MOVE ACC-REC TO ACC-BKP-REC
                   WRITE ACC-BKP-REC
           END-READ
       END-PERFORM.

       CLOSE ACCOUNTS-FILE.
       CLOSE ACCOUNTS-BACKUP.

       DISPLAY "Backup de contas concluido.".
       EXIT.


BACKUP-TRANS.
       OPEN INPUT TRANS-FILE.
       OPEN OUTPUT TRANS-BACKUP.
       MOVE "N" TO EOF-FLAG.

       PERFORM UNTIL EOF-FLAG = "S"
           READ TRANS-FILE
               AT END MOVE "S" TO EOF-FLAG
               NOT AT END
                   MOVE TRANS-REC TO TRANS-BKP-REC
                   WRITE TRANS-BKP-REC
           END-READ
       END-PERFORM.

       CLOSE TRANS-FILE.
       CLOSE TRANS-BACKUP.

       DISPLAY "Backup de transacoes concluido.".
       EXIT.


RESTORE-ACCOUNTS.
       OPEN INPUT ACCOUNTS-BACKUP.
       OPEN OUTPUT ACCOUNTS-FILE.
       MOVE "N" TO EOF-FLAG.

       PERFORM UNTIL EOF-FLAG = "S"
           READ ACCOUNTS-BACKUP
               AT END MOVE "S" TO EOF-FLAG
               NOT AT END
                   MOVE ACC-BKP-REC TO ACC-REC
                   WRITE ACC-REC
           END-READ
       END-PERFORM.

       CLOSE ACCOUNTS-BACKUP.
       CLOSE ACCOUNTS-FILE.

       DISPLAY "Restauro de contas concluido.".
       EXIT.


RESTORE-TRANS.
       OPEN INPUT TRANS-BACKUP.
       OPEN OUTPUT TRANS-FILE.
       MOVE "N" TO EOF-FLAG.

       PERFORM UNTIL EOF-FLAG = "S"
           READ TRANS-BACKUP
               AT END MOVE "S" TO EOF-FLAG
               NOT AT END
                   MOVE TRANS-BKP-REC TO TRANS-REC
                   WRITE TRANS-REC
           END-READ
       END-PERFORM.

       CLOSE TRANS-BACKUP.
       CLOSE TRANS-FILE.

       DISPLAY "Restauro de transacoes concluido.".
       EXIT.
