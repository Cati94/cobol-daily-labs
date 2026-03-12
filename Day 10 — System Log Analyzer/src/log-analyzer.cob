       IDENTIFICATION DIVISION.
       PROGRAM-ID. LOG-ANALYZER.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.

       FILE-CONTROL.
           SELECT LOG-FILE ASSIGN TO "system.log"
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT REPORT-FILE ASSIGN TO "report.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.

       FILE SECTION.

       FD LOG-FILE.
       01 LOG-RECORD PIC X(20).

       FD REPORT-FILE.
       01 REPORT-LINE PIC X(50).

       WORKING-STORAGE SECTION.

       01 EOF-FLAG PIC X VALUE "N".
       01 EOF-REPORT PIC X VALUE "N".

       01 INFO-COUNT PIC 9(5) VALUE 0.
       01 ERROR-COUNT PIC 9(5) VALUE 0.
       01 WARNING-COUNT PIC 9(5) VALUE 0.

       PROCEDURE DIVISION.

       MAIN-PROGRAM.

           DISPLAY "STARTING LOG ANALYSIS..."

           OPEN INPUT LOG-FILE
           OPEN OUTPUT REPORT-FILE

           PERFORM UNTIL EOF-FLAG = "Y"

               READ LOG-FILE
                   AT END
                       MOVE "Y" TO EOF-FLAG
                   NOT AT END
                       DISPLAY "LOG READ: " LOG-RECORD
                       PERFORM PROCESS-LOG
               END-READ

           END-PERFORM

           PERFORM WRITE-REPORT

           CLOSE LOG-FILE
           CLOSE REPORT-FILE

           DISPLAY "REPORT GENERATED SUCCESSFULLY"
           DISPLAY " "

           PERFORM DISPLAY-REPORT

           STOP RUN.

       PROCESS-LOG.

           EVALUATE TRUE
               WHEN LOG-RECORD(1:4) = "INFO"
                   ADD 1 TO INFO-COUNT
               WHEN LOG-RECORD(1:5) = "ERROR"
                   ADD 1 TO ERROR-COUNT
               WHEN LOG-RECORD(1:7) = "WARNING"
                   ADD 1 TO WARNING-COUNT
               WHEN OTHER
                   CONTINUE
           END-EVALUATE.

       WRITE-REPORT.

           MOVE "SYSTEM LOG REPORT" TO REPORT-LINE
           WRITE REPORT-LINE

           MOVE "--------------------------" TO REPORT-LINE
           WRITE REPORT-LINE

           STRING "INFO EVENTS: " DELIMITED BY SIZE
                  INFO-COUNT DELIMITED BY SIZE
                  INTO REPORT-LINE
           END-STRING
           WRITE REPORT-LINE

           STRING "WARNING EVENTS: " DELIMITED BY SIZE
                  WARNING-COUNT DELIMITED BY SIZE
                  INTO REPORT-LINE
           END-STRING
           WRITE REPORT-LINE

           STRING "ERROR EVENTS: " DELIMITED BY SIZE
                  ERROR-COUNT DELIMITED BY SIZE
                  INTO REPORT-LINE
           END-STRING
           WRITE REPORT-LINE.

       DISPLAY-REPORT.

           DISPLAY "DISPLAYING REPORT CONTENT:"
           DISPLAY " "

           MOVE "N" TO EOF-REPORT
           OPEN INPUT REPORT-FILE

           PERFORM UNTIL EOF-REPORT = "Y"

               READ REPORT-FILE
                   AT END
                       MOVE "Y" TO EOF-REPORT
                   NOT AT END
                       DISPLAY REPORT-LINE
               END-READ

           END-PERFORM

           CLOSE REPORT-FILE.
