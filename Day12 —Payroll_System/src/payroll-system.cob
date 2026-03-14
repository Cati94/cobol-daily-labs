       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAYROLL-SYSTEM.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

           SELECT EMPLOYEE-FILE
           ASSIGN TO "employees.dat"
           ORGANIZATION IS LINE SEQUENTIAL
           FILE STATUS IS WS-EMP-STATUS.

           SELECT REPORT-FILE
           ASSIGN TO "payroll.txt"
           ORGANIZATION IS LINE SEQUENTIAL
           FILE STATUS IS WS-REP-STATUS.

       DATA DIVISION.

       FILE SECTION.

       FD EMPLOYEE-FILE.
       01 EMPLOYEE-LINE PIC X(80).

       FD REPORT-FILE.
       01 REPORT-LINE PIC X(80).

       WORKING-STORAGE SECTION.

       01 WS-EOF PIC X VALUE "N".

       01 WS-EMP-STATUS PIC XX.
       01 WS-REP-STATUS PIC XX.

       01 EMP-ID PIC 9(3).
       01 EMP-NAME PIC X(15).
       01 EMP-HOURS PIC S9(3).
       01 EMP-RATE PIC 9(3).

       01 WS-SALARY PIC 9(6).

       PROCEDURE DIVISION.

       MAIN-PROCEDURE.

           DISPLAY "STARTING PAYROLL PROCESSING..."

           OPEN INPUT EMPLOYEE-FILE
           IF WS-EMP-STATUS NOT = "00"
              DISPLAY "ERROR OPENING EMPLOYEE FILE: " WS-EMP-STATUS
              STOP RUN
           END-IF

           OPEN OUTPUT REPORT-FILE
           IF WS-REP-STATUS NOT = "00"
              DISPLAY "ERROR OPENING REPORT FILE: " WS-REP-STATUS
              STOP RUN
           END-IF

           MOVE "PAYROLL REPORT" TO REPORT-LINE
           WRITE REPORT-LINE

           MOVE "------------------------" TO REPORT-LINE
           WRITE REPORT-LINE

           PERFORM UNTIL WS-EOF = "Y"

               READ EMPLOYEE-FILE
                   AT END
                       MOVE "Y" TO WS-EOF
                   NOT AT END

                       PERFORM PROCESS-LINE

               END-READ

           END-PERFORM

           CLOSE EMPLOYEE-FILE
           CLOSE REPORT-FILE

           DISPLAY "PAYROLL REPORT GENERATED."

           STOP RUN.

       PROCESS-LINE.

           UNSTRING EMPLOYEE-LINE
               DELIMITED BY SPACE
               INTO EMP-ID
                    EMP-NAME
                    EMP-HOURS
                    EMP-RATE
           END-UNSTRING

           DISPLAY "READING EMPLOYEE: "
               EMP-ID SPACE EMP-NAME SPACE
               EMP-HOURS SPACE EMP-RATE

           IF EMP-HOURS <= 0 OR EMP-RATE <= 0

               DISPLAY "WARNING: INVALID DATA FOR EMPLOYEE "
               EMP-ID

           ELSE

               COMPUTE WS-SALARY = EMP-HOURS * EMP-RATE

               DISPLAY "CALCULATED SALARY: " WS-SALARY

               STRING
                   EMP-ID DELIMITED BY SIZE
                   SPACE
                   EMP-NAME DELIMITED BY SIZE
                   SPACE
                   WS-SALARY DELIMITED BY SIZE
                   INTO REPORT-LINE
               END-STRING

               WRITE REPORT-LINE

           END-IF.
