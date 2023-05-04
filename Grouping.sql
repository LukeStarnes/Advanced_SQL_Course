--How many cars have been sold per employee?
SELECT employee.employeeId, employee.firstname, employee.lastname, count(*) as carsSold
FROM employee
INNER JOIN sales
ON employee.employeeID = sales.employeeID
GROUP BY employee.employeeId, employee.firstname, employee.lastname
ORDER BY carsSold DESC

-- produce a report that lists the least and most expensive
-- cars sold  in 2023
SELECT employee.firstName, employee.lastName,
min(sales.salesAmount), max(sales.salesAmount)
FROM employee
INNER JOIN sales
ON employee.employeeId = sales.employeeId
WHERE strftime('%Y', soldDate) = '2023'
GROUP BY employee.firstName, employee.lastName

--Get a list of employees who have made more than 5 sales in 2023
SELECT employee.firstName,employee.lastName,count(*) AS number_of_sales
FROM employee
INNER JOIN sales
ON employee.employeeId = sales.employeeId
WHERE strftime('%Y', soldDate) = '2023'
GROUP BY employee.firstName,employee.lastName
HAVING number_of_sales > 5
