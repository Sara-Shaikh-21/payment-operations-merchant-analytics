
-- ==========================================
-- FILE: 05_business_analysis_queries.sql
-- ==========================================

-- 1. OVERALL TRANSACTION PERFORMANCE

SELECT
    COUNT(*) AS total_transactions,

    COUNT(*) FILTER (
        WHERE transaction_status = 'SUCCESS'
    ) AS successful_transactions,

    COUNT(*) FILTER (
        WHERE transaction_status = 'FAILED'
    ) AS failed_transactions,

    COUNT(*) FILTER (
        WHERE transaction_status = 'PENDING'
    ) AS pending_transactions,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE transaction_status = 'SUCCESS'
        ) /
        NULLIF(
            COUNT(*) FILTER (
                WHERE transaction_status IN ('SUCCESS', 'FAILED')
            ), 0
        ),
        2
    ) AS success_rate_percentage

FROM transactions;


-- 2. MERCHANT-WISE PERFORMANCE

SELECT
    m.merchant_name,
    COUNT(t.transaction_id) AS total_transactions,

    COUNT(t.transaction_id) FILTER (
        WHERE t.transaction_status = 'SUCCESS'
    ) AS successful_transactions,

    COUNT(t.transaction_id) FILTER (
        WHERE t.transaction_status = 'FAILED'
    ) AS failed_transactions,

    ROUND(
        100.0 * COUNT(t.transaction_id) FILTER (
            WHERE t.transaction_status = 'FAILED'
        ) /
        NULLIF(
            COUNT(t.transaction_id) FILTER (
                WHERE t.transaction_status IN ('SUCCESS', 'FAILED')
            ), 0
        ),
        2
    ) AS failure_rate

FROM merchants m

LEFT JOIN transactions t
    ON m.merchant_id = t.merchant_id

GROUP BY m.merchant_id, m.merchant_name
ORDER BY failure_rate DESC NULLS LAST;


-- 3. PAYMENT FAILURE ANALYSIS

SELECT
    failure_reason,
    COUNT(*) AS failure_count,
    SUM(amount) AS total_failed_amount

FROM transactions

WHERE transaction_status = 'FAILED'

GROUP BY failure_reason
ORDER BY failure_count DESC;


-- 4. PENDING SETTLEMENT ANALYSIS

SELECT
    t.transaction_reference,
    m.merchant_name,
    t.amount,
    t.transaction_time,
    t.settlement_status

FROM transactions t

JOIN merchants m
    ON t.merchant_id = m.merchant_id

WHERE t.transaction_status = 'SUCCESS'
AND t.settlement_status = 'PENDING'

ORDER BY t.transaction_time;


-- 5. REFUND ANALYSIS

SELECT
    refund_status,
    COUNT(*) AS total_refunds,
    SUM(refund_amount) AS total_refund_amount

FROM refunds

GROUP BY refund_status
ORDER BY total_refunds DESC;


-- 6. DAILY TRANSACTION TRENDS

SELECT
    DATE(transaction_time) AS transaction_date,

    COUNT(*) AS total_transactions,

    COUNT(*) FILTER (
        WHERE transaction_status = 'SUCCESS'
    ) AS successful_transactions,

    COUNT(*) FILTER (
        WHERE transaction_status = 'FAILED'
    ) AS failed_transactions,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE transaction_status = 'FAILED'
        ) /
        NULLIF(
            COUNT(*) FILTER (
                WHERE transaction_status IN ('SUCCESS', 'FAILED')
            ), 0
        ),
        2
    ) AS failure_rate

FROM transactions

GROUP BY DATE(transaction_time)
ORDER BY transaction_date;


-- 7. PAYMENT METHOD PERFORMANCE

SELECT
    pm.method_name,

    COUNT(t.transaction_id) AS total_transactions,

    COUNT(t.transaction_id) FILTER (
        WHERE t.transaction_status = 'SUCCESS'
    ) AS successful_transactions,

    COUNT(t.transaction_id) FILTER (
        WHERE t.transaction_status = 'FAILED'
    ) AS failed_transactions,

    ROUND(
        100.0 * COUNT(t.transaction_id) FILTER (
            WHERE t.transaction_status = 'FAILED'
        ) /
        NULLIF(
            COUNT(t.transaction_id) FILTER (
                WHERE t.transaction_status IN ('SUCCESS', 'FAILED')
            ), 0
        ),
        2
    ) AS failure_percentage

FROM payment_methods pm

LEFT JOIN transactions t
    ON pm.method_id = t.method_id

GROUP BY pm.method_id, pm.method_name
ORDER BY failure_percentage DESC NULLS LAST;


-- 8. HIGH-VALUE FAILED TRANSACTIONS

SELECT
    t.transaction_reference,
    m.merchant_name,
    t.amount,
    t.failure_reason,
    t.transaction_time

FROM transactions t

JOIN merchants m
    ON t.merchant_id = m.merchant_id

WHERE t.transaction_status = 'FAILED'
AND t.amount >= 2000

ORDER BY t.amount DESC;


-- 9. REFUNDS PENDING FOR MORE THAN 24 HOURS

SELECT
    r.refund_id,
    t.transaction_reference,
    m.merchant_name,
    r.refund_amount,
    r.requested_at,

    ROUND(
        (
            EXTRACT(
                EPOCH FROM (
                    CURRENT_TIMESTAMP - r.requested_at
                )
            ) / 3600
        )::NUMERIC,
        2
    ) AS pending_hours

FROM refunds r

JOIN transactions t
    ON r.transaction_id = t.transaction_id

JOIN merchants m
    ON t.merchant_id = m.merchant_id

WHERE r.refund_status = 'PENDING'
AND r.requested_at <
    CURRENT_TIMESTAMP - INTERVAL '24 hours'

ORDER BY r.requested_at;


-- 10. TRANSACTION DETAILS FOR OPERATIONAL INVESTIGATION

SELECT
    t.transaction_reference,
    m.merchant_name,
    pm.method_name,
    t.amount,
    t.transaction_status,
    t.failure_reason,
    t.settlement_status,
    t.transaction_time

FROM transactions t

JOIN merchants m
    ON t.merchant_id = m.merchant_id

JOIN payment_methods pm
    ON t.method_id = pm.method_id

ORDER BY t.transaction_time DESC;
