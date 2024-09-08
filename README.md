# Sales Order Analysis SQL Project 001

## Project Overview

**Project Title**: Sales Order - Case Study  
**Level**: Beginner  
**Database**: `sales_order`


## Project Structure

### 1. Database Setup

```sql
CREATE DATABASE sales_order;


drop table if exists products;
create table products
(
	id			int generated always as identity primary key,
	name			varchar(100),
	price			float,
	release_date 		date
);
insert into products values(default,'iPhone 15', 800, to_date('22-08-2023','dd-mm-yyyy'));
insert into products values(default,'Macbook Pro', 2100, to_date('12-10-2022','dd-mm-yyyy'));
insert into products values(default,'Apple Watch 9', 550, to_date('04-09-2022','dd-mm-yyyy'));
insert into products values(default,'iPad', 400, to_date('25-08-2020','dd-mm-yyyy'));
insert into products values(default,'AirPods', 420, to_date('30-03-2024','dd-mm-yyyy'));


drop table if exists customers;
create table customers
(
    id         int generated always as identity primary key,
    name       varchar(100),
    email      varchar(30)
);
insert into customers values(default,'Meghan Harley', 'mharley@demo.com');
insert into customers values(default,'Rosa Chan', 'rchan@demo.com');
insert into customers values(default,'Logan Short', 'lshort@demo.com');
insert into customers values(default,'Zaria Duke', 'zduke@demo.com');


drop table if exists employees;
create table employees
(
    id         int generated always as identity primary key,
    name       varchar(100)
);
insert into employees values(default,'Nina Kumari');
insert into employees values(default,'Abrar Khan');
insert into employees values(default,'Irene Costa');



drop table if exists sales_order;
create table sales_order
(
	order_id		int generated always as identity primary key,
	order_date		date,
	quantity		int,
	prod_id			int references products(id),
	status			varchar(20),
	customer_id		int references customers(id),
	emp_id			int,
	constraint fk_so_emp foreign key (emp_id) references employees(id)
);
insert into sales_order values(default,to_date('01-01-2024','dd-mm-yyyy'),2,1,'Completed',1,1);
insert into sales_order values(default,to_date('01-01-2024','dd-mm-yyyy'),3,1,'Pending',2,2);
insert into sales_order values(default,to_date('02-01-2024','dd-mm-yyyy'),3,2,'Completed',3,2);
insert into sales_order values(default,to_date('03-01-2024','dd-mm-yyyy'),3,3,'Completed',3,2);
insert into sales_order values(default,to_date('04-01-2024','dd-mm-yyyy'),1,1,'Completed',3,2);
insert into sales_order values(default,to_date('04-01-2024','dd-mm-yyyy'),1,3,'Completed',2,1);
insert into sales_order values(default,to_date('04-01-2024','dd-mm-yyyy'),1,2,'On Hold',2,1);
insert into sales_order values(default,to_date('05-01-2024','dd-mm-yyyy'),4,2,'Rejected',1,2);
insert into sales_order values(default,to_date('06-01-2024','dd-mm-yyyy'),5,5,'Completed',1,2);
insert into sales_order values(default,to_date('06-01-2024','dd-mm-yyyy'),1,1,'Cancelled',1,1);
```


Select SQL

```sql
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM sales_order;
```

### 2. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. Identify the total no of products sold

```sql
select sum(quantity) as total_sold_products
from sales_order;
```


2. Other than Completed, display the available delivery status's.

```sql
SELECT status
FROM sales_order
WHERE status NOT IN ('Completed', 'completed');

SELECT status
FROM sales_order
WHERE LOWER(status) <> 'completed';
```


3. Display the order id, order_date and product_name for all the completed orders.

```sql
SELECT order_id, order_date, name
FROM sales_order so
INNER JOIN products p ON so.prod_id = p.id
WHERE LOWER(status) = 'completed'
```


4. Sort the above query to show the earliest orders at the top. Also display the customer who purchased these orders.

```sql
SELECT order_id, order_date, p.name AS product_name, c.name AS customer_name
FROM sales_order so
INNER JOIN products p ON so.prod_id = p.id
INNER JOIN customers c ON so.customer_id = c.id
WHERE LOWER(status) = 'completed'
ORDER BY order_date
```


5. Display the total no of orders corresponding to each delivery status

```sql
SELECT status, COUNT(*) AS total_order
FROM sales_order
GROUP BY status
```


6. For orders purchasing more than 1 item, how many are still not completed?

```sql
SELECT COUNT(*)
FROM sales_order
WHERE quantity > 1
AND LOWER(status) <> 'completed'
```


7. Find the total no of orders corresponding to each delivery status by ignoring the case in delivery status.Status with highest no of orders should be at the top.

```sql
SELECT LOWER(status) as status, COUNT(*) AS total_order
FROM sales_order
GROUP BY LOWER(status)
ORDER BY total_order DESC

SELECT updated_status, COUNT(*) AS total_order
FROM (SELECT status, CASE 
	WHEN status = 'completed' THEN
		'Completed'
	ELSE
		status
END AS updated_status
FROM sales_order)
GROUP BY updated_status
ORDER BY total_order DESC
```


8. Write a query to identify the total products purchased by each customer

```sql
SELECT c.name as customer_name, SUM(so.quantity) AS total_purchase_product
FROM sales_order so
INNER JOIN customers c ON so.customer_id = c.id
GROUP BY c.name
```


9. Display the total sales and average sales done for each day.

```sql
SELECT order_date, SUM(quantity * price), AVG(quantity *price)
FROM sales_order so
JOIN products p ON p.id = so.prod_id
GROUP BY order_date
ORDER BY order_date
```


10. Display the customer name, employee name and total sale amount of all orders which are either on hold or  pending

```sql
SELECT c.name as customer_name, e.name as employee_name, SUM(so.quantity * p.price), so.status
FROM sales_order so
JOIN customers c ON so.customer_id = c.id
JOIN employees e ON so.emp_id = e.id
JOIN products p ON so.prod_id = p.id
WHERE status IN ('Pending', 'On Hold')
GROUP BY c.name, e.name
```


11. Fetch all the orders which were neither completed/pending or were handled by the employee Abrar. Display employee name and all details of order.

```sql
SELECT e.name as employee_name, so.*
FROM sales_order so
JOIN employees e ON e.id = so.emp_id
WHERE LOWER(status) NOT IN ('completed', 'pending')
OR LOWER(e.name) LIKE '%abrar%'
```


12. Fetch the orders which cost more than 2000 but did not include the macbook pro. Print the total sale amount as well.

```sql
SELECT so.*, p.name, (quantity * price) as total_Sale
FROM sales_order so
JOIN products p ON so.prod_id = p.id
WHERE quantity * price > '2000'
AND LOWER(p.name) NOT LIKE '%macbook%'
```


13. Identify the customers who have not purchased any product yet

```sql
SELECT * from customers
WHERE id NOT IN (SELECT DISTINCT customer_id
FROM sales_order)
									
SELECT c.*
FROM customers c
LEFT JOIN sales_order so ON so.customer_id = c.id
WHERE order_id ISNULL
```


14. Write a query to identify the total products purchased by each customer.Return all customers irrespective of wether they have made a purchase or not. Sort the result with highest no of orders at the top.

```sql
SELECT c.name, COALESCE(SUM(quantity), 0) AS total_products_purchased
FROM sales_order so
RIGHT JOIN customers c ON so.customer_id = c.id
GROUP BY c.name
ORDER BY total_products_purchased DESC
```


15. Corresponding to each employee, display the total sales they made of all the completed orders. Display total sales as 0 if an employee made no sales yet.

 ```sql
SELECT e.name,  COALESCE(SUM(quantity * price),0) AS total_sales
FROM sales_order so
JOIN products p ON so.prod_id = p.id
RIGHT JOIN employees e ON so.emp_id = e.id
AND LOWER(status) = 'completed'
GROUP BY e.name
```


16. Re-write the above query so as to display the total sales made by each employee corresponding to each customer. If an employee has not served a customer yet then display "-" under the customer.

```sql
SELECT e.name, COALESCE(c.name, '-'), COALESCE(SUM(quantity * price),0) AS total_sales
FROM sales_order so
JOIN products p ON so.prod_id = p.id
JOIN customers c ON so.customer_id = c.id
RIGHT JOIN employees e ON so.emp_id = e.id
AND LOWER(status) = 'completed'
GROUP BY e.name, c.name
ORDER BY 1,2
```


17. Re-write above query so as to display only those records where the total sales is above 1000

```sql
SELECT e.name, COALESCE(c.name, '-'), COALESCE(SUM(quantity * price),0) AS total_sales
FROM sales_order so
JOIN products p ON so.prod_id = p.id
JOIN customers c ON so.customer_id = c.id
RIGHT JOIN employees e ON so.emp_id = e.id
AND LOWER(status) = 'completed'
GROUP BY e.name, c.name
HAVING COALESCE(SUM(quantity * price),0) > '1000'
ORDER BY 1,2
```


18. Identify employees who have served more than 2 customer.

```sql
SELECT e.name as employee, COUNT(DISTINCT c.name) as customer
FROM sales_order so
JOIN customers c ON so.customer_id = c.id
JOIN employees e ON so.emp_id = e.id
GROUP BY e.name
HAVING COUNT(DISTINCT c.name) > 2
ORDER BY 1
```


19. Identify the customers who have purchased more than 5 products

```sql
SELECT c.name AS customer, SUM(quantity) as total_products
FROM  sales_order so
JOIN customers c ON so.customer_id = c.id
GROUP BY c.name
HAVING SUM(quantity) > 5
```


20. Identify customers whose average purchase cost exceeds the average sale of all the orders

```sql
SELECT c.name, AVG(quantity * price)
FROM sales_order so
JOIN products p ON so.prod_id = p.id
JOIN customers c ON so.customer_id = c.id
GROUP BY c.name
HAVING AVG(quantity * price) > (SELECT AVG(quantity * price)
                                FROM sales_order so
                                JOIN products p ON so.prod_id = p.id)
```


## Author - techTFQ


Thank you for your support, and I look forward to connecting with you!
