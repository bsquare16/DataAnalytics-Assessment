# DataAnalytics-Assessment

## Per-Question Explanations

### Question 1:
Identified customers who have both at least one funded savings plan and one funded investment plan by joining the users, plans, and savings accounts tables. Aggregated counts of each plan type and total deposits were calculated and converted from kobo to the main currency unit.

### Question 2:
Calculated the number of transactions per customer per month, averaged across months, then categorized customers into frequency groups based on their average transactions per month.

### Question 3:
Flagged plans that are active (not deleted or archived) but have had no transactions in the last 365 days by comparing the last transaction date per plan.

### Question 4:
Calculated customer tenure in months from signup date, counted total transactions, and estimated CLV using the formula provided. Assumed profit per transaction as 0.1% of the average transaction value.

## Challenges
- Handling NULL values in names required using COALESCE with concatenation of first and last names.
- Amount fields are in kobo; conversions were necessary to present data correctly.
- Ensuring accurate time intervals and handling cases where tenure might be zero.
- Joining multiple tables while keeping performance considerations in mind.