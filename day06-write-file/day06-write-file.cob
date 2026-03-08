       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY06-WRITE-FILE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CUSTOMER-FILE ASSIGN TO "customers.txt"
               ORGANIZATION IS SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  CUSTOMER-FILE.
       01  CUSTOMER-RECORD     PIC A(50).

       WORKING-STORAGE SECTION.
       01  WS-CUSTOMER-NAME    PIC A(50).
       01  WS-ADD-ANOTHER      PIC X VALUE "Y".
       01  WS-FILE-STATUS      PIC XX.

       PROCEDURE DIVISION.
       MAIN-PROGRAM.
           OPEN OUTPUT CUSTOMER-FILE
           MOVE SPACES TO CUSTOMER-RECORD

           PERFORM UNTIL WS-ADD-ANOTHER = "N" OR WS-ADD-ANOTHER = "n"
               DISPLAY "Enter customer name: "
               ACCEPT WS-CUSTOMER-NAME
               MOVE WS-CUSTOMER-NAME TO CUSTOMER-RECORD
               WRITE CUSTOMER-RECORD
               DISPLAY "Add another? (Y/N): "
               ACCEPT WS-ADD-ANOTHER
           END-PERFORM

           CLOSE CUSTOMER-FILE
           DISPLAY "Customers saved successfully."
           STOP RUN.
