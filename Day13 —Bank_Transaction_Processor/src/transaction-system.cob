       IDENTIFICATION DIVISION.
       PROGRAM-ID. TRANSACTION-SYSTEM.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TRANS-FILE ASSIGN TO "transactions.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.

       FILE SECTION.
       FD TRANS-FILE.
       01 TRANS-LINE              PIC X(30).

       WORKING-STORAGE SECTION.

       01 WS-EOF                  PIC X VALUE "N".

       01 WS-PARSED.
          05 TR-ACCOUNT           PIC 9(4).
          05 TR-TYPE              PIC X.
          05 TR-AMOUNT            PIC 9(5).

       01 WS-ACCOUNTS.
          05 WS-ACCOUNT OCCURS 20 TIMES.
             10 WS-ID             PIC 9(4) VALUE 0.
             10 WS-BALANCE        PIC S9(7) VALUE 0.

       01 I                       PIC 99 VALUE 1.
       01 FOUND                   PIC X VALUE "N".

       PROCEDURE DIVISION.

       MAIN-PROCESS.

           DISPLAY "STARTING TRANSACTION PROCESSING".

           OPEN INPUT TRANS-FILE

           PERFORM UNTIL WS-EOF = "Y"

               READ TRANS-FILE
                   AT END
                       MOVE "Y" TO WS-EOF
                   NOT AT END
                       PERFORM PARSE-LINE
                       PERFORM PROCESS-TRANSACTION
               END-READ

           END-PERFORM

           CLOSE TRANS-FILE

           PERFORM SHOW-REPORT

           DISPLAY "TRANSACTION REPORT GENERATED"

           STOP RUN.

       PARSE-LINE.

           UNSTRING TRANS-LINE
               DELIMITED BY SPACE
               INTO TR-ACCOUNT
                    TR-TYPE
                    TR-AMOUNT
           END-UNSTRING.

       PROCESS-TRANSACTION.

           MOVE "N" TO FOUND
           MOVE 1 TO I

           PERFORM UNTIL I > 20 OR FOUND = "Y"

               IF WS-ID(I) = TR-ACCOUNT
                   MOVE "Y" TO FOUND
               ELSE
                   ADD 1 TO I
               END-IF

           END-PERFORM

           IF FOUND = "N"
               PERFORM ADD-ACCOUNT
           END-IF

           PERFORM UPDATE-BALANCE.

       ADD-ACCOUNT.

           MOVE 1 TO I

           PERFORM UNTIL I > 20

               IF WS-ID(I) = 0
                   MOVE TR-ACCOUNT TO WS-ID(I)
                   MOVE 0 TO WS-BALANCE(I)
                   EXIT PERFORM
               END-IF

               ADD 1 TO I

           END-PERFORM.

       UPDATE-BALANCE.

           MOVE 1 TO I

           PERFORM UNTIL I > 20

               IF WS-ID(I) = TR-ACCOUNT

                   IF TR-TYPE = "D"
                       ADD TR-AMOUNT TO WS-BALANCE(I)
                       DISPLAY "ACCOUNT " TR-ACCOUNT
                               " DEPOSIT " TR-AMOUNT
                   END-IF

                   IF TR-TYPE = "W"
                       SUBTRACT TR-AMOUNT FROM WS-BALANCE(I)
                       DISPLAY "ACCOUNT " TR-ACCOUNT
                               " WITHDRAW " TR-AMOUNT
                   END-IF

                   EXIT PERFORM
               END-IF

               ADD 1 TO I

           END-PERFORM.

       SHOW-REPORT.

           DISPLAY " "
           DISPLAY "FINAL BALANCES"
           DISPLAY "-------------------------"

           MOVE 1 TO I

           PERFORM UNTIL I > 20

               IF WS-ID(I) NOT = 0
                   DISPLAY "ACCOUNT " WS-ID(I)
                           " BALANCE: " WS-BALANCE(I)
               END-IF

               ADD 1 TO I

           END-PERFORM.
