       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANK-SYSTEM-D28.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT USERS-FILE ASSIGN TO "users.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD USERS-FILE.
       01 USER-REC.
           05 USER-ID    PIC 9(4).
           05 USER-NAME  PIC A(20).
           05 USER-PASS  PIC A(20).
           05 USER-ROLE  PIC X.

       WORKING-STORAGE SECTION.
       01 WS-OPTION     PIC 9 VALUE 0.
       01 WS-USERNAME   PIC A(20).
       01 WS-PASSWORD   PIC A(20).
       01 WS-ROLE       PIC X.
       01 WS-FOUND      PIC X VALUE "N".
       01 EOF-FLAG      PIC X VALUE "N".
       01 WS-LAST-ID    PIC 9(4) VALUE 0.

       PROCEDURE DIVISION.

MAIN.
       PERFORM LOGIN-MENU
       STOP RUN.

LOGIN-MENU.
       DISPLAY "===== SISTEMA ====="
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

       GO TO LOGIN-MENU.

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
                       MOVE USER-ROLE TO WS-ROLE
                       MOVE "S" TO WS-FOUND
                       EXIT PERFORM
                   END-IF
           END-READ
       END-PERFORM

       CLOSE USERS-FILE

       IF WS-FOUND = "S"
           DISPLAY "Login com sucesso!"
           PERFORM USER-MENU
       ELSE
           DISPLAY "Credenciais invalidas!"
       END-IF.

USER-MENU.
       IF WS-ROLE = "A"
           PERFORM ADMIN-MENU
       ELSE
           PERFORM NORMAL-MENU
       END-IF.

ADMIN-MENU.
       DISPLAY "===== ADMIN ====="
       DISPLAY "1. Listar Utilizadores"
       DISPLAY "2. Sair"
       ACCEPT WS-OPTION

       EVALUATE WS-OPTION
           WHEN 1 PERFORM LIST-USERS
           WHEN 2 EXIT PARAGRAPH
       END-EVALUATE

       GO TO ADMIN-MENU.

NORMAL-MENU.
       DISPLAY "===== UTILIZADOR ====="
       DISPLAY "1. Ver perfil"
       DISPLAY "2. Sair"
       ACCEPT WS-OPTION

       EVALUATE WS-OPTION
           WHEN 1 DISPLAY "User: " WS-USERNAME
           WHEN 2 EXIT PARAGRAPH
       END-EVALUATE

       GO TO NORMAL-MENU.

LIST-USERS.
       OPEN INPUT USERS-FILE
       MOVE "N" TO EOF-FLAG

       PERFORM UNTIL EOF-FLAG = "S"
           READ USERS-FILE
               AT END MOVE "S" TO EOF-FLAG
               NOT AT END
                   DISPLAY USER-ID " "
                           USER-NAME " "
                           USER-ROLE
           END-READ
       END-PERFORM

       CLOSE USERS-FILE.

CREATE-USER.
       PERFORM GET-LAST-ID
       ADD 1 TO WS-LAST-ID

       DISPLAY "Username:"
       ACCEPT WS-USERNAME

       DISPLAY "Password:"
       ACCEPT WS-PASSWORD

       DISPLAY "Role (A/U):"
       ACCEPT WS-ROLE

       OPEN EXTEND USERS-FILE
       MOVE WS-LAST-ID TO USER-ID
       MOVE WS-USERNAME TO USER-NAME
       MOVE WS-PASSWORD TO USER-PASS
       MOVE WS-ROLE TO USER-ROLE
       WRITE USER-REC
       CLOSE USERS-FILE

       DISPLAY "Utilizador criado.".

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
