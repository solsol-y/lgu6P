SELECT * FROM production.brands;

-- 교재, WHERE 절
-- 조건과 일치하는 데이터 조회(필터링)
-- pandas, ilo, loc, 비교연산자 등 같이  상기

-- p.94
-- 남자 고객만 필터링 후, id, name, gender만 출력
USE lily_book;

-- 문법주의. "" 따옴표 안됨,' '작은 따옴표만 가능
SELECT * FROM dbo.customer;
SELECT
		*
FROM dbo.customer
WHERE customer_id = 'c002'
;

-- WHERE절 안에서 비교연산자 통해서 필터링
-- <>, != : 좌우값이 같지 않음
SELECT * FROM sales;

-- sales_amount의 값이 양수인것만 조회
SELECT * FROM sales WHERE sales_amount > 0;

-- 숫자를 입력할 때 근사하게 입력해보자
SELECT * FROM sales WHERE sales_amount = 41000

--데이터가 아예 없을 때도, NULL 형태로 출력
-- 조회를 할 때, 정확하게 입력하지 않아도 NULL형태로 출력

SELECT * FROM customer WHERE customer_id = 'Z002';

-- p. 100, BTWEEN 연산자,자수 쓰임
--- 30000에 40000상의 조건을 만족하는 행 출력
SELECT *
FROM sales
WHERE sales_amount BETWEEN 35000 AND 40000;

SELECT * FROM customer
WHERE customer_id BETWEEN 'c001' AND '003';

SELECT * FROM customer
WHERE last_name BETWEEN '가' AND '아'       -- 문자 넣어서 가능

-- IN 연산자, 매우매우 자주 사용됨
-- OR 연산자 반복해서 쓰기 싫어서 IN 사용함
SELECT * FROM sales WHERE product_name IN ('신발', '책'); 

-- Like 연산자(p.103) : 키워드 검색 연산자(조건과 일치하는 행을 필터링함)
USE BikeStores;

-- lastname이 letter z로 시작하는 모든 행을 필터링
SELECT * 
FROM sales.customers
WHERE last_name LIKE 'z%'
;
-- lastname이 letter z로 끝나는 모든 행을 필터링
SELECT * 
FROM sales.customers
WHERE last_name LIKE '%z'
;

-- lastname이 letter z가 포함된 모든 행을 필터링
SELECT * 
FROM sales.customers
WHERE last_name LIKE '%z%'
;

-- IS NULL 연산자 (중요함)
-- 데이터가 NULL값인 행만 필터링
-- 정상적으로 조회
SELECT *
FROM sales.customers
WHERE phone IS NULL;

-- 조회 안됨
SELECT *
FROM sales.customers
WHERE phone = NULL;

-- 조회 안됨
SELECT *
FROM sales.customers
WHERE phone = 'NULL';

-- NULL이 아닌것만 조회
SELECT *
FROM sales.customers
WHERE phone IS NOT NULL;

-- p.109
-- AND 연산자 / OR 연산자
USE lily_book;
SELECT * FROM distribution_center;

-- AND 연산자
SELECT *
FROM distribution_center
WHERE permission_date > '2022-05-01'
	AND permission_date < '2022-07-31'
	AND status = '영업중'
;

-- OR 연산자 (p.113)
-- LIKE 연산자와 같이 응용한 쿼리
SELECT *
FROM distribution_center
WHERE address LIKE '경기도 용인시%'
	OR address LIKE '서울시%'
;

-- 연산자 우선순위 : () > AND > OR
-- OR 을 먼저 처리하기 위해서는 ( A OR B ) and C 로 해야함

-- 부정연산자
-- IN, NOT IN 같이 공부
-- IS NULL, IS NOT NULL 같이 공부
SELECT * 
FROM distribution_center
WHERE center_no IN (1,2);

----------------

DROP TABLE sales

CREATE TABLE sales
(
  날짜        VARCHAR(10),
  제품명    VARCHAR(10),
  수량        INT,
  금액        INT
)

INSERT INTO sales VALUES('01월01일','마우스',1,1000)
INSERT INTO sales VALUES('01월01일','마우스',2,2000)
INSERT INTO sales VALUES('01월01일','키보드',1,10000)
INSERT INTO sales VALUES('03월01일','키보드',1,10000)

SELECT * FROM sales;

-- 일별로 판매된 수량과 금액
SELECT SUM(수량) AS 수량 FROM sales;

-- 문법 주의(p.124)
SELECT 날짜, SUM(수량) AS 수량 FROM sales;

SELECT 날짜, SUM(수량) AS 수량 
FROM sales
GROUP BY 날짜
;

SELECT 날짜, SUM(수량) AS 수량 
FROM sales
GROUP BY 제품명
;

SELECT 날짜, 제품명, SUM(수량) AS 수량 
FROM sales
GROUP BY 날짜, 제품명
;

SELECT 날짜, 제품명, SUM(수량) AS 수량, 금액
FROM sales
GROUP BY 날짜, 제품명
;

SELECT 날짜, 제품명, SUM(수량) AS 수량, SUM(금액)
FROM sales
GROUP BY 날짜, 제품명
;

-- p.130
-- 수행한 코드, 이미 중복값이 존재한 상태
-- 주문날짜, 2023-03-01, 2023-03-05
-- 월별 총매출액
/*
SELECT MONTH(order_date), sum(매출액)
FROM 테이블
GROUP BY MONTH(order_date)
;
/*