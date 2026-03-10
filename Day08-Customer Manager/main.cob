    IDENTIFICATION DIVISION.
       PROGRAM-ID. CUSTOMER-MANAGER.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CUSTOMER-FILE ASSIGN TO "customers.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD CUSTOMER-FILE.
       01 CUSTOMER-RECORD.
           05 CUSTOMER-ID     PIC 9(3).
           05 CUSTOMER-NAME   PIC A(20).
           05 CUSTOMER-EMAIL  PIC A(30).

       WORKING-STORAGE SECTION.

       01 MENU-OPTION      PIC 9.
       01 EOF-FLAG         PIC A VALUE "N".
       01 WS-SEARCH-ID     PIC 9(3).

       PROCEDURE DIVISION.

*>-----------------------------
*> Criar arquivo se não existir
*>-----------------------------
INITIALIZE-FILE.
       OPEN OUTPUT CUSTOMER-FILE
       CLOSE CUSTOMER-FILE.

*>-----------------------------
*> Menu principal
*>-----------------------------
MAIN-MENU.
       PERFORM INITIALIZE-FILE
       PERFORM UNTIL MENU-OPTION = 4

           DISPLAY " "
           DISPLAY "==== CUSTOMER MANAGER ===="
           DISPLAY "1 - Add Customer"
           DISPLAY "2 - List Customers"
           DISPLAY "3 - Search Customer"
           DISPLAY "4 - Exit"
           DISPLAY "Option: "

           ACCEPT MENU-OPTION

           EVALUATE MENU-OPTION
               WHEN 1
                   PERFORM ADD-CUSTOMER
               WHEN 2
                   PERFORM LIST-CUSTOMERS
               WHEN 3
                   PERFORM SEARCH-CUSTOMER
           END-EVALUATE

       END-PERFORM.

       DISPLAY "Exiting program..."
       STOP RUN.

*>-----------------------------
*> Adicionar cliente
*>-----------------------------
ADD-CUSTOMER.
       OPEN EXTEND CUSTOMER-FILE

       DISPLAY "Customer ID (3 digits): "
       ACCEPT CUSTOMER-ID

       DISPLAY "Customer Name: "
       ACCEPT CUSTOMER-NAME

       DISPLAY "Customer Email: "
       ACCEPT CUSTOMER-EMAIL

       WRITE CUSTOMER-RECORD

       CLOSE CUSTOMER-FILE

       DISPLAY "Customer saved."
       .

*>-----------------------------
*> Listar clientes
*>-----------------------------
LIST-CUSTOMERS.
       MOVE "N" TO EOF-FLAG
       OPEN INPUT CUSTOMER-FILE

       DISPLAY " "
       DISPLAY "ID   NAME                 EMAIL"
       DISPLAY "-------------------------------------------"

       PERFORM UNTIL EOF-FLAG = "Y"
           READ CUSTOMER-FILE
               AT END
                   MOVE "Y" TO EOF-FLAG
               NOT AT END
                   DISPLAY CUSTOMER-ID " " CUSTOMER-NAME " " CUSTOMER-EMAIL
           END-READ
       END-PERFORM

       CLOSE CUSTOMER-FILE
       .

*>-----------------------------
*> Buscar cliente por ID
*>-----------------------------
SEARCH-CUSTOMER.
       MOVE "N" TO EOF-FLAG

       DISPLAY "Enter ID to search (3 digits): "
       ACCEPT WS-SEARCH-ID

       OPEN INPUT CUSTOMER-FILE

       PERFORM UNTIL EOF-FLAG = "Y"
           READ CUSTOMER-FILE
               AT END
                   MOVE "Y" TO EOF-FLAG
               NOT AT END
                   IF CUSTOMER-ID = WS-SEARCH-ID
                       DISPLAY "Found: "
                       DISPLAY "ID: " CUSTOMER-ID
                       DISPLAY "Name: " CUSTOMER-NAME
                       DISPLAY "Email: " CUSTOMER-EMAIL
                       MOVE "Y" TO EOF-FLAG
                   END-IF
           END-READ
       END-PERFORM

       CLOSE CUSTOMER-FILE
       .
