-- Question 4: Customer Lifetime Value (CLV) Estimation
-- Calculate tenure, total transactions, and estimated CLV for each customer.

WITH tenure_calc AS (
    SELECT
        id AS customer_id,
        COALESCE(CONCAT(first_name, ' ', last_name), name) AS name,
        TIMESTAMPDIFF(MONTH, date_joined, CURDATE()) AS tenure_months
    FROM users_customuser
),
transactions_count AS (
    SELECT
        owner_id AS customer_id,
        COUNT(*) AS total_transactions,
        AVG(confirmed_amount) AS avg_transaction_value
    FROM savings_savingsaccount
    GROUP BY owner_id
)
SELECT
    t.customer_id,
    t.name,
    t.tenure_months,
    COALESCE(tc.total_transactions, 0) AS total_transactions,
    ROUND(
        CASE
            WHEN t.tenure_months = 0 THEN 0
            ELSE (COALESCE(tc.total_transactions, 0) / t.tenure_months) * 12 * (COALESCE(tc.avg_transaction_value, 0) * 0.001)
        END, 2
    ) AS estimated_clv
FROM tenure_calc t
LEFT JOIN transactions_count tc ON t.customer_id = tc.customer_id
ORDER BY estimated_clv DESC;