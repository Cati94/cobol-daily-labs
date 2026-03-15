# Day 13 — COBOL Bank Transaction Processor

This project is part of my **30 Days of COBOL Challenge**.

## Objective

Build a COBOL program that processes bank transactions from a file and calculates account balances.

## Input File

transactions.dat

Example:

1001 D 500
1001 W 120
1002 D 300
1003 W 50

## Transaction Types

D = Deposit
W = Withdraw

## Features

- Sequential file processing
- Transaction validation
- Account balance updates
- Batch-style processing
- Final balance report

## Compile

cobc -free -x transaction-system.cob

## Run

./transaction-system

## Concepts Practiced

- COBOL file handling
- Arrays with OCCURS
- Conditional logic
- Batch processing
- Financial transaction simulation
