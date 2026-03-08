# Day 5 – Reading a Sequential File in COBOL

![Logo](https://github.com/Cati94/cobol-daily-labs/blob/main/Day%205-Read_a_Sequential_File/readfile.png) 

## 🎯 Objective

Learn how to read data from a sequential file using COBOL.

This example demonstrates how COBOL programs process batch data such as customer lists, payroll files, or transaction logs.

---

## 📚 Concepts Covered

* FILE-CONTROL
* Sequential file access
* READ statement
* AT END condition
* FILE STATUS error handling
* Loop processing with PERFORM

---

## 📂 Project Structure

```
day05/
│
├── day05-read-file.cob
├── customers.txt
└── README.md
```

---

## 📄 Example Input File

`customers.txt`

```
John Smith
Maria Silva
Pedro Costa
Ana Ferreira
```

---

## ▶️ Expected Output

```
Customer List
-------------

John Smith
Maria Silva
Pedro Costa
Ana Ferreira
```

---

## ⚙️ Compile (GNU COBOL)

```bash
cobc -x day05-read-file.cob
```

---

## ▶️ Run

```bash
./day05-read-file
```

---

## 🧠 What You Learned

* How COBOL reads sequential files
* Detecting End Of File (EOF)
* Basic file error handling using FILE STATUS
* Batch-style data processing

---

Part of the **30 Days of COBOL Challenge**.
