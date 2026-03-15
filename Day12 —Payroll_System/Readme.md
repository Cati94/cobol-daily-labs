# Day 12 — COBOL Payroll System

*(Aligned with IBM COBOL Basic Testing and Debugging)*

![Logo](https://github.com/Cati94/cobol-daily-labs/blob/main/Day12%20%E2%80%94Payroll_System/payrollprocessingsystem.png)


## Objective

Develop a simple **COBOL payroll processing program** that reads employee data from a file, calculates salaries, and generates a report.

The goal of this exercise is to practice **testing, debugging, and validation techniques** used in enterprise COBOL environments.

---

# Challenge Description

Create a COBOL program that processes employee payroll information from a sequential data file.

The program must:

1. Read employee records from a file named `employees.dat`.

2. Extract the following fields:

   * **Employee ID** (numeric)
   * **Employee Name** (alphanumeric)
   * **Hours Worked** (numeric)
   * **Hourly Rate** (numeric)

3. Calculate the **gross salary** for each employee using:

```
salary = hours_worked * hourly_rate
```

4. Generate a payroll report file named:

```
payroll.txt
```

The report should contain:

* Employee ID
* Employee Name
* Calculated Salary

---

# Input File Example

`employees.dat`

```
001 MARIA 40 20
002 JOAO 35 18
003 ANA 45 22
```

Format:

```
ID NAME HOURS RATE
```

---

# Expected Output Report

`payroll.txt`

```
PAYROLL REPORT
--------------------------
ID   NAME   SALARY
001  MARIA  800
002  JOAO   630
003  ANA    990
```

---

# Debugging and Testing Requirements

To simulate real-world development practices, the program must include **debugging and validation techniques**:

### 1. Progress Monitoring

Use `DISPLAY` statements to show program execution steps, such as:

```
DISPLAY "Reading employee record..."
DISPLAY "Calculating salary..."
DISPLAY "Writing report..."
```

---

### 2. Input Validation

The program must verify that:

* Hours worked are greater than zero.
* Hourly rate is greater than zero.

If invalid data is detected, display an error message:

```
DISPLAY "WARNING: Invalid employee data detected"
```

---

### 3. Test With Multiple Data Sets

Create different versions of `employees.dat` to test:

| Test Case     | Scenario         |
| ------------- | ---------------- |
| Normal data   | All fields valid |
| Invalid hours | Hours = 0        |
| Invalid rate  | Rate = 0         |
| Mixed records | Valid + invalid  |

---

# Concepts Practiced

This exercise reinforces several key concepts from the **IBM COBOL Testing and Debugging module**:

* Sequential file processing
* COBOL arithmetic operations
* Program execution tracing using `DISPLAY`
* Basic data validation
* Manual test case creation
* Debugging logic errors

---

# Learning Outcome

After completing this challenge you should be able to:

* Process data from files using COBOL
* Implement salary calculations
* Generate simple reports
* Test COBOL programs with multiple datasets
* Use debugging techniques to track program execution

---

# Part of the **30 Days of COBOL Challenge**

This project is part of a personal learning journey to build **30 practical COBOL programs inspired by real enterprise systems**.
