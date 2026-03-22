       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANK-SYSTEM.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ACCOUNTS-FILE ASSIGN TO "accounts.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT TRANSACTIONS-FILE ASSIGN TO "transactions.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD ACCOUNTS-FILE.
       01 ACCOUNT-RECORD.
           05 ACC-ID        PIC 9(4).
           05 ACC-NAME      PIC A(30).
           05 ACC-BALANCE   PIC 9(7)V99.

       FD TRANSACTIONS-FILE.
       01 TRANSACTION-RECORD.
           05 TRANS-ID       PIC 9(4).
           05 TRANS-DATE     PIC A(10).
           05 TRANS-TYPE     PIC A(15).
           05 TRANS-AMOUNT   PIC 9(7)V99.
           05 TRANS-ACC-ID   PIC 9(4).

       WORKING-STORAGE SECTION.
       01 WS-OPTION        PIC 9 VALUE 0.
       01 WS-TRANS-OPTION  PIC X.
       01 WS-ACC-ID        PIC 9(4).
       01 WS-ACC-NAME      PIC A(30).
       01 WS-ACC-BALANCE   PIC 9(7)V99.
       01 WS-AMOUNT        PIC 9(7)V99.
       01 WS-FLAG          PIC X VALUE 'N'.
       01 WS-EOF-ACCOUNTS  PIC X VALUE 'N'.
       01 WS-EOF-TRANS     PIC X VALUE 'N'.
       01 WS-TRANS-TYPE    PIC A(15).
       01 TODAY-DATE.
           05 TD-DAY        PIC 99.
           05 TD-MONTH      PIC 99.
           05 TD-YEAR       PIC 9999.

       PROCEDURE DIVISION.
       MAIN-PROGRAM.
           PERFORM SHOW-MENU UNTIL WS-OPTION = 6.
           DISPLAY "Saindo do sistema..."
           STOP RUN.

       SHOW-MENU.
           DISPLAY "=============================="
           DISPLAY " Banco COBOL - Menu Principal"
           DISPLAY "1. Criar nova conta"
           DISPLAY "2. Consultar conta"
           DISPLAY "3. Deposito / Levantamento"
           DISPLAY "4. Historico de transacoes"
           DISPLAY "5. Listar todas contas"
           DISPLAY "6. Sair"
           DISPLAY "Escolha uma opcao (1-6): "
           ACCEPT WS-OPTION
           EVALUATE WS-OPTION
               WHEN 1
                   PERFORM CREATE-ACCOUNT
               WHEN 2
                   PERFORM VIEW-ACCOUNT
               WHEN 3
                   PERFORM TRANSACT
               WHEN 4
                   PERFORM VIEW-TRANSACTIONS
               WHEN 5
                   PERFORM LIST-ACCOUNTS
               WHEN 6
                   CONTINUE
               WHEN OTHER
                   DISPLAY "Opcao invalida."
           END-EVALUATE.

       CREATE-ACCOUNT.
           DISPLAY "Digite ID da nova conta (4 digitos): "
           ACCEPT WS-ACC-ID
           PERFORM CHECK-ACCOUNT-ID
           IF WS-FLAG = 'Y'
               DISPLAY "Erro: Conta ja existe!"
               EXIT.
           DISPLAY "Digite nome do titular: "
           ACCEPT WS-ACC-NAME
           MOVE 0 TO WS-ACC-BALANCE
           OPEN EXTEND ACCOUNTS-FILE
           MOVE WS-ACC-ID TO ACC-ID
           MOVE WS-ACC-NAME TO ACC-NAME
           MOVE WS-ACC-BALANCE TO ACC-BALANCE
           WRITE ACCOUNT-RECORD
           CLOSE ACCOUNTS-FILE
           DISPLAY "Conta criada com sucesso!".

       VIEW-ACCOUNT.
           DISPLAY "Digite ID da conta: "
           ACCEPT WS-ACC-ID
           OPEN INPUT ACCOUNTS-FILE
           MOVE 'N' TO WS-FLAG
           MOVE 'N' TO WS-EOF-ACCOUNTS
           PERFORM UNTIL WS-EOF-ACCOUNTS = 'Y' OR WS-FLAG = 'Y'
               READ ACCOUNTS-FILE
                   AT END MOVE 'Y' TO WS-EOF-ACCOUNTS
                   NOT AT END
                       IF ACC-ID = WS-ACC-ID
                           MOVE ACC-NAME TO WS-ACC-NAME
                           MOVE ACC-BALANCE TO WS-ACC-BALANCE
                           MOVE 'Y' TO WS-FLAG
                       END-IF
               END-READ
           END-PERFORM
           CLOSE ACCOUNTS-FILE
           IF WS-FLAG = 'Y'
               DISPLAY "Conta encontrada:"
               DISPLAY "ID: " WS-ACC-ID
               DISPLAY "Titular: " WS-ACC-NAME
               DISPLAY "Saldo: " WS-ACC-BALANCE
           ELSE
               DISPLAY "Conta nao encontrada.".

       TRANSACT.
           DISPLAY "Digite ID da conta: "
           ACCEPT WS-ACC-ID
           OPEN I-O ACCOUNTS-FILE
           MOVE 'N' TO WS-FLAG
           MOVE 'N' TO WS-EOF-ACCOUNTS
           PERFORM UNTIL WS-EOF-ACCOUNTS = 'Y' OR WS-FLAG = 'Y'
               READ ACCOUNTS-FILE
                   AT END MOVE 'Y' TO WS-EOF-ACCOUNTS
                   NOT AT END
                       IF ACC-ID = WS-ACC-ID
                           MOVE 'Y' TO WS-FLAG
                       END-IF
               END-READ
           END-PERFORM
           IF WS-FLAG = 'N'
               DISPLAY "Conta nao encontrada."
               CLOSE ACCOUNTS-FILE
               EXIT.
           DISPLAY "Digite D para deposito ou L para levantamento: "
           ACCEPT WS-TRANS-OPTION
           DISPLAY "Digite valor: "
           ACCEPT WS-AMOUNT
           IF WS-AMOUNT <= 0
               DISPLAY "Valor invalido!"
               CLOSE ACCOUNTS-FILE
               EXIT.
           IF WS-TRANS-OPTION = 'D'
               ADD WS-AMOUNT TO ACC-BALANCE
               MOVE "Deposito" TO WS-TRANS-TYPE
           ELSE IF WS-TRANS-OPTION = 'L'
               IF WS-AMOUNT > ACC-BALANCE
                   DISPLAY "Saldo insuficiente!"
                   CLOSE ACCOUNTS-FILE
                   EXIT
               ELSE
                   SUBTRACT WS-AMOUNT FROM ACC-BALANCE
                   MOVE "Levantamento" TO WS-TRANS-TYPE
               END-IF
           ELSE
               DISPLAY "Opcao invalida!"
               CLOSE ACCOUNTS-FILE
               EXIT
           END-IF
           REWRITE ACCOUNT-RECORD
           CLOSE ACCOUNTS-FILE

       *> Registrar transacao
           OPEN EXTEND TRANSACTIONS-FILE
           MOVE WS-ACC-ID TO TRANS-ACC-ID
           MOVE WS-AMOUNT TO TRANS-AMOUNT
           MOVE WS-TRANS-TYPE TO TRANS-TYPE
           MOVE FUNCTION CURRENT-DATE(1:10) TO TRANS-DATE
           WRITE TRANSACTION-RECORD
           CLOSE TRANSACTIONS-FILE
           DISPLAY "Transacao realizada com sucesso!".

       VIEW-TRANSACTIONS.
           DISPLAY "Digite ID da conta: "
           ACCEPT WS-ACC-ID
           OPEN INPUT TRANSACTIONS-FILE
           MOVE 'N' TO WS-EOF-TRANS
           PERFORM UNTIL WS-EOF-TRANS = 'Y'
               READ TRANSACTIONS-FILE
                   AT END MOVE 'Y' TO WS-EOF-TRANS
                   NOT AT END
                       IF TRANS-ACC-ID = WS-ACC-ID
                           DISPLAY "Data: " TRANS-DATE " Tipo: " TRANS-TYPE " Valor: " TRANS-AMOUNT
                       END-IF
               END-READ
           END-PERFORM
           CLOSE TRANSACTIONS-FILE.

       LIST-ACCOUNTS.
           OPEN INPUT ACCOUNTS-FILE
           MOVE 'N' TO WS-EOF-ACCOUNTS
           PERFORM UNTIL WS-EOF-ACCOUNTS = 'Y'
               READ ACCOUNTS-FILE
                   AT END MOVE 'Y' TO WS-EOF-ACCOUNTS
                   NOT AT END
                       DISPLAY "ID: " ACC-ID " Titular: " ACC-NAME " Saldo: " ACC-BALANCE
               END-READ
           END-PERFORM
           CLOSE ACCOUNTS-FILE.

       CHECK-ACCOUNT-ID.
           OPEN INPUT ACCOUNTS-FILE
           MOVE 'N' TO WS-EOF-ACCOUNTS
           MOVE 'N' TO WS-FLAG
           PERFORM UNTIL WS-EOF-ACCOUNTS = 'Y'
               READ ACCOUNTS-FILE
                   AT END MOVE 'Y' TO WS-EOF-ACCOUNTS
                   NOT AT END
                       IF ACC-ID = WS-ACC-ID
                           MOVE 'Y' TO WS-FLAG
                       END-IF
               END-READ
           END-PERFORM
           CLOSE ACCOUNTS-FILE.
