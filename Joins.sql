-- Q) Retrieve a list of employees and their immediate manager
-- Used a self join (a join in which a table is joined back to itself)
SELECT emp.firstName, emp.lastName,
mng.firstname AS manager_firstname, 
mng.lastName AS manager_lastname
FROM employee emp
INNER JOIN employee mng
ON emp.managerId = mng.employeeId

-- Q) Find salespeople who have zero sales
-- Left Join includes all the rows from the employee 
-- tables whether they have matchings sales data or not
SELECT DISTINCT employee.firstName, employee.lastName
FROM employee
LEFT JOIN sales 
ON employee.employeeId = sales.employeeId
WHERE employee.title = 'Sales Person'
AND salesID IS NULL

-- Get a list of all sales and all customers even if some
-- of the data has been removed (WITHOUT using full outer join)
SELECT sales.salesID, customer.customerID
FROM sales
INNER JOIN customer
ON sales.customerId = customer.customerId 
--
UNION
--
SELECT sales.salesID, customer.customerID
FROM sales
LEFT JOIN customer
ON sales.customerId = customer.customerId 
WHERE customer.customerId IS NULL
--
UNION
--
SELECT sales.salesID, customer.customerID
FROM customer
LEFT JOIN sales
ON sales.customerId = customer.customerId 
WHERE sales.salesId IS NULL
