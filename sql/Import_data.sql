USE Retail_SQL_Analysis;
GO

BULK INSERT customers
FROM 'D:\Darshna work\three projects\Data_Analyst_Portfolio_Projects\Project2_Retail_SQL_Analysis\data\customers.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

SELECT * FROM customers;

-- Import products
BULK INSERT products
FROM 'D:\Darshna work\three projects\Data_Analyst_Portfolio_Projects\Project2_Retail_SQL_Analysis\data\products.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

SELECT * FROM products;

-- Import orders
BULK INSERT orders
FROM 'D:\Darshna work\three projects\Data_Analyst_Portfolio_Projects\Project2_Retail_SQL_Analysis\data\orders.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

SELECT * FROM orders;

USE Retail_SQL_Analysis;
GO

SELECT 'Customers' AS TableName, COUNT(*) AS TotalRows FROM customers
UNION ALL
SELECT 'Products', COUNT(*) FROM products
UNION ALL
SELECT 'Orders', COUNT(*) FROM orders;