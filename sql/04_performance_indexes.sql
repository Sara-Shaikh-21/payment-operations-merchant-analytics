
-- ==========================================
-- FILE: 04_performance_indexes.sql
-- ==========================================

CREATE INDEX idx_transactions_merchant
ON transactions(merchant_id);

CREATE INDEX idx_transactions_status
ON transactions(transaction_status);

CREATE INDEX idx_transactions_date
ON transactions(transaction_time);

CREATE INDEX idx_transactions_method
ON transactions(method_id);

CREATE INDEX idx_transactions_settlement
ON transactions(settlement_status);

CREATE INDEX idx_refunds_status
ON refunds(refund_status);

CREATE INDEX idx_refunds_requested_at
ON refunds(requested_at);

-- Verify indexes
SELECT
    tablename,
    indexname
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;
