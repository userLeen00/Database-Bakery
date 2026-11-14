# Bakery Relational Database

A MySQL database for a bakery, designed and implemented for the Database Design & Development course at Al Hussein Technical University (HTU).

## Overview

The `bakery` database tracks daily operations (orders, order details, payments) and master data (customers, employees, products), with views for reporting and stored procedures for common operations.

### Tables
`customer`, `employee`, `product`, `c_order`, `orderdetails`, `payment`

Integrity is enforced with primary and foreign keys (`ON DELETE` / `ON UPDATE` rules), `UNIQUE` constraints on phone, email and product name, `CHECK` constraints (price, quantity and salary must be positive), and `ENUM` columns for order status and employee role.

### Views
| View | Purpose |
|---|---|
| `v_order_total` | Total value of each order with customer and employee |
| `v_productsinorder` | Products and quantities per order |
| `v_product_sales_total` | Units sold and revenue per product |
| `v_frequent_customers` | Customers with 2 or more orders |
| `v_unpaid_orders` | Orders still pending |

### Stored procedures
`proc_AddCustomer`, `proc_AddEmployee`, `proc_CreateOrderPending`, `proc_AddOrderItem`, `sp_complete_order`, `sp_MonthlyProfit`

## Contents

| Path | Description |
|---|---|
| `sql/bakery.sql` | Full dump: schema, sample data, views and procedures |
| `sql/sample-queries.sql` | Example `ALTER TABLE` and a join/aggregate query (orders per customer) |
| `docs/Technical-Document.docx` | Technical documentation: design and implementation |
| `docs/User-Document.docx` | User document: scenario, requirements and usage |

## Run

Requires MySQL 8.

```bash
mysql -u root -p < sql/bakery.sql
```

The sample data uses fictional names and `example.com` emails.

## Tech

SQL, MySQL 8, phpMyAdmin

## Author

Leen Shannak - Computer Science student, HTU
