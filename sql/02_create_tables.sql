
-- ==========================================
-- FILE: 02_create_tables.sql
-- ==========================================

-- 1. Merchants
CREATE TABLE merchants (
    merchant_id SERIAL PRIMARY KEY,
    merchant_name VARCHAR(100) NOT NULL,
    business_category VARCHAR(50),
    city VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    merchant_status VARCHAR(20) DEFAULT 'ACTIVE'
);

-- 2. Payment Methods
CREATE TABLE payment_methods (
    method_id SERIAL PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL
);

-- 3. Transactions
CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    transaction_reference VARCHAR(50) UNIQUE NOT NULL,
    merchant_id INT REFERENCES merchants(merchant_id),
    method_id INT REFERENCES payment_methods(method_id),
    amount DECIMAL(12,2) NOT NULL CHECK (amount >= 0),

    transaction_status VARCHAR(20)
        CHECK (transaction_status IN ('SUCCESS', 'FAILED', 'PENDING')),

    failure_reason VARCHAR(150),

    settlement_status VARCHAR(20)
        CHECK (settlement_status IN ('SETTLED', 'PENDING')),

    transaction_time TIMESTAMP NOT NULL,
    settled_at TIMESTAMP
);

-- 4. Refunds
CREATE TABLE refunds (
    refund_id SERIAL PRIMARY KEY,
    transaction_id INT REFERENCES transactions(transaction_id),
    refund_amount DECIMAL(12,2) NOT NULL CHECK (refund_amount > 0),

    refund_status VARCHAR(20)
        CHECK (refund_status IN ('PROCESSED', 'PENDING', 'FAILED')),

    requested_at TIMESTAMP NOT NULL,
    processed_at TIMESTAMP
);
