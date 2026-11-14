# Bakery Relational Database

A MySQL database for a bakery, designed and implemented for the Database Design & Development course at Al Hussein Technical University (HTU).

## Overview

The `bakery` database tracks daily operations (orders, order details, payments) and master data (customers, employees, products).

**Tables:** `customer`, `employee`, `product`, `c_order`, `orderdetails`, `payment`

## Contents

| Path | Description |
|---|---|
| `sql/bakery.sql` | Schema (`CREATE TABLE`) and sample data; import into MySQL |
| `docs/Technical-Document.docx` | Technical documentation: design and implementation |
| `docs/User-Document.docx` | User document: scenario, requirements and usage |

## Run

```bash
mysql -u root -p < sql/bakery.sql
```

## Tech

SQL, MySQL, phpMyAdmin

## Author

Leen Shannak - Computer Science student, HTU
