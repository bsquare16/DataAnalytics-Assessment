-- Question 2: Transaction Frequency Analysis
-- Calculate average number of transactions per customer per month and categorize them
-- into High, Medium, and Low frequency.

WITH transactions_per_month AS (
    SELECT
        owner_id,
        DATE_FORMAT(transaction_date, '%Y-%m') AS year_month,
        COUNT(*) AS transactions_count
    FROM savings_savingsaccount
    GROUP BY owner_id, year_month
),
avg_transactions AS (
    SELECT
        owner_id,
        AVG(transactions_count) AS avg_transactions_per_month
    FROM transactions_per_month
    GROUP BY owner_id
)
SELECT
    CASE
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM avg_transactions
GROUP BY frequency_category
ORDER BY FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');