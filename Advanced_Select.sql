-- Create a report showing total sales per year using a CTE
with cte AS 
(SELECT strftime('%Y',soldDate) AS soldYear, salesAmount
FROM sales)
SELECT soldYear, format(sum(salesAmount),2,'en_US') AS totalSales
FROM cte 
GROUP BY soldYear

--Display the sum of sales for each employee by month in 2021
SELECT employee.firstName,employee.lastName,
sum(CASE WHEN strftime('%m', sales.soldDate) = '01' 
THEN sales.salesAmount END)AS janSales,
sum(CASE WHEN strftime('%m', sales.soldDate) = '02' 
THEN sales.salesAmount END)AS febSales,
sum(CASE WHEN strftime('%m', sales.soldDate) = '03' 
THEN sales.salesAmount END)AS marSales,
sum(CASE WHEN strftime('%m', sales.soldDate) = '04' 
THEN sales.salesAmount END)AS aprSales,
sum(CASE WHEN strftime('%m', sales.soldDate) = '05' 
THEN sales.salesAmount END)AS maySales,
sum(CASE WHEN strftime('%m', sales.soldDate) = '06' 
THEN sales.salesAmount END)AS junSales,
sum(CASE WHEN strftime('%m', sales.soldDate) = '07' 
THEN sales.salesAmount END)AS julSales,
sum(CASE WHEN strftime('%m', sales.soldDate) = '08' 
THEN sales.salesAmount END)AS augSales,
sum(CASE WHEN strftime('%m', sales.soldDate) = '09' 
THEN sales.salesAmount END)AS sepSales,
sum(CASE WHEN strftime('%m', sales.soldDate) = '10' 
THEN sales.salesAmount END)AS octSales,
sum(CASE WHEN strftime('%m', sales.soldDate) = '11' 
THEN sales.salesAmount END)AS novSales,
sum(CASE WHEN strftime('%m', sales.soldDate) = '12' 
THEN sales.salesAmount END)AS decSales
FROM employee
LEFT JOIN sales
ON employee.employeeId = sales.employeeId
WHERE strftime('%Y', sales.soldDate) = '2021'
GROUP BY employee.firstName,employee.lastName

--Find all sales where the car purchased was electric using a subquery
SELECT sales.salesId,sales.soldDate,sales.salesAmount, inventory.modelId
FROM sales
JOIN inventory
ON sales.inventoryId = inventory.inventoryId
where modelId IN 
(SELECT modelId 
FROM model 
WHERE EngineType = 'Electric')
