# Day 9 — Sales Report Generator (COBOL)

## Overview

This project is part of the **30 Days of COBOL Challenge**.

The goal of Day 9 is to build a **batch processing program** that reads sales data from a file, processes the records, calculates the total value of sales, and generates a report file.

This type of processing is typical in legacy enterprise systems and financial batch jobs.

---

## Learning Objectives

In this project we practice:

* Reading sequential files
* Detecting end-of-file conditions
* Processing records in batch mode
* Accumulating totals
* Writing output reports
* Providing execution feedback in the terminal

These concepts are fundamental when working with **COBOL data processing systems**.

---

## Project Structure

```
Day09-Sales-Report
│
├── src
│   └── sales-report.cbl
│
├── data
│   └── sales.dat
│
├── output
│   └── report.txt
│
└── README.md
```

---

## Input File

`sales.dat`

Example:

```
001 120
002 350
003 200
004 100
```

Format:

```
PRODUCT-ID   SALE-VALUE
```

---

## Output File

After running the program, a report file is generated:

`report.txt`

Example output:

```
TOTAL SALES:
770
```

---

## Program Features

The program performs the following steps:

1. Opens the sales input file.
2. Reads each sales record sequentially.
3. Adds each sale value to a running total.
4. Writes the final total to a report file.
5. Displays a confirmation message in the terminal when processing is completed.

---

## Compilation

Compile the program using:

```
cobc -x sales-report.cbl
```

---

## Run the Program

```
./sales-report
```

If the program runs successfully, a message will appear in the terminal indicating that the report was generated.

---

## Example Terminal Output

```
Report generated successfully
Records processed: 4
Total sales value: 770
```

---

## Concepts Practiced

* Sequential file handling
* Batch processing logic
* Data accumulation
* Report generation
* Basic program feedback

These are common patterns in enterprise data processing systems.

---

## Part of

**30 Days of COBOL Challenge**

This repository documents daily hands-on projects designed to practice and reinforce COBOL programming skills through practical exercises.

---
