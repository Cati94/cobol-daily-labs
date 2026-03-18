       IDENTIFICATION DIVISION.
       PROGRAM-ID. FILTER-ACCOUNTS.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT INPUT-FILE ASSIGN TO "accounts_merged.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT POSITIVE-FILE ASSIGN TO "accounts_positive.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT NEGATIVE-FILE ASSIGN TO "accounts_negative.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT ALERT-FILE ASSIGN TO "accounts_alert.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD INPUT-FILE.
       01 INPUT-RECORD.
           05 IN-ID       PIC 9(4).
           05 FILLER      PIC X.
           05 IN-BAL      PIC S9(6).

       FD POSITIVE-FILE.
       01 POS-RECORD.
           05 POS-ID      PIC 9(4).
           05 FILLER      PIC X VALUE SPACE.
           05 POS-BAL     PIC S9(6).

       FD NEGATIVE-FILE.
       01 NEG-RECORD.
           05 NEG-ID      PIC 9(4).
           05 FILLER      PIC X VALUE SPACE.
           05 NEG-BAL     PIC S9(6).

       FD ALERT-FILE.
       01 ALERT-RECORD.
           05 ALERT-ID    PIC 9(4).
           05 FILLER      PIC X VALUE SPACE.
           05 ALERT-BAL   PIC S9(6).

       WORKING-STORAGE SECTION.

       01 EOF-FLAG       PIC X VALUE 'N'.

       PROCEDURE DIVISION.

       MAIN-PROCEDURE.

           OPEN INPUT INPUT-FILE
                OUTPUT POSITIVE-FILE NEGATIVE-FILE ALERT-FILE

           PERFORM READ-INPUT

           PERFORM UNTIL EOF-FLAG = 'Y'

               IF IN-BAL > 0
                   MOVE IN-ID TO POS-ID
                   MOVE IN-BAL TO POS-BAL
                   WRITE POS-RECORD

               ELSE
                   IF IN-BAL < 0
                       MOVE IN-ID TO NEG-ID
                       MOVE IN-BAL TO NEG-BAL
                       WRITE NEG-RECORD
                   END-IF
               END-IF

               IF IN-BAL < -100
                   MOVE IN-ID TO ALERT-ID
                   MOVE IN-BAL TO ALERT-BAL
                   WRITE ALERT-RECORD
               END-IF

               PERFORM READ-INPUT

           END-PERFORM

           CLOSE INPUT-FILE POSITIVE-FILE NEGATIVE-FILE ALERT-FILE

           DISPLAY "FILTER COMPLETED"

           STOP RUN.

       READ-INPUT.
           READ INPUT-FILE
               AT END MOVE 'Y' TO EOF-FLAG
           END-READ.
