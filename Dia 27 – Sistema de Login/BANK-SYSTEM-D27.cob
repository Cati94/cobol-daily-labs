       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANK-SYSTEM-D27.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT USERS-FILE ASSIGN TO "users.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD USERS-FILE.
       01 USER-REC.
           05 USER-ID       PIC 9(4).
           05 USER-NAME     PIC A(20).
           05 USER-PASS     PIC A(20).

       WORKING-STORAGE SECTION.
       01 WS-OPTION      PIC 9 VALUE 0.
       01 WS-USERNAME    PIC A(20).
       01 WS-PASSWORD    PIC A(20).
       01 WS-FOUND       PIC X VALUE "N".
       01 EOF-FLAG       PIC X VALUE "N".
       01 WS-LAST-ID     PIC 9(4) VALUE 0.

       PROCEDURE DIVISION.

MAIN.
       PERFORM MAIN-MENU
       STOP RUN.

MAIN-MENU.
       DISPLAY "===== LOGIN SYSTEM ====="
       DISPLAY "1. Login"
       DISPLAY "2. Criar Utilizador"
       DISPLAY "3. Sair"
       ACCEPT WS-OPTION

       EVALUATE WS-OPTION
           WHEN 1 PERFORM LOGIN
           WHEN 2 PERFORM CREATE-USER
           WHEN 3 EXIT PARAGRAPH
           WHEN OTHER DISPLAY "Opcao invalida"
       END-EVALUATE

       GO TO MAIN-MENU.


LOGIN.
       DISPLAY "Username:"
       ACCEPT WS-USERNAME

       DISPLAY "Password:"
       ACCEPT WS-PASSWORD

       MOVE "N" TO WS-FOUND
       OPEN INPUT USERS-FILE
       MOVE "N" TO EOF-FLAG

       PERFORM UNTIL EOF-FLAG = "S"
           READ USERS-FILE
               AT END MOVE "S" TO EOF-FLAG
               NOT AT END
                   IF USER-NAME = WS-USERNAME
                      AND USER-PASS = WS-PASSWORD
                       MOVE "S" TO WS-FOUND
                       DISPLAY "Login com sucesso!"
                       EXIT PERFORM
                   END-IF
           END-READ
       END-PERFORM

       CLOSE USERS-FILE

       IF WS-FOUND = "N"
           DISPLAY "Credenciais invalidas!"
       END-IF.

CREATE-USER.
       PERFORM GET-LAST-ID
       ADD 1 TO WS-LAST-ID

       DISPLAY "Novo username:"
       ACCEPT WS-USERNAME

       DISPLAY "Nova password:"
       ACCEPT WS-PASSWORD

       OPEN EXTEND USERS-FILE
       MOVE WS-LAST-ID TO USER-ID
       MOVE WS-USERNAME TO USER-NAME
       MOVE WS-PASSWORD TO USER-PASS
       WRITE USER-REC
       CLOSE USERS-FILE

       DISPLAY "Utilizador criado com ID: " WS-LAST-ID.

GET-LAST-ID.
       MOVE 0 TO WS-LAST-ID
       OPEN INPUT USERS-FILE
       MOVE "N" TO EOF-FLAG

       PERFORM UNTIL EOF-FLAG = "S"
           READ USERS-FILE
               AT END MOVE "S" TO EOF-FLAG
               NOT AT END MOVE USER-ID TO WS-LAST-ID
           END-READ
       END-PERFORM

       CLOSE USERS-FILE.
