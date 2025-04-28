﻿-- Chapter 9장 
-- 실습 데이터 소개 
USE lily_book_testdb;

-- 테이블 확인 
SELECT * FROM sales;
SELECT * FROM customer;

-- 테이블 기본정보 확인 하는 명려어
EXEC sp_help 'sales';

/***********************************************************
■ 매출 트렌드 (p.203)
************************************************************/

-- ##기간별 매출 현황
-- 출력 컬럼 : invoicedate, 매출액, 주문수량, 주문건수, 주문고객수
-- 활용 함수 : SUM(), COUNT()

SELECT CONVERT(date, InvoiceDate) AS InvoiceDate,        -- CONVERT(date, ~): 시간 부분(시:분:초)은 버리고 날짜만 남겨서 추출
	   ROUND(SUM(UnitPrice*ABS(quantity)), 2) AS 매출액,  -- ABS : 절댓값(양수로 변환)
	   SUM(Quantity) AS 주문수량,
	   COUNT(*) AS 주문건수,
	   COUNT(DISTINCT CustomerID) AS 주문고객수           -- DISTINCT : 중복값 제거
FROM sales
GROUP BY CONVERT(DATE, invoicedate)                     -- GROUP BY는 SELECT와 기준을 맞춰야함
ORDER BY invoicedate ;                                  -- ORDER BY는 별칭 사용가능


-- #국가별 매출 현황
-- 출력 컬럼 : country, 매출액, 주문수량, 주문건수, 주문고객수
-- 활용 함수 : SUM(), COUNT()

SELECT country,
	   SUM(UnitPrice*quantity) AS 매출액,
	   SUM(quantity) AS 주문수량,
	   COUNT(*) AS 주문건수,
	   COUNT(DISTINCT CustomerID) AS 주문고객수
FROM sales
GROUP BY country
ORDER BY country
;

SELECT country,
	   ROUND(SUM(UnitPrice*ABS(quantity)), 2) AS 매출액,
	   SUM(quantity) AS 주문수량,
	   COUNT(DISTINCT InvoiceNo) AS 주문건수,
	   COUNT(DISTINCT CustomerID) AS 주문고객수
FROM sales
GROUP BY country
ORDER BY country
;

-- 국가별 x 제품별 매출 현황 
-- 출력 컬럼 : country, stockcode, 매출액, 주문수량, 주문건수, 주문고객수
-- 활용 함수 : SUM(), COUNT()

SELECT country,
	   stockcode,
	   SUM(UnitPrice*quantity) AS 매출액,
	   SUM(quantity) AS 주문수량,
	   COUNT(*) AS 주문건수,
	   COUNT(DISTINCT CustomerID) AS 주문고객수
FROM sales
GROUP BY country, stockcode   -- GROUP BY에는 stockcode도 넣어야 함 → SELECT에 있으면 GROUP BY에도 꼭 들어가야 해
ORDER BY country
;


-- #특정 제품 매출 현황
-- 출력 컬럼 : 매출액, 주문수량, 주문건수, 주문고객수
-- 활용 함수 : SUM(), COUNT()
-- 코드명 : 21615

SELECT stockcode,
	   SUM(UnitPrice*quantity) AS 매출액,
	   SUM(quantity) AS 주문수량,
	   COUNT(*) AS 주문건수,
	   COUNT(DISTINCT CustomerID) AS 주문고객수
FROM sales
WHERE stockcode IN ('21615')  -- 👉 괄호, 따옴표(문자열일때) 꼭!
GROUP BY  stockcode
;

SELECT stockcode,
	   ROUND(SUM(UnitPrice*ABS(quantity)), 2) AS 매출액,
	   SUM(quantity) AS 주문수량,
	   COUNT(DISTINCT InvoiceNo) AS 주문건수,
	   COUNT(DISTINCT CustomerID) AS 주문고객수
FROM sales
WHERE stockcode IN ('21615')
GROUP BY stockcode
ORDER BY stockcode
;


-- 특정 제품의 기간별 매출 현황 
-- 출력 컬럼 : invoicedate, 매출액, 주문수량, 주문건수, 주문고객수
-- 활용 함수 : SUM(), COUNT()
-- 코드명 : 21615, 21731

SELECT stockcode,
	   invoicedate,
	   SUM(UnitPrice*quantity) AS 매출액,
	   SUM(quantity) AS 주문수량,
	   COUNT(*) AS 주문건수,
	   COUNT(DISTINCT CustomerID) AS 주문고객수
FROM sales
WHERE stockcode IN ('21615', '21731')   -- 문자형이면 따옴표 필수!
GROUP BY StockCode, InvoiceDate
ORDER BY InvoiceDate
;


/***********************************************************
■ 이벤트 효과 분석 (p.213)
************************************************************/

-- 이벤트 효과 분석 (시기에 대한 비교)
-- 2011년 9/10 ~ 2011년 9/25까지 약 15일동안 진행한 이벤트의 매출 확인 
-- 출력 컬럼 : 기간 구분, 매출액, 주문수량, 주문건수, 주문고객수 
-- 활용 함수 : CASE WHEN, SUM(), COUNT()
-- 기간 구분 컬럼의 범주 구분 : 이벤트 기간, 이벤트 비교기간(전월동기간)

-- ##이벤트 효과 분석 (시기에 대한 비교)
-- 2011년 9/10 ~ 2011년 9/25까지 특정 제품에 실시한 이벤트에 대해 매출 확인
-- 출력 컬럼 : 기간 구분, 매출액, 주문수량, 주문건수, 주문고객수 
-- 활용 함수 : CASE WHEN, SUM(), COUNT()
-- 기간 구분 컬럼의 범주 구분 : 이벤트 기간, 이벤트 비교기간(전월동기간)
-- 제품군 : 17012A, 17012C, 17084N

SELECT 
    CASE 
        WHEN CONVERT(DATE, invoicedate) BETWEEN '2011-09-10' AND '
2011-09-25' THEN '이벤트 기간'
        WHEN CONVERT(DATE, invoicedate) BETWEEN '2011-08-10' AND '2011-08-25' THEN '이벤트 비교기간'
        ELSE '기타'
    END AS 기간구분
    , SUM(unitprice*quantity) AS 매출액
    , SUM(quantity) AS 주문수량
    , COUNT(DISTINCT invoiceno) AS 주문건수
    , COUNT(DISTINCT customerid) AS 주문고객수
FROM sales
WHERE  (CONVERT(DATE, invoicedate) BETWEEN '2011-09-10' AND '2011-09-25' 
        OR CONVERT(DATE, invoicedate) BETWEEN '2011-08-10' AND '2011-08-25') 
        AND stockcode IN ('17012A', '17012C', '17084N')    --  연산자 우선 순위, () > AND > OR 
GROUP BY CASE 
        WHEN CONVERT(DATE, invoicedate) BETWEEN '2011-09-10' AND '2011-09-25' THEN '이벤트 기간'
        WHEN CONVERT(DATE, invoicedate) BETWEEN '2011-08-10' AND '2011-08-25' THEN '이벤트 비교기간'
        ELSE '기타'
    END
;

/***********************************************************
■ CRM 고객 타깃 출력 (p.217)
************************************************************/

-- ##특정 제품 구매 고객 정보
-- 문제 : 2010.12.1 - 2010.12.10일까지 특정 제품 구매한 고객 정보 출력
-- 출력 컬럼 : 고객 ID, 이름, 성별, 생년월일, 가입 일자, 등급, 가입 채널
-- HINT : 인라인 뷰 서브쿼리, LEFT JOIN 활용
-- 활용함수 : CONCAT()
-- 코드명 : 21730, 21615

SELECT * FROM sales;
SELECT * FROM customer;

-- 고객ID : 16565
SELECT * FROM customer WHERE mem_no = '16565'; 

-- 조인을 할 때는, 기본키와 외래키가 항상 존재
-- 기준이 되는 테이블의 기본키는 중복값이 무조건 없어야 함
-- SALES 데이터의 customerid 중복값을 모두 제거해서 마치 기본키가 존재하는 테이블 형태로 변형
SELECT DISTINCT customerid
FROM sales
WHERE  (CONVERT(DATE, invoicedate) BETWEEN '2010-12-01' AND '2010-12-18' 
;
SELECT 
    mem_no,
    CONCAT(last_name, first_name) AS customer_name,
    gd,
    birth_dt,
    entr_dt,
    grade,
    sign_up_ch
FROM 
    customer
WHERE 
    mem_no IN (
        SELECT DISTINCT customerid
        FROM sales
        WHERE stockcode IN ('21730', '21615')
          AND CONVERT(DATE, invoicedate) BETWEEN '2010-12-01' AND '2010-12-18'
    )
;
;

-- ##미구매 고객 정보 확인
-- 문제 : 전체 멤버십 가입 고객 중에서 구매 이력이 없는 고객과 구매 이력이 있는 고객 정보 구분 
-- 출력 컬럼 : non_purchaser, mem_no, last_name, first_name, invoiceno, stockcode, invoicedate, unitprice, customerid
-- HINT : LEFT JOIN
-- 활용함수 : CASE WHEN, IS NULL, 

-- CUSTOMER LEFT JOIN SALES
SELECT
	CASE WHEN s.customerid IS NULL THEN c.mem_no END AS non_purchaser
	, c.*
	, s.*
FROM customer C
LEFT JOIN sales s ON c.mem_no = s.customerid
;

SELECT
	COUNT(DISTINCT CASE WHEN s.customerid IS NULL THEN c.mem_no END) AS non_purchaser
	, COUNT(DISTINCT mem_no) AS total_customer
FROM customer C
LEFT JOIN sales s ON c.mem_no = s.customerid  -- 포인트 : left join을 이용해 구매고객과 비구매고객을 나눌 수 있는가?
;




-- 전체 고객수와 미구매 고객수 계산 
-- 출력 컬럼 : non_purchaser, total_customer
-- HINT : LEFT JOIN
-- 활용 함수 : COUNT(), IS NULL


/***********************************************************
■ 고객 상품 구매 패턴 (p.227)
************************************************************/

-- ##매출 평균 지표 활용하기 -- MSSQL 전용
-- 매출 평균지표 종류 : ATV, AMV, Avg.Frq, Avg.Units
-- 문제 : sales 데이터의 매출 평균지표, ATV, AMV, Avg.Frq, Avg.Units 알고 싶음
-- 출력 컬럼 : 매출액, 주문수량, 주문건수, 주문고객수, ATV, AMV, Avg.Frq, Avg.Units
-- 활용함수 : SUM(), COUNT()

SELECT
	ROUND(SUM(unitprice * quantity)/ COUNT(DISTINCT invoiceno), 2) AS ATV  -- 주문건수
	, ROUND(SUM(unitprice * quantity)/ COUNT(DISTINCT customerid),2) AS AMV -- 주문고객수
	, COUNT(DISTINCT invoiceno) / COUNT(DISTINCT customerid) AS AvgFrq
FROM sales ;


-- 문제 : 문제 : 연도 및 월별 매출 평균지표, ATV, AMV, Avg.Frq, Avg.Units 알고 싶음
-- 출력 컬럼 : 연도, 월, 매출액, 주문수량, 주문건수, 주문고객수, ATV, AMV, Avg.Frq, Avg.Units
-- 활용함수 : SUM(), COUNT(), YEAR, MONTH

/***********************************************************
■ 고객 상품 구매 패턴 (p.230)
************************************************************/

-- 특정 연도 베스트셀링 상품 확인
-- 문제 : 2011년에 가장 많이 판매된 제품 TOP 10의 정보 확인 
-- 출력 컬럼 : stockcode, description, qty
-- 활용함수 : TOP 10, SUM(), YEAR()

-- 두개의 코드 서로 비교, 단 MySQL에는 TOP 1, TOP 100 관련 메서드 없음 
SELECT TOP 10
    stockcode 
    , CONVERT(VARCHAR(255), description) AS description
    , SUM(quantity) as qty 
FROM sales 
WHERE YEAR(invoicedate) = '2011'
GROUP BY stockcode, CONVERT(VARCHAR(255), description)
ORDER BY qty DESC
;

SELECT stockcode, description, qty
FROM (
    SELECT 
        stockcode,
        CONVERT(VARCHAR(255), description) AS description,
        SUM(quantity) AS qty,
        ROW_NUMBER() OVER (ORDER BY SUM(quantity) DESC) AS rn
    FROM sales
    WHERE YEAR(invoicedate) = '2011'
    GROUP BY stockcode, CONVERT(VARCHAR(255), description)
) AS ranked
WHERE rn <= 10;



-- 정답(참고용)
-- 특정 연도 베스트셀링 상품 확인
-- 문제 : 2011년에 가장 많이 판매된 제품 TOP 10의 정보 확인 
-- 출력 컬럼 : stockcode, description, qty
-- 활용함수 : TOP 10, SUM(), YEAR()
SELECT TOP 10
    stockcode 
    , CONVERT(VARCHAR(255), description) AS description
    , SUM(quantity) as qty 
FROM sales 
WHERE YEAR(invoicedate) = '2011'
GROUP BY stockcode, CONVERT(VARCHAR(255), description)
ORDER BY qty DESC
;


-- 국가별 베스트셀링 상품 확인
-- 문제 : 국가별로 가장 많이 판매된 제품 순으로 실적을 구하고 싶음
-- 출력 컬럼 : RNK, country, stockcode, description, qty
-- HINT : 인라인 뷰 서브쿼리
-- 활용함수 : ROW_NUMBER() OVER(PARTITION BY...), SUM()



-- 20대 여성 고객의 베스트셀링 상품 확인 
-- 문제 : 20대 여성 고객이 가장 많이 구매한 TOP 10의 정보 확인 
-- 출력 컬럼 : RNK, country, stockcode, description, qty
-- HINT : 인라인 뷰 서브쿼리, 인라인 뷰 서브쿼리 작성 시, LEFT JOIN 필요
-- 활용함수 : ROW_NUMBER() OVER(PARTITION BY...), SUM(), YEAR()

-- SELF JOIN
-- 우리가 아는 JOIN의 형태는 두개의 서로 다른 테이블
-- 계층구조 확인하고 싶을 때 주로 사용
------- 직원테이블 (부서장, 사원)과의ㅣ 관계를 파악할 때 주로 활용

-- 아래 코드
-- 위 코드에서, 제품명에 LUNCH가 포함된 제품은 제외
SELECT TOP 10
	s.stockcode
	, CONVERT(VARCHAR(255), s.description)
	, SUM(quantity) AS qty
FROM sales s
INNER
JOIN /


/***********************************************************
■ 고객 상품 구매 패턴 (p.238)
************************************************************/

-- 특정 제품과 함께 가장 많이 구매한 제품 확인 
-- 문제 : 특정 제품(stockcode='20725')과 함께 가장 많이 구매한 TOP 10의 정보 확인
-- 출력 컬럼 : stockcode, description, qty 
-- HINT : INNER JOIN
-- 활용함수 : SUM()
--
/* 일반적인 SQL 문법구조
SELECT FROM GROUP BY ~~ 연도별로 판매개수 ==> A1
SELECT ROW_NUMBER() FROM (A1) ==> A2
SELECT ~~ FROM (A2) WHERE RNK <= 10
*/

SELECT TOP 10
		stockcode
		, CONVERT(VARCHAR(255), description) AS description
		, SUM(quantity) AS qty
	FROM sales
	WHERE YEAR(invoicedate) = '2011'
	GROUP BY stockcode, CONVERT(VARCHAR(255), description)
) AS rankde
WHERE rn <= 10 ;


/***********************************************************
■ 고객 상품 구매 패턴 (p.244)
************************************************************/

-- 재구매 고객의 비율 확인
-- 방법 1 : 고객별로 구매일 수 세는 방법
-- 문제 : 쇼핑몰의 재구매 고객수 확인 
-- 출력 컬럼 : repurchaser_count
-- HINT : 인라인 뷰
-- 활용 함수 : COUNT()




-- 방법 2 : 고객별로 구매한 일수에 순서를 매기는 방법
-- 문제 : 쇼핑몰의 재구매 고객수 확인 
-- 출력 컬럼 : repurchaser_count
-- HINT : 인라인 뷰
-- 활용 함수 : COUNT(), DENSE_RANK() OVER(PARTITION BY...)


-- 리텐션 및 코호트 분석
-- 2010년 구매 이력이 있는 2011년 유지율 확인 
SELECT COUNT(DISTINCT customerid) AS rentention_cnt
FROM sales
WHERE customerid <> ''
	AND customerid IN (
	SELECT DISTINCT customerid FROM sales 
	WHERE customerid <> ''
		AND YEAR(invoicedate) = '2010'
)
	AND YEAR(invoicedate) = '2011'
;

SELECT 
	customerid 
	, invoicedate 
	, DENSE_RANK() OVER(PARTITION BY customerid ORDER BY invoicedate) AS day_no 
FROM (
	SELECT customerid, invoicedate 
	FROM sales 
	WHERE customerid <> ''
	GROUP BY customerid, invoicedate
) a
;


-- 정리
-- 주로 다룬 것 : 분석을 위한 조회!!
-- 서브쿼리가 메인 !! 아직 익숙하지 않음

-- 다음주 수업내용
-- 서브쿼리, 윈도우 함수
-- 테이블 생성, 입력, 업데이트, 삭제 (CRUD, CREATE, READ, UPDATE, DELETE)
-- ERD의 개념 이해
-- 트리거 관련 예제 ( streamlit)