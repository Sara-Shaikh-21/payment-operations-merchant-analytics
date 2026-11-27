
-- ==========================================
-- FILE: 03_insert_sample_data.sql
-- ==========================================

-- Merchants
INSERT INTO merchants
(merchant_name, business_category, city)
VALUES
('ABC Electronics', 'Electronics', 'Pune'),
('Fashion Hub', 'Retail', 'Mumbai'),
('Fresh Mart', 'Grocery', 'Pune'),
('Tech World', 'Electronics', 'Bangalore'),
('Food Express', 'Food', 'Mumbai');

-- Payment Methods
INSERT INTO payment_methods (method_name)
VALUES
('UPI'),
('Credit Card'),
('Debit Card'),
('Net Banking');

-- Transactions
INSERT INTO transactions
(transaction_reference, merchant_id, method_id,
 amount, transaction_status, failure_reason,
 settlement_status, transaction_time, settled_at)
VALUES
('TXN1001', 1, 1, 2500, 'SUCCESS', NULL, 'SETTLED',
 '2026-11-20 10:00', '2026-11-20 12:00'),

('TXN1002', 1, 2, 4500, 'FAILED', 'Insufficient Funds', 'PENDING',
 '2026-11-20 11:00', NULL),

('TXN1003', 2, 1, 1200, 'SUCCESS', NULL, 'SETTLED',
 '2026-11-20 12:00', '2026-11-20 14:00'),

('TXN1004', 2, 3, 3500, 'FAILED', 'Bank Timeout', 'PENDING',
 '2026-11-20 13:00', NULL),

('TXN1005', 3, 1, 800, 'SUCCESS', NULL, 'PENDING',
 '2026-11-21 09:00', NULL),

('TXN1006', 3, 2, 1500, 'FAILED', 'Payment Gateway Error', 'PENDING',
 '2026-11-21 10:00', NULL),

('TXN1007', 4, 4, 5000, 'SUCCESS', NULL, 'SETTLED',
 '2026-11-21 11:00', '2026-11-21 13:00'),

('TXN1008', 4, 1, 2200, 'SUCCESS', NULL, 'SETTLED',
 '2026-11-21 12:00', '2026-11-21 14:00'),

('TXN1009', 5, 2, 900, 'FAILED', 'Insufficient Funds', 'PENDING',
 '2026-11-22 10:00', NULL),

('TXN1010', 5, 3, 1800, 'SUCCESS', NULL, 'PENDING',
 '2026-11-22 11:00', NULL),

('TXN1011', 1, 1, 3200, 'SUCCESS', NULL, 'SETTLED',
 '2026-11-22 12:00', '2026-11-22 14:00'),

('TXN1012', 2, 4, 2700, 'PENDING', NULL, 'PENDING',
 '2026-11-22 13:00', NULL),

('TXN1013', 3, 2, 4000, 'FAILED', 'Bank Timeout', 'PENDING',
 '2026-11-23 09:00', NULL),

('TXN1014', 4, 1, 6000, 'SUCCESS', NULL, 'SETTLED',
 '2026-11-23 10:00', '2026-11-23 12:00'),

('TXN1015', 5, 3, 1100, 'SUCCESS', NULL, 'PENDING',
 '2026-11-23 11:00', NULL);

-- Refunds
INSERT INTO refunds
(transaction_id, refund_amount, refund_status,
 requested_at, processed_at)
VALUES
(1, 500, 'PROCESSED', '2026-11-21 10:00', '2026-11-21 11:00'),
(3, 1200, 'PROCESSED', '2026-11-21 14:00', '2026-11-21 15:00'),
(5, 800, 'PENDING', '2026-11-22 10:00', NULL),
(8, 1000, 'FAILED', '2026-11-22 15:00', NULL),
(11, 700, 'PENDING', '2026-11-23 13:00', NULL);
