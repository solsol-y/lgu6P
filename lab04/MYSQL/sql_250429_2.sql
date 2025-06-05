USE classicmodels;

-- 문제 1.
-- 일별 매출액 조회
-- 테이블 orders, orderdetails
SELECT 
	A.orderDate
    , B.quantityOrdered * B.priceEach AS revenue
FROM orders A
LEFT
JOIN orderdetails B
ON A.orderNumber = B.ordernumber
;

-- 최종적으로 하고자 하는 것
-- 최종목표 : 국가별 매출 순위, DENSE_RANK()
-- windows, SALES, RNK
-- USA              1
-- Spain            2
SELECT
	C.country AS windows
    , SUN(od.quantityordered * od.priceEach) AS revenue
    , DENSE_RANK() OVER (ORDER BY SUN(od.quantityordered * od.priceEach) DESC) AS RNK
FROM customers C
LEFT JOIN orders O ON c.customernumber = O.customernumber
LEFT JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.country
;

SELECT 
	C.country 
    , SUM(od.quantityordered * od.priceEach) AS revenue
    , DENSE_RANK() OVER (ORDER BY SUM(od.quantityordered * od.priceEach) DESC) AS RNK
FROM customers C
LEFT JOIN orders O ON C.customernumber = O.customernumber
LEFT JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY C.country

;

-- 정답
SELECT 
    c.country 
    , SUM(od.quantityOrdered * od.priceEach) as revenue
    , DENSE_RANK() OVER (ORDER BY SUM(od.quantityOrdered * od.priceEach) DESC) AS RNK
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
LEFT JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.country 
ORDER BY RNK LIMIT 5
;


-- 비슷한 개념
-- 미국이 가장 많이 팔리고 있는 것 확인
-- 차량 모델 관련 DB
-- 미국에서 가장 많이 팔리는 차량 모델 5개 구하기 ( ~ 11:10분까지, 앞의 내용 복습 철저)
-- 차량모델, revenue, RANK

SELECT  c.country 
    , SUM(od.quantityOrdered * od.priceEach) as revenue
    , DENSE_RANK() OVER (ORDER BY SUM(od.quantityOrdered * od.priceEach) DESC) AS RNK
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
LEFT JOIN orders o ON od.orderNumber = o.orderNumber
LEFT JOIN customers c ON o.customerNumber = c.customerNumber
WHERE c.country = 'USA'
GROUP BY 1
ORDER BY RNK LIMIT 5
;

-- 정답
SELECT 
p.productName 
, SUM(od.quantityOrdered * od.priceEach) as revenue
, DENSE_RANK() OVER (ORDER BY SUM(od.quantityOrdered * od.priceEach) DESC) AS RNK
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
LEFT JOIN orders o ON od.orderNumber = o.orderNumber
LEFT JOIN customers c ON o.customerNumber = c.customerNumber
WHERE c.country = 'USA'
GROUP BY 1
ORDER BY RNK LIMIT 5
;

--

USE mssqldb;

CREATE TABLE sales(
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee,fiscal_year)
);

INSERT INTO sales(sales_employee,fiscal_year,sale)
VALUES('Bob',2016,100),
      ('Bob',2017,150),
      ('Bob',2018,200),
      ('Alice',2016,150),
      ('Alice',2017,100),
      ('Alice',2018,200),
       ('John',2016,200),
      ('John',2017,150),
      ('John',2018,250);

SELECT * FROM sales;

-- LAG() 함수 기본 : 이전 행의 값 가져오기
SELECT
	sales_employee
    , fiscal_year
    , sale
    , LAG(sale) OVER(PARTITION BY sales_employee ORDER BY fiscal_year) AS prev_year_sale
FROM sales
ORDER BY 1, 2
;

-- LAG() 함수를 활용한 매출 증가율 계산
-- 각 직원별로 전년 대비 매출 증가율 계산
-- Alic 2017 100.00 150.00 -33.33
-- Alic 2018 
SELECT
	sales_employee
    , fiscal_year
    , sale
    , LAG(sale) OVER(PARTITION BY sales_employee ORDER BY fiscal_year) AS prev_year_sale
    ,ROUND( sale - LAG(sale) OVER(PARTITION BY sales_employee
		ORDER BY fiscal_year)) / LAG(sale) OVER(PARTITION BY fiscal_year)
        ORDER BY fiscal_year) * 100, 1) AS growth_pct
FROM sales
ORDER BY 1, 2
;

-- 질문 : 증감률 (X)
-- 1년전, 2년전 매출과 비교하세요
-- sale, prev_year_sale, two_year_ago_sale, 2년전 매출과 비교
SELECT
	sales_employee
    , fiscal_year
    , sale
    , LAG(sale, 1, 0) OVER(PARTITION BY sales_employee ORDER BY fiscal_year) AS 1년전매출
	, LAG(sale, 2, 0) OVER(PARTITION BY sales_employee ORDER BY fiscal_year) AS 2년전매출
    , ROUND( (sale - LAG(sale) OVER(PARTITION BY sales_employee
		ORDER BY fiscal_year)) / LAG(sale) OVER(PARTITION BY fiscal_year)
        ORDER BY fiscal_year * 100, 1) AS growth_pct
FROM sales
ORDER BY 1, 2  -- 1번째 열, 2번째 열 기준으로 정렬
;

USE classicmodels;
SELECT * FROM orders;
SELECT * FROM orderdetails;

-- 실전문제
-- 1. 각 주문의 현재 주문금액과 이전 주문금액의 차이를 계산하시오. 
-- 1. 각 주문의 현재 주문금액과 이전 주문금액의 차이를 계산
-- 1) orders와 orderdetails 테이블을 조인하여 주문별 총액을 계산하는 서브쿼리 작성
-- 2) LAG 함수를 사용하여 이전 주문 금액을 가져옴 (orderDate 기준)
-- 3) 현재 주문금액 - 이전 주문금액으로 차이 계산

-- 코드 
SELECT *	
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
;

SELECT 
	o.ordernumber
    , o.orderDate
    , SUM(od.priceEach * od.QuantityOrdered) AS totalAmount
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY 1,2
;

SELECT orderdate
	, fiscal_day
    , od.priceEach * od.QuantityOrdered 
    , LAG(orderdate, 1,0) OVER(PARTITION BY od.priceEach * od.QuantityOrdered) AS 이전주문금액
	
FROM orders o
LEFT JOIN orderdetails od ON o.orderNumber = od.orderNumber
GRO

-- 2. 각 고객별로 주문금액과 직전 주문금액을 비교하여 증감률을 계산하시오
-- 2. 각 고객별 주문금액과 직전 주문금액의 증감률 계산
-- 1) orders, orderdetails 테이블 조인하여 고객별, 주문일자별 총 주문금액 계산 (서브쿼리)
-- 2) LAG 함수로 각 고객별 이전 주문금액 가져오기 (PARTITION BY customerNumber)
-- 3) (현재주문금액 - 이전주문금액) / 이전주문금액 * 100 으로 증감률 계산
-- 4) ROUND 함수로 소수점 2자리까지 표시

-- 코드

-- 3. 각 제품라인별로 3개월 이동평균 매출액을 계산하시오
-- 3. 각 제품라인별 3개월 이동평균 매출액 계산
-- 1) products, orderdetails, orders 테이블 조인하여 제품라인별, 월별 매출액 계산 (서브쿼리)
-- 2) DATE_FORMAT 함수로 orderDate를 월 단위로 그룹화
-- 3) AVG 함수와 OVER절을 사용하여 3개월 이동평균 계산
--    - PARTITION BY로 제품라인별 그룹화
--    - ROWS BETWEEN 2 PRECEDING AND CURRENT ROW로 현재행 포함 이전 2개 행까지의 평균 계산
-- 4) ROUND 함수로 소수점 2자리까지 표시

-- 코드

-----------------------------------------------------------------

-- employees 테이블 활용한 window function 연습 
-- 간단한 테이블 생성 부터 시작 
-- MySQL Window Functions 개념 이해 - LAG() 함수 위주로 3가지 예제
-- https://www.mysqltutorial.org/mysql-window-functions/ 기반

-- 먼저 예제용 sales 테이블 생성
CREATE TABLE IF NOT EXISTS sales (
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee, fiscal_year)
);

-- 예제 데이터 삽입
INSERT INTO sales(sales_employee, fiscal_year, sale)
VALUES
    ('Bob', 2016, 100),
    ('Bob', 2017, 150),
    ('Bob', 2018, 200),
    ('Alice', 2016, 150),
    ('Alice', 2017, 100),
    ('Alice', 2018, 200),
    ('John', 2016, 200),
    ('John', 2017, 150),
    ('John', 2018, 250);

-- 1. LAG() 함수 기본: 이전 행의 값 가져오기
-- 각 직원별로 현재 연도와 이전 연도의 매출 비교
-- LAG() 함수는 현재 행을 기준으로 이전 행의 값을 참조할 수 있게 해주는 윈도우 함수입니다.
-- 실전문제
-- 1. 각 주문의 현재 주문금액과 이전 주문금액의 차이를 계산하시오. 
-- 1. 각 주문의 현재 주문금액과 이전 주문금액의 차이를 계산
-- 1) orders와 orderdetails 테이블을 조인하여 주문별 총액을 계산하는 서브쿼리 작성
-- 2) LAG 함수를 사용하여 이전 주문 금액을 가져옴 (orderDate 기준)
-- 3) 현재 주문금액 - 이전 주문금액으로 차이 계산
SELECT 
    orderNumber,
    orderDate,
    totalAmount, 
    LAG(totalAmount) OVER (ORDER BY orderDate) as prev_amount,
    totalAmount - LAG(totalAmount) OVER (ORDER BY orderDate) as amount_difference
FROM (
    SELECT 
        o.orderNumber,
        o.orderDate,
        SUM(quantityOrdered * priceEach) as totalAmount
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    GROUP BY o.orderNumber, o.orderDate
) A
ORDER BY orderDate;

-- 2. 각 고객별로 주문금액과 직전 주문금액을 비교하여 증감률을 계산하시오
-- 2. 각 고객별 주문금액과 직전 주문금액의 증감률 계산
-- 1) orders, orderdetails 테이블 조인하여 고객별, 주문일자별 총 주문금액 계산 (서브쿼리)
-- 2) LAG 함수로 각 고객별 이전 주문금액 가져오기 (PARTITION BY customerNumber)
-- 3) (현재주문금액 - 이전주문금액) / 이전주문금액 * 100 으로 증감률 계산
-- 4) ROUND 함수로 소수점 2자리까지 표시

SELECT 
    customerNumber,
    orderDate,
    orderAmount,
    LAG(orderAmount) OVER (PARTITION BY customerNumber ORDER BY orderDate) as prev_amount,
    ROUND(((orderAmount - LAG(orderAmount) OVER (PARTITION BY customerNumber ORDER BY orderDate)) / 
    LAG(orderAmount) OVER (PARTITION BY customerNumber ORDER BY orderDate) * 100), 2) as growth_rate
FROM (
    SELECT 
        o.customerNumber,
        o.orderDate,
        SUM(quantityOrdered * priceEach) as orderAmount
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    GROUP BY o.customerNumber, o.orderDate
) A
ORDER BY customerNumber, orderDate;

-- 3. 각 제품라인별로 3개월 이동평균 매출액을 계산하시오
-- 3. 각 제품라인별 3개월 이동평균 매출액 계산
-- 1) products, orderdetails, orders 테이블 조인하여 제품라인별, 월별 매출액 계산 (서브쿼리)
-- 2) DATE_FORMAT 함수로 orderDate를 월 단위로 그룹화
-- 3) AVG 함수와 OVER절을 사용하여 3개월 이동평균 계산
--    - PARTITION BY로 제품라인별 그룹화
--    - ROWS BETWEEN 2 PRECEDING AND CURRENT ROW로 현재행 포함 이전 2개 행까지의 평균 계산
-- 4) ROUND 함수로 소수점 2자리까지 표시

SELECT *
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
LEFT JOIN orders o ON od.orderNumber = o.orderNumber
;

SELECT 
	p.productline
    , DATE_FORMAT(o.orderDate, '%Y-%m-01') AS orderDate
    , SUM(od.quantityOrdered * od.priceEach) AS monthly_sales
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
LEFT JOIN orders o ON od.orderNumber = o.orderNumber
GROUP BY 1,2
;


SELECT 
    productLine,
    orderDate,
    monthly_sales,
    ROUND(AVG(monthly_sales) OVER (
        PARTITION BY productLine 
        ORDER BY orderDate 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) as moving_average_3months
FROM (
    SELECT 
        p.productLine,
        DATE_FORMAT(o.orderDate, '%Y-%m-01') as orderDate,
        SUM(od.quantityOrdered * od.priceEach) as monthly_sales
    FROM products p
    JOIN orderdetails od ON p.productCode = od.productCode
    JOIN orders o ON od.orderNumber = o.orderNumber
    GROUP BY p.productLine, DATE_FORMAT(o.orderDate, '%Y-%m-01')
) A
ORDER BY productLine, orderDate;








