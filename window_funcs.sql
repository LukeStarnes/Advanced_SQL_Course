--For each salesperson, rank the car models they've sold the most
SELECT employee.firstname, employee.lastname, model.model, count(*) AS modelSold, 
rank() OVER (PARTITION BY sales.employeeId ORDER BY count(model) desc) AS Rank
FROM employee
JOIN sales
ON employee.employeeId = sales.employeeId
JOIN inventory
on sales.inventoryId = inventory.inventoryId
JOIN model
on inventory.modelId = model.modelId
GROUP BY employee.firstname, employee.lastname, model.model

-- Create a report showing sales per month and an annual total
with t1 as (
SELECT strftime('%Y', soldDate) AS soldYear, 
strftime('%m', soldDate) AS soldMonth,
SUM(salesAmount) AS salesAmount
FROM sales
GROUP BY soldYear, soldMonth
)
SELECT soldYear, soldMonth, salesAmount,
SUM(salesAmount) OVER (
PARTITION BY soldYear 
ORDER BY soldYear, soldMonth) AS AnnualSales_RunningTotal
FROM cte_sales
ORDER BY soldYear, soldMonth

--Display the number of cars sold this month and last month
SELECT strftime('%Y-%m', soldDate) AS month,
COUNT(*) AS cars_sold,
(SELECT COUNT(*)FROM sales as prev
WHERE strftime('%Y-%m', prev.soldDate) = strftime('%Y-%m', sales.soldDate, '-1 month')
) AS cars_sold_previous_month
FROM sales
GROUP BY month
ORDER BY month;
