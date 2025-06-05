USE mssqldb;

SET GLOBAL local_infile = 1; -- local file 불러오기 활성화

CREATE TABLE customer (
    mem_no      INT PRIMARY KEY,
    last_name   VARCHAR(10),
    first_name  VARCHAR(20),
    gd          CHAR(1),
    birth_dt    DATE,
    entr_dt     DATE,
    grade       VARCHAR(10),
    sign_up_ch  VARCHAR(2)
);

SELECT * FROM customer;

CREATE TABLE sales (
    InvoiceNo    VARCHAR(20),
    StockCode    VARCHAR(20),
    Description  VARCHAR(100),
    Quantity     INT,
    InvoiceDate  DATETIME,
    UnitPrice    DECIMAL(10,2),
    CustomerID   VARCHAR(20),
    Country      VARCHAR(50)
);

SELECT * FROM sales;