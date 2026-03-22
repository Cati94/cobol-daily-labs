# Day 14 — COBOL Bank Account Report

This program processes a file of bank accounts and generates a financial summary report.

## Objective
Practice COBOL file processing and statistical calculations using a batch report.

The program:
- Reads bank account records
- Counts positive, negative and zero balances
- Calculates total balance
- Calculates average balance
- Displays a final report

## Input File
File: `accounts.dat`

Example:
1001 1500
1002 -200
1003 0
1004 750
1005 -50
1006 2000

Format:
ACCOUNT-ID BALANCE

## Example Output

BANK ACCOUNT REPORT
-----------------------------
Total Accounts: 6
Positive Balance: 3
Negative Balance: 2
Zero Balance: 1

Total Balance: 4000
Average Balance: 666.66

PROCESSING COMPLETE

## Concepts Practiced
- COBOL File Processing
- READ loop until EOF
- IF / ELSE logic
- Counters and accumulators
- Financial report generation

Part of the **30 Days of COBOL Challenge**.
