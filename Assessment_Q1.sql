-- Question 1: High-Value Customers with Multiple Products
-- Find customers who have at least one funded savings plan and one funded investment plan,
-- sorted by total deposits (confirmed_amount).

SELECT
    u.id AS owner_id,
    COALESCE(CONCAT(u.first_name, ' ', u.last_name), u.name) AS name,
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count,
    SUM(s.confirmed_amount) / 100 AS total_deposits -- convert kobo to main currency unit
FROM users_customuser u
JOIN plans_plan p ON p.owner_id = u.id
JOIN savings_savingsaccount s ON s.plan_id = p.id
WHERE s.confirmed_amount > 0
GROUP BY u.id, name
HAVING savings_count > 0 AND investment_count > 0
ORDER BY total_deposits DESC;