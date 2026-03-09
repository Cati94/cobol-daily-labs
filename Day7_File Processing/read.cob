       IDENTIFICATION DIVISION.
       PROGRAM-ID. READ-CUSTOMERS.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CUSTOMER-FILE ASSIGN TO "customers.txt"
               ORGANIZATION IS SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  CUSTOMER-FILE.
       01  CUSTOMER-RECORD PIC A(50).

       WORKING-STORAGE SECTION.
       01  WS-FILE-STATUS PIC XX.

       PROCEDURE DIVISION.
           OPEN INPUT CUSTOMER-FILE
           MOVE SPACES TO WS-FILE-STATUS
           DISPLAY "Customer List:"
           PERFORM UNTIL WS-FILE-STATUS = "10"
               READ CUSTOMER-FILE
                   AT END MOVE "10" TO WS-FILE-STATUS
                   NOT AT END
                       DISPLAY CUSTOMER-RECORD
               END-READ
           END-PERFORM
           CLOSE CUSTOMER-FILE
           DISPLAY "End of customer list."
           STOP RUN.
