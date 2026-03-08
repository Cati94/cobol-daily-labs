       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY05-READ-FILE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CUSTOMER-FILE
               ASSIGN TO "customers.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD CUSTOMER-FILE.
       01 CUSTOMER-RECORD        PIC X(100).

       WORKING-STORAGE SECTION.
       01 EOF-FLAG               PIC X VALUE "N".

       PROCEDURE DIVISION.

       MAIN-PROCEDURE.
           DISPLAY "Customer List".
           DISPLAY "-------------".

           OPEN INPUT CUSTOMER-FILE

           PERFORM UNTIL EOF-FLAG = "Y"
               READ CUSTOMER-FILE
                   AT END
                       MOVE "Y" TO EOF-FLAG
                   NOT AT END
                       DISPLAY CUSTOMER-RECORD
               END-READ
           END-PERFORM

           CLOSE CUSTOMER-FILE

           STOP RUN.
