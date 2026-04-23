CREATE TABLE AMAZONORI(
ORDER ID PRIMARY KEY,
DATE DATE,
PROD VARCHAR(50),
CATEGORY VARCHAR(5)
PRICE INT,
QUANTITY INT,



)

SELECT * FROM PRODUCTS

SELECT * FROM AMAZONORI

Select * FROM ORDERS

SELECT * FROM CUSTOMERS

UPDATE customers
SET customer_id =
    CASE
        WHEN "Customer Name" = 'Michael Brown' THEN 1
        WHEN "Customer Name" = 'Daniel Harris' THEN 2
        WHEN "Customer Name" = 'Jane Smith' THEN 3
        WHEN "Customer Name" = 'Olivia Wilson' THEN 4
        WHEN "Customer Name" = 'Emma Clark' THEN 5
        WHEN "Customer Name" = 'John Doe' THEN 6
        WHEN "Customer Name" = 'Emily Johnson' THEN 7
        WHEN "Customer Name" = 'Chris White' THEN 8
        WHEN "Customer Name" = 'David Lee' THEN 9
        WHEN "Customer Name" = 'Sophia Miller' THEN 10
        ELSE customer_id
    END;

SELECT * FROM CUSTOMERS

SELECT * FROM AMAZONORI

CREATE TABLE payments AS
SELECT 
    "Order Id",
    "Total Sales",
    "Payment Method"
FROM AMAZONORI;

SELECT * FROM PAYMENTS

CREATE TABLE PRODUCTS AS SELECT
"Product",
"Category",
"Price"
FROM AMAZONORI;

SELECT * FROM PRODUCTS 

ALTER TABLE CUSTOMERS 
ADD COLUMN 'Total Sales'
FROM AMAZONORI

SELECT * FROM ORDERS


CREATE TABLE fact_table AS
SELECT
    o."Order Id",
    o."Date",
    c.customer_id,
    c."Customer Name",
    o."Prod",
    o."Category",
    o."Quantity",
    o."Total Sales",
    p."Payment Method",
    o."Status"
FROM orders AS o
INNER JOIN customers AS c
    ON o."Customer Name" = c."Customer Name"
INNER JOIN payments AS p
    ON o."Order Id" = p."Order Id";

SELECT * FROM ORDERS

SELECT * FROM PAYMENTS

CREATE TABLE FACT_TABLE AS SELECT 
	O."Order Id",
	O."Date",
	C."Customer Name",
	C."customer_id",
	P."Product",
	P."Category",
	P."Price",
	PY."Total Sales",
	PY."Payment Method"
FROM ORDERS AS O
JOIN CUSTOMERS AS C(
SELECT DISTINCT 
"Customer Name","customer_id" FROM CUSTOMERS) C
ON O."Customer Name"=C."Customer Name"

JOIN PAYMENTS AS PY(
SELECT DISTINCT "Order Id", "Total Sales"
) PY
ON O."Order Id"= PY."Order Id"

JOIN PRODUCTS AS P(SELECT DISTINCT "")
ON O."Product"=P."Product";

SELECT * FROM FACT_TABLE

	
CREATE TABLE FACT_TABLE AS
SELECT DISTINCT
    O."Order Id",
    O."Date",
    C."Customer Name",
    C."customer_id",
    P."Product",
    P."Category",
    P."Price",
    PY."Total Sales",
    PY."Payment Method"
FROM ORDERS O
JOIN (
    SELECT DISTINCT "Customer Name", "customer_id"
    FROM CUSTOMERS
) C
    ON O."Customer Name" = C."Customer Name"
JOIN (
    SELECT DISTINCT "Order Id", "Total Sales", "Payment Method"
    FROM PAYMENTS
) PY
    ON O."Order Id" = PY."Order Id"
JOIN (
    SELECT DISTINCT "Product", "Category", "Price"
    FROM PRODUCTS
) P
    ON O."Product" = P."Product";

DROP TABLE FACT_TABLE 
---CREATING THE FACT TABLE---
CREATE TABLE FACT_TABLE AS
SELECT DISTINCT
    O."Order Id",
    O."Date",
    C."Customer Name",
    C."customer_id",
    P."Product",
    P."Category",
    P."Price",
    PY."Total Sales",
    PY."Payment Method"
FROM ORDERS O
JOIN (
    SELECT DISTINCT "Customer Name", "customer_id"
    FROM CUSTOMERS
) C
    ON O."Customer Name" = C."Customer Name"
JOIN (
    SELECT DISTINCT "Order Id", "Total Sales", "Payment Method"
    FROM PAYMENTS
) PY
    ON O."Order Id" = PY."Order Id"
JOIN (
    SELECT DISTINCT "Product", "Category", "Price"
    FROM PRODUCTS
) P
    ON O."Product" = P."Product";

SELECT * FROM FACT_TABLE

---DISPLAYING ALL REC FROM THE FACT TABLE---
SELECT * FROM FACT_TABLE 
LIMIT 250;

SELECT * FROM FACT_TABLE

---RECORDS IN ASC ORDER ACC TO ORDER ID---
SELECT * FROM FACT_TABLE 
ORDER BY "Order Id" DESC

---CUSTOMER NAME IN UPPERCASE---
SELECT UPPER("Customer Name") FROM FACT_TABLE 

SELECT CONCAT("Customer Name", "Product") FROM FACT_TABLE

SELECT SUBSTRING ("Customer Name", 1,5) FROM FACT_TABLE

SELECT * FROM FACT_TABLE

---COUNTING TOTAL RECORD COUNT FROM FACT TABLE---
SELECT COUNT(*) AS TOTAL_REC
 FROM FACT_TABLE
 
---KPI---
---TOTAL REVENUE---
SELECT SUM("Total Sales") FROM FACT_TABLE

SELECT * FROM FACT_TABLE

---REVENUE BY CATEGORY---
SELECT "Category", SUM("Total Sales")
FROM FACT_TABLE
GROUP BY "Category"

---REVENUE BY PRODUCTS---
SELECT "Product", SUM("Total Sales")
FROM FACT_TABLE
GROUP BY "Product"

---REVENUE BY PAYMENT METHOD---
SELECT "Payment Method", SUM("Total Sales")
FROM FACT_TABLE 
GROUP BY "Payment Method"

---REVENUE BY PRODUCTS IN ASC---
SELECT "Product", SUM("Total Sales")
FROM FACT_TABLE
GROUP BY "Product"
ORDER BY "Product" ASC

---REVENUE BY CATEGORY IN DESC---

SELECT "Category", SUM("Total Sales")
FROM FACT_TABLE
GROUP BY "Category"
ORDER BY "Category" ASC

SELECT * FROM FACT_TABLE


---AVG ORDER VALUE BY CATEGORY--
SELECT "Category", AVG("Total Sales")
FROM FACT_TABLE
GROUP BY "Category"

---AVG ORDER VALUE BY PRODUCT---
SELECT "Product", AVG("Total Sales")
FROM FACT_TABLE
GROUP BY "Product"

---AVG ORDER VALUE BY PAYMENT METHOD---
SELECT "Payment Method", AVG("Total Sales")
FROM FACT_TABLE
GROUP BY "Payment Method"

SELECT * FROM FACT_TABLE

--REVENUE BY CUSTOMERS--
SELECT "Customer Name", SUM("Total Sales")
FROM FACT_TABLE 
GROUP BY "Customer Name"

--AVG ORDER VALUE BY CUSTOMER NAME---
SELECT "Customer Name", AVG("Total Sales")
FROM FACT_TABLE
GROUP BY "Customer Name"

---AVG ORDER VALUE BY CUSTOMER NAME IN ASC
SELECT "Customer Name", AVG("Total Sales") AS "AVG ORDER VALUE IN ASC"
FROM FACT_TABLE
GROUP BY "Customer Name"
ORDER BY "AVG ORDER VALUE IN ASC" ASC 

---MAX SINGLE ORDER VALUE CUTOMER WISE---
SELECT "Customer Name", MAX("Total Sales") AS "MAXIMIM SINGLE ORDER VALUE"
FROM FACT_TABLE
GROUP BY "Customer Name"

---MAX SINGLE ORDER VALUE CUSTOMER WISE IN ASC---
SELECT "Customer Name", MAX("Total Sales") AS "MAXIMIM SINGLE ORDER VALUE"
FROM FACT_TABLE
GROUP BY "Customer Name"
ORDER BY "MAXIMIM SINGLE ORDER VALUE" ASC;

---CUSTOMER SEGMENTATION---
SELECT 
    "Customer Name",
    SUM("Total Sales") AS total_spent,
    CASE
        WHEN SUM("Total Sales") >= 25000 THEN 'High Value'
        WHEN SUM("Total Sales") BETWEEN 20000 AND 24999 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM fact_table
GROUP BY "Customer Name"
ORDER BY total_spent DESC;



SELECT * FROM FACT_TABLE
---PRODUCT WISE SEGMENTATION--
SELECT "Product", SUM("Total Sales") AS PROD_WISE_SALES,
CASE 
	WHEN SUM("Total Sales") >= 20000 THEN 'HIGH VALUE'
	WHEN SUM("Total Sales") BETWEEN 10000 AND 19999 THEN 'MEDIUM VALUE'
	ELSE 'LOW VALUE'
	END AS PRODUCT_SEGMENT
FROM FACT_TABLE
GROUP BY "Product";

SELECT * FROM FACT_TABLE

---PATYMENT WISE SEGMENTATION---
SELECT "Payment Method", SUM("Total Sales") AS PAYMENT_METHODWISE_SALES,
CASE 
	WHEN SUM("Total Sales") >=60000 THEN 'HIGH VALUE'
	WHEN SUM("Total Sales") BETWEEN 45000 AND 59999 THEN 'MEDIUM VALUE'
	ELSE 'LOW VALUE'
	END AS PAYMENT_SEGMENT
FROM FACT_TABLE
GROUP BY "Payment Method";

SELECT * FROM FACT_TABLE

SELECT "Category", SUM("Total Sales")
FROM FACT_TABLE
GROUP BY "Category";

---CATEGORY WISE SEGMENTATION
SELECT "Category", SUM("Total Sales") AS CATEGORYWISE_SALES,
CASE
	WHEN SUM("Total Sales") > 50000 THEN 'HIGH VALUE'
	WHEN SUM("Total Sales") > 10000 THEN 'MEDIUM VALUE'
	ELSE 'LOW VALUE'
	END AS CATEGORY_SEGMENT
FROM FACT_TABLE
GROUP BY "Category";


---CUSTOMER SEGMENTATION TABLE---
CREATE TABLE customer_metrics AS
SELECT 
    "customer_id",
    "Customer Name",
    SUM("Total Sales") AS total_spent,
    AVG("Total Sales") AS avg_order_value,
    CASE
        WHEN SUM("Total Sales") >= 25000 THEN 'High Value'
        WHEN SUM("Total Sales") BETWEEN 20000 AND 24999 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM fact_table
GROUP BY "customer_id", "Customer Name";

SELECT * FROM CUSTOMER_METRICS

SELECT * FROM CUSTOMER_METRICS
ORDER BY customer_id ASC

SELECT * FROM CUSTOMER_METRICS

SELECT * FROM FACT_TABLE


SELECT "Product", "Category", SUM("Total Sales")
FROM FACT_TABLE
GROUP BY "Product", "Category";

---PRODUCT SEGMENTATION TABLE---
CREATE TABLE product_metrics AS
SELECT 
    "Product",
    "Category",
    SUM("Total Sales") AS total_spent,
    AVG("Total Sales") AS avg_order_value,
    CASE
        WHEN SUM("Total Sales") >= 20000 THEN 'High Value'
        WHEN SUM("Total Sales") BETWEEN 20000 AND 24999 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS product_segment
FROM fact_table
GROUP BY "Product", "Category";

SELECT * FROM PRODUCT_METRICS

SELECT * FROM CUSTOMER_METRICS

UPDATE product_metrics
SET product_segment = 
CASE
    WHEN "total_spent" > 20000 THEN 'High Value'
    WHEN "total_spent" BETWEEN 10000 AND 19999 THEN 'Medium Value'
    ELSE 'Low Value'
END;

SELECT * FROM PRODUCT_METRICS

SELECT * FROM FACT_TABLE

SELECT SUM("Total Sales") AS TOTAL_SPEND
FROM FACT_TABLE


SELECT * FROM FACT_TABLE

SELECT "Customer Name", SUM("Total Sales") AS Total_rev
FROM FACT_TABLE 
GROUP BY "Customer Name"

SELECT SUM("Total Sales") AS TOTAL_REV
FROM FACT_TABLE

SELECT "Category", SUM("Total Sales") AS Category_wise
FROM FACT_TABLE
GROUP BY "Category"

CREATE TABLE category_metrics AS SELECT 
"Category",
SUM("Total Sales") AS category_wise_sales
FROM FACT_TABLE
GROUP BY "Category"

SELECT * FROM category_metrics

DROP TABLE category_metrics

CREATE TABLE category_metrics AS SELECT
"Category",
SUM("Total Sales") AS category_wise_sales,
AVG("Total Sales") AS avg_order_categorywise
FROM FACT_TABLE
GROUP BY "Category"

SELECT * FROM category_metrics

SELECT SUM("Total Sales")
FROM FACT_TABLE

