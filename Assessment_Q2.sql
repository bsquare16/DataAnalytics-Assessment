-- Question 2: Transaction Frequency Analysis
-- Calculate average number of transactions per customer per month and categorize them
-- into High, Medium, and Low frequency.

WITH monthly_transactions AS (
    SELECT 
        owner_id,
        YEAR(transaction_date) AS txn_year,
        MONTH(transaction_date) AS txn_month,
        COUNT(*) AS transactions_in_month
    FROM savings_savingsaccount
    GROUP BY owner_id, YEAR(transaction_date), MONTH(transaction_date)
),
avg_transactions AS (
    SELECT 
        owner_id,
        AVG(transactions_in_month) AS avg_transactions_per_month
    FROM monthly_transactions
    GROUP BY owner_id
)
SELECT
    CASE 
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 2) AS avg_transactions_per_month
FROM avg_transactions
GROUP BY frequency_category
ORDER BY 
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        WHEN 'Low Frequency' THEN 3
    END;
