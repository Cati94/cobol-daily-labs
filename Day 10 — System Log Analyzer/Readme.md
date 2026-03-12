# Day 11 — COBOL Log Analyzer

## Overview

This program is a **COBOL log analysis tool** that reads a system log file, counts different types of events, generates a report file, and displays the generated report in the terminal.

The application demonstrates common **batch processing concepts used in enterprise COBOL environments**, including:

* Sequential file processing
* Record evaluation
* Event counting
* Report generation
* Reading and displaying generated reports

This type of workflow is commonly used in **system monitoring, banking systems, and mainframe batch jobs**.

---

# Features

* Reads a log file (`system.log`)
* Detects and counts the following event types:

  * `INFO`
  * `WARNING`
  * `ERROR`
* Generates a formatted report file (`report.txt`)
* Displays the report contents in the terminal
* Shows log entries being processed during execution

---

# Project Structure

```
Day-11-Log-Analyzer/
│
├── log-analyzer.cbl
├── system.log
├── report.txt
└── README.md
```

---

# Example Log File

Example `system.log`:

```
INFO
INFO
WARNING
ERROR
INFO
ERROR
```

Each line represents a system event.

---

# Generated Report

After running the program, a file named **`report.txt`** is generated.

Example output:

```
SYSTEM LOG REPORT
--------------------------
INFO EVENTS: 3
WARNING EVENTS: 1
ERROR EVENTS: 2
```

---

# Terminal Output Example

When the program runs, it displays the logs being processed and the final report.

```
STARTING LOG ANALYSIS...

LOG READ: INFO
LOG READ: INFO
LOG READ: WARNING
LOG READ: ERROR
LOG READ: INFO
LOG READ: ERROR

REPORT GENERATED SUCCESSFULLY

DISPLAYING REPORT CONTENT:

SYSTEM LOG REPORT
--------------------------
INFO EVENTS: 3
WARNING EVENTS: 1
ERROR EVENTS: 2
```

---

# How It Works

### 1. Read the Log File

The program opens `system.log` and reads records sequentially using:

```
READ LOG-FILE
```

Each record is evaluated to determine the event type.

---

### 2. Process Events

The program uses the `EVALUATE` statement to classify each log entry:

```
EVALUATE TRUE
    WHEN LOG-RECORD(1:4) = "INFO"
    WHEN LOG-RECORD(1:5) = "ERROR"
    WHEN LOG-RECORD(1:7) = "WARNING"
```

Counters are incremented accordingly.

---

### 3. Generate the Report

After processing all log records, a report file is created using:

```
WRITE REPORT-LINE
```

The report contains totals for each event type.

---

### 4. Display the Report

The program reopens `report.txt`, reads it line by line, and displays the contents using:

```
DISPLAY REPORT-LINE
```

This allows users to immediately view the analysis results.

---

# Concepts Practiced

This project practices several **core COBOL concepts**:

* File handling (`OPEN`, `READ`, `WRITE`, `CLOSE`)
* Sequential file processing
* Conditional logic (`EVALUATE`)
* String handling (`STRING`)
* Counters and numeric fields
* Terminal output using `DISPLAY`

---

# Learning Objective

The goal of this exercise is to simulate a **real-world batch processing scenario** where a system analyzes logs and produces a summary report.

By completing this project you practice:

* Building data-processing programs
* Working with sequential files
* Generating structured reports
* Displaying results for operational monitoring

---

# Next Steps

Possible improvements for this project:

* Add timestamps to log entries
* Track additional event types
* Calculate error percentages
* Generate formatted reports with aligned columns
* Process larger log files

---

# Part of the "30 Days of COBOL" Challenge

This project is part of a **30-day learning challenge designed to practice COBOL through practical programs**.

Each day focuses on building progressively more complex applications inspired by real-world enterprise use cases.

---
