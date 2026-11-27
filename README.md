# Payment Operations & Merchant Analytics

A SQL-based business intelligence project designed to analyze payment transactions, merchant performance, payment failures, settlement delays, and refund operations.

This project simulates a payment operations environment where business and operations teams need to investigate transaction issues, identify recurring failure patterns, monitor merchant performance, and generate actionable insights using SQL and Power BI.

## Project Overview

Payment processing companies handle large volumes of transactions across multiple merchants and payment methods. Monitoring transaction performance and identifying operational issues are essential for maintaining reliable payment services.

This project uses a relational PostgreSQL database and analytical SQL queries to investigate payment-related data and generate operational insights through an interactive Power BI dashboard.

## Business Objectives

- Monitor overall transaction performance and success rates.
- Identify merchants experiencing high transaction failure rates.
- Analyze common payment failure reasons.
- Identify successful transactions awaiting settlement.
- Monitor refund requests and processing delays.
- Analyze daily transaction trends and payment method performance.
- Identify high-value failed transactions requiring investigation.
- Present operational insights through interactive dashboards.

## Technology Stack

| Technology | Purpose |
|---|---|
| PostgreSQL | Relational database |
| SQL | Data analysis and investigation |
| Power BI | Interactive reporting and visualization |
| Git & GitHub | Version control and documentation |

## Database Schema

The project consists of four relational tables:

### 1. Merchants
Stores merchant information, business categories, locations, and account status.

### 2. Transactions
Stores transaction references, merchant IDs, payment methods, amounts, transaction statuses, failure reasons, and settlement information.

### 3. Payment Methods
Maintains supported payment methods such as UPI, credit cards, debit cards, and net banking.

### 4. Refunds
Stores refund requests, refund amounts, processing statuses, and timestamps.

### Entity Relationship Overview

```text
MERCHANTS
---------
merchant_id (PK)
merchant_name
business_category
city
merchant_status
       |
       | 1 : Many
       |
TRANSACTIONS
------------
transaction_id (PK)
transaction_reference
merchant_id (FK)
method_id (FK)
amount
transaction_status
failure_reason
settlement_status
transaction_time
settled_at
       |
       | 1 : Many
       |
REFUNDS
-------
refund_id (PK)
transaction_id (FK)
refund_amount
refund_status
requested_at
processed_at

PAYMENT_METHODS
---------------
method_id (PK)
method_name
       |
       | 1 : Many
       |
TRANSACTIONS
```

## SQL Analysis & Business Use Cases

The project includes SQL queries addressing the following operational scenarios:

| Analysis | Business Question |
|---|---|
| Transaction Performance | What percentage of transactions are successful or failed? |
| Merchant Analysis | Which merchants experience the highest failure rates? |
| Failure Analysis | What are the most common transaction failure reasons? |
| Settlement Monitoring | Which successful transactions are awaiting settlement? |
| Refund Analysis | How many refunds are processed, pending, or failed? |
| Transaction Trends | How does transaction performance change over time? |
| Payment Method Analysis | Which payment methods experience more failures? |
| High-Value Failures | Which failed transactions have a higher financial impact? |
| Refund Delays | Which refund requests have remained pending for more than 24 hours? |

## Key SQL Concepts Demonstrated

- INNER JOIN and LEFT JOIN
- GROUP BY and HAVING
- Aggregate functions
- CASE statements and conditional filtering
- Common Table Expressions (CTEs)
- Subqueries
- Date and timestamp operations
- NULL handling
- Window functions (additional analysis)
- Database indexing and query optimization
- Relational database design and foreign key constraints

## Power BI Dashboard

The Power BI dashboard provides an operational overview of payment processing performance.

### Dashboard Components

- Total transaction volume
- Successful, failed, and pending transactions
- Transaction success and failure rates
- Merchant-wise transaction performance
- Payment failure reason distribution
- Daily transaction trends
- Payment method performance
- Pending settlement monitoring
- Refund processing status

### Dashboard Preview

<!-- Add your dashboard screenshot here -->

![Payment Operations Dashboard](screenshots/dashboard.png)

**Live Dashboard:** [View Interactive Dashboard](ADD_YOUR_PUBLIC_POWER_BI_LINK_HERE)

## Repository Structure

```text
payment-operations-merchant-analytics/
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_insert_sample_data.sql
│   ├── 04_performance_indexes.sql
│   └── 05_business_analysis_queries.sql
│
├── dashboard/
│   └── payment_operations_dashboard.pbix
│
├── screenshots/
│   └── dashboard.png
│
└── README.md
```

## Getting Started

### Prerequisites

- PostgreSQL 14 or later
- pgAdmin or another PostgreSQL client
- Power BI Desktop (optional, for dashboard exploration)

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/YOUR_USERNAME/payment-operations-merchant-analytics.git
```

**2. Navigate to the project**

```bash
cd payment-operations-merchant-analytics
```

**3. Create the database**

Execute the database creation script in PostgreSQL.

**4. Create the database tables**

Run:

```text
sql/02_create_tables.sql
```

**5. Insert sample data**

Run:

```text
sql/03_insert_sample_data.sql
```

**6. Create performance indexes**

Run:

```text
sql/04_performance_indexes.sql
```

**7. Execute analytical queries**

Run:

```text
sql/05_business_analysis_queries.sql
```

**8. Explore the dashboard**

Open the Power BI file inside the `dashboard/` directory using Power BI Desktop.

## Key Insights

The analytical queries help operations teams:

- Identify merchants with recurring payment failures.
- Investigate failed transactions based on failure reasons.
- Monitor settlement delays and unresolved refunds.
- Prioritize high-value transaction issues.
- Compare payment method performance.
- Identify operational trends and potential areas for improvement.

## Future Enhancements

- Integrate larger synthetic transaction datasets.
- Develop automated daily transaction monitoring.
- Introduce SLA-based escalation reporting.
- Build additional merchant risk and anomaly detection metrics.
- Implement automated data refresh and reporting workflows.
- Add interactive merchant-level drill-down analysis.

## Disclaimer

This project is developed for educational and portfolio purposes using synthetic transaction and merchant data. It is not connected to any real payment processor, merchant account, banking infrastructure, or financial institution.

All merchant names, transaction references, and payment records are fictional.

## Author

**Sara Saeed Shaikh**

Computer Engineering | Business Operations Analytics | Technical Support | SQL & Power BI

[LinkedIn](YOUR_LINKEDIN_URL) | [GitHub](YOUR_GITHUB_URL) | [Portfolio](YOUR_PORTFOLIO_URL)
