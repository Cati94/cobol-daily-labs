       IDENTIFICATION DIVISION.
       PROGRAM-ID. MERGE-ACCOUNTS.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT OLD-FILE ASSIGN TO "accounts_old.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-OLD-STATUS.

           SELECT UPDATE-FILE ASSIGN TO "accounts_update.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-UPDATE-STATUS.

           SELECT MERGED-FILE ASSIGN TO "accounts_merged.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-MERGED-STATUS.

       DATA DIVISION.
       FILE SECTION.

       FD OLD-FILE.
       01 OLD-RECORD.
           05 OLD-ID      PIC 9(4).
           05 FILLER      PIC X.
           05 OLD-BAL     PIC 9(6).

       FD UPDATE-FILE.
       01 UPDATE-RECORD.
           05 UPD-ID      PIC 9(4).
           05 FILLER      PIC X.
           05 UPD-BAL     PIC 9(6).

       FD MERGED-FILE.
       01 MERGED-RECORD.
           05 MERGED-ID   PIC 9(4).
           05 FILLER      PIC X.
           05 MERGED-BAL  PIC 9(6).

       WORKING-STORAGE SECTION.

       01 EOF-OLD        PIC X VALUE 'N'.
       01 EOF-UPDATE     PIC X VALUE 'N'.
       01 WS-OLD-STATUS      PIC XX.
       01 WS-UPDATE-STATUS   PIC XX.
       01 WS-MERGED-STATUS   PIC XX.

       PROCEDURE DIVISION.

       MAIN-PROCEDURE.

           OPEN INPUT OLD-FILE UPDATE-FILE
                OUTPUT MERGED-FILE

           IF WS-OLD-STATUS NOT = "00"
               DISPLAY "ERRO AO ABRIR OLD-FILE: " WS-OLD-STATUS
               STOP RUN
           END-IF

           IF WS-UPDATE-STATUS NOT = "00"
               DISPLAY "ERRO AO ABRIR UPDATE-FILE: " WS-UPDATE-STATUS
               STOP RUN
           END-IF

           IF WS-MERGED-STATUS NOT = "00"
               DISPLAY "ERRO AO CRIAR MERGED-FILE: " WS-MERGED-STATUS
               STOP RUN
           END-IF

           PERFORM READ-OLD
           PERFORM READ-UPDATE

           PERFORM UNTIL EOF-OLD = 'Y' AND EOF-UPDATE = 'Y'

               EVALUATE TRUE

                   WHEN EOF-OLD = 'Y'
                       PERFORM WRITE-UPDATE
                       PERFORM READ-UPDATE

                   WHEN EOF-UPDATE = 'Y'
                       PERFORM WRITE-OLD
                       PERFORM READ-OLD

                   WHEN OLD-ID = UPD-ID
                       MOVE OLD-ID TO MERGED-ID
                       ADD OLD-BAL UPD-BAL GIVING MERGED-BAL
                       WRITE MERGED-RECORD
                       PERFORM READ-OLD
                       PERFORM READ-UPDATE

                   WHEN OLD-ID < UPD-ID
                       PERFORM WRITE-OLD
                       PERFORM READ-OLD

                   WHEN OTHER
                       PERFORM WRITE-UPDATE
                       PERFORM READ-UPDATE

               END-EVALUATE

           END-PERFORM

           CLOSE OLD-FILE UPDATE-FILE MERGED-FILE

           DISPLAY "MERGE COMPLETED"

           STOP RUN.

       READ-OLD.
           READ OLD-FILE
               AT END MOVE 'Y' TO EOF-OLD
           END-READ.

       READ-UPDATE.
           READ UPDATE-FILE
               AT END MOVE 'Y' TO EOF-UPDATE
           END-READ.

       WRITE-OLD.
           MOVE OLD-ID TO MERGED-ID
           MOVE OLD-BAL TO MERGED-BAL
           WRITE MERGED-RECORD.

       WRITE-UPDATE.
           MOVE UPD-ID TO MERGED-ID
           MOVE UPD-BAL TO MERGED-BAL
           WRITE MERGED-RECORD.
