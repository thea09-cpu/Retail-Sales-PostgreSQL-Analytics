# Retail-Sales-PostgreSQL-Analytics

An end-to-end PostgreSQL database project built using the Sample Superstore dataset.

This project demonstrates how raw retail sales data can be transformed into a well-designed relational database capable of supporting business reporting and analytics.

The project covers the complete workflow from raw data ingestion and quality validation to database normalization, analytical SQL, views, and performance optimization.

---

# Project Overview

The original dataset is provided as a single CSV file.

Instead of querying the flat file directly, the data is imported into PostgreSQL, validated, normalized into relational tables, and analyzed using SQL.

The project follows a workflow similar to what is commonly used in analytics and data engineering.

```
CSV
   ↓
Staging
   ↓
Data Quality Checks
   ↓
Normalized Database
   ↓
Analysis
   ↓
Views
   ↓
Indexes
```

---

# Objectives

- Import raw CSV data into PostgreSQL
- Validate and clean the dataset
- Design a normalized relational database
- Build analytical SQL queries
- Create reusable SQL Views
- Improve query performance using indexes
- Produce business insights

---

# Database Architecture

The project is organized into multiple layers.

```
Raw CSV
      ↓
staging.raw_superstore
      ↓
Core Tables
      ↓
Views
      ↓
Business Analysis
```

The normalized database consists of:

- Customers
- Products
- Orders
- Locations
- Sales

An Entity Relationship Diagram (ERD) is included in the project.

---

# Repository Structure

```
Retail-Sales-PostgreSQL/

├── data/
├── sql/
├── diagrams/
├── screenshots/
└── README.md
```

---

# SQL Workflow

The SQL scripts are organized sequentially.

| Step | Description |
|-------|-------------|
|01|Verify Connection|
|02|Create Schemas|
|03|Create Staging Table|
|04|Import Raw Data|
|05|Data Quality Checks|
|06|Preview Raw Data|
|07|Create Core Tables|
|08|Load Core Tables|
|09|Verify Core Load|
|10|Business Analysis|
|11|Create Views|
|12|Test Views|
|13|Create Indexes|

---

# Features

✔ Relational database design

✔ Data normalization

✔ Staging layer

✔ Data quality validation

✔ Business analysis

✔ SQL Views

✔ Performance optimization using indexes

✔ Entity Relationship Diagram (ERD)

---

# Business Questions Answered

The project answers questions such as:

- Which region generates the highest profit?
- Which products generate the highest losses?
- Which customers contribute the most revenue?
- How do discounts impact profitability?
- Which categories perform best?
- What are the monthly sales trends?
- Which regions should the business prioritize?

---

# Sample Outputs

The project includes screenshots for:

- Overall Business Performance
- Missing Value Checks
- Category Performance
- Regional Performance
- Customer Performance
- Discount Analysis
- Monthly Performance
- Loss-Making Products
- Top Customers
- SQL Views
- ER Diagram

---

# Technologies Used

- PostgreSQL
- pgAdmin 4
- SQL
- Relational Database Design
- Git
- GitHub

---

# Skills Demonstrated

- SQL
- PostgreSQL
- Data Modeling
- Database Design
- Normalization
- ETL Concepts
- Data Quality Validation
- Analytical SQL
- Views
- Indexes
- Query Optimization

---

# Future Improvements

Potential extensions include:

- Stored Procedures
- Triggers
- Materialized Views
- Power BI Dashboard
- Python ETL Pipeline
- Docker Deployment

---

# Dataset

Sample Superstore Dataset

Used for educational and portfolio purposes.

---

# Author

**Cynthia Mueni**

Aspiring Data Scientist | Data Engineer

GitHub: https://github.com/thea09-cpu

---

# License

This project is intended for educational and portfolio purposes.
