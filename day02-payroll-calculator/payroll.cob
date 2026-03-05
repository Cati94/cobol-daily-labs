       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAYROLL.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       
       01 WS-OPCAO              PIC X VALUE "S".

       
       01 WS-NOME               PIC X(30).
       01 WS-SALARIO-BRUTO      PIC 9(6)V99.

       
       01 WS-TAXA-IRS           PIC 9(3)V99 VALUE 23.00.
       01 WS-TAXA-SS            PIC 9(3)V99 VALUE 11.00.

       
       01 WS-DESCONTO-IRS       PIC 9(6)V99 VALUE 0.
       01 WS-DESCONTO-SS        PIC 9(6)V99 VALUE 0.

       
       01 WS-SALARIO-LIQUIDO    PIC 9(6)V99 VALUE 0.

       PROCEDURE DIVISION.

       MAIN-PROGRAM.

           PERFORM UNTIL WS-OPCAO = "N"

               PERFORM LER-DADOS
               PERFORM CALCULAR-SALARIO
               PERFORM MOSTRAR-RECIBO
               PERFORM PERGUNTAR-CONTINUAR

           END-PERFORM

           STOP RUN.

       LER-DADOS.

           DISPLAY "Nome do funcionario:"
           ACCEPT WS-NOME

           DISPLAY "Salario bruto:"
           ACCEPT WS-SALARIO-BRUTO.

       CALCULAR-SALARIO.

           COMPUTE WS-DESCONTO-IRS =
               WS-SALARIO-BRUTO * WS-TAXA-IRS / 100

           COMPUTE WS-DESCONTO-SS =
               WS-SALARIO-BRUTO * WS-TAXA-SS / 100

           COMPUTE WS-SALARIO-LIQUIDO =
               WS-SALARIO-BRUTO
               - WS-DESCONTO-IRS
               - WS-DESCONTO-SS.

       MOSTRAR-RECIBO.

           DISPLAY "-----------------------------"
           DISPLAY "RECIBO SALARIAL"
           DISPLAY "Funcionario: " WS-NOME
           DISPLAY "Salario Bruto: " WS-SALARIO-BRUTO
           DISPLAY "IRS: " WS-DESCONTO-IRS
           DISPLAY "Seguranca Social: " WS-DESCONTO-SS
           DISPLAY "Salario Liquido: " WS-SALARIO-LIQUIDO
           DISPLAY "-----------------------------".

       PERGUNTAR-CONTINUAR.

           DISPLAY "Deseja calcular outro salario? (S/N)"
           ACCEPT WS-OPCAO

           IF WS-OPCAO = "s"
               MOVE "S" TO WS-OPCAO
           END-IF.
