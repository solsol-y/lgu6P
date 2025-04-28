-- HAVING절
CREATE TABLE sales_ch5
(
  order_id		VARCHAR(5),
  order_date	DATE,
  city			VARCHAR(5),
  customer_id	VARCHAR(5),
  sales_amount	INT
)

INSERT INTO sales_ch5 VALUES('1','2023-01-01','서울','a001',5000)
INSERT INTO sales_ch5 VALUES('2','2023-04-30','서울','a001',10000)
INSERT INTO sales_ch5 VALUES('3','2023-05-10','부산','a001',10000)
INSERT INTO sales_ch5 VALUES('4','2023-05-10','부산','a002',5000)
INSERT INTO sales_ch5 VALUES('5','2023-06-30','부산','a003',5000)

SELECT  * FROM sales_ch5

-- HAVING vs WHERE : 필터링
-- WHERE : 원본 데이터를 기준으로 필터링
-- HAVING : 그룹화 계산이 끝난 이후를 기준으로 필터링
-- 고객별로 매출 구하고, 그 값이 20,000을 초과하는 값만 구하고 싶음
SELECT 
	customer_id                 -- 중복되는 값이 다수 존재하는가?
	, SUM(sales_amount) AS 매출
FROM sales_ch5
GROUP BY customer_id
HAVING SUM(sales_amount) > 20000
;

-- WHERE 사용불가
-- WHERE 절에서는 집계함수(SUM, AVG 등)를 직접 사용할 수 없음
-- WHERE는 그룹을 만들기 전 단계에서 작동

/* -- MS-SQL, ORACLE 같은 경우 문법이 엄격한 편

SELECT CASE WHEN ==> 그룹
	, 수치필드
FROM 테이블
GROUP BY 1  -- 숫자만 입력하면 인식 가능 
*/

-- ORDER BY
SELECT 
	customer_id                 -- 중복되는 값이 다수 존재하는가?
	, SUM(sales_amount) AS 매출
FROM sales_ch5
GROUP BY customer_id
ORDER BY 매출 DESC             -- DESC 내림차순, 디폴트는 오름차순, ASC 오름차순
;



/*
-- DB가 데이터를 처리하는 순서
-- FROM ==> SELECT  (X)
FROM ==> WHERE ==>GROUP BY - HAVING ==> SELECT ==> ORDER BY
*/

-- 서브쿼리(p.158)

/***********************************************************
■ 데이터 7.2.1
■ product_info : 제품에 대한 정보
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

CREATE TABLE product_info
(
  product_id		VARCHAR(4) ,
  product_name		VARCHAR(100),
  category_id		VARCHAR(3),
  price				INT,
  display_status	VARCHAR(10),
  register_date		DATE
)
INSERT INTO product_info VALUES ('p001','A노트북 14inch','c01',1500000,'전시중','2022-10-02')
INSERT INTO product_info VALUES ('p002','B노트북 16inch','c01',2000000,'전시중지','2022-11-30')
INSERT INTO product_info VALUES ('p003','C노트북 16inch','c01',3000000,'전시중','2023-03-11')
INSERT INTO product_info VALUES ('p004','D세탁기','c01',1500000,'전시중','2021-08-08')
INSERT INTO product_info VALUES ('p005','E건조기','c01',1800000,'전시중','2022-08-09')
INSERT INTO product_info VALUES ('p006','핸드폰케이스','c02',21000,'전시중','2023-04-03')
INSERT INTO product_info VALUES ('p007','노트북 액정보호필름','c02',15400,'전시중','2023-04-03')

-- SELECT  * FROM product_info



/***********************************************************
■ 데이터 7.3.1
■ category_info : 제품 카테고리에 대한 정보
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

CREATE TABLE category_info
(
  category_id   VARCHAR(10),
  category_name VARCHAR(10)
)

INSERT INTO category_info VALUES ('c01','가전제품')
INSERT INTO category_info VALUES ('c02','액세서리')

-- SELECT  * FROM category_info



/***********************************************************
■ 데이터 7.4.1
■ event_info : 이벤트 제품에 대한 정보
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

CREATE TABLE event_info
(
  event_id   VARCHAR(3),
  product_id VARCHAR(4)
)

INSERT INTO event_info VALUES ('e1','p001')
INSERT INTO event_info VALUES ('e1','p002')
INSERT INTO event_info VALUES ('e1','p003')
INSERT INTO event_info VALUES ('e2','p003')
INSERT INTO event_info VALUES ('e2','p004')
INSERT INTO event_info VALUES ('e2','p005')

-- SELECT  * FROM event_info
-- 데이터 확인
SELECT * FROM product_info;
SELECT * FROM category_info;
SELECT * FROM event_info;


-- p.161
-- 제품 정보가 있는 product_info 테이블
-- 제품 카테고리가 있는 category_info 테이블
-- 이벤트 제품에 대한 정보 event_info 테이블

-- 서로 다른 테이블 ==> 테이블 조인 (일반적인 방법)
-- 서브쿼리 vs 테이블 조인 (엔지니어, 두개의 성능 비교)
-- 실행계획 통해서 , 두 쿼리의 성능을 비교 할 수 있어야 한다. (엔지니어 희망자)

SELECT 
	product_id
	, product_name
	, category_id
	, (SELECT category_name FROM category_info WHERE category_id = p.category_id)
FROM product_info p;  -- 일반적으로 테이블 조인 테이블의 이름을 ALIAS 처리

SELECT * FROM category_info ;

SELECT 	product_id
	, product_name
FROM product_info p
Join category_info c
	on p.category_id = c.category_id;



-- FROM절 서브쿼리
-- data1 = data.가공
-- data2 = data1.가공
-- SELECT FROM (SELECT FROM (SELECT FROM))
-- product_info 테이블, 카테고리별로 제품의 개수가 5개 이상인 카테고리만 출력
SELECT 
	category_id
	, COUNT(product_id) AS count_of_product
FROM product_info
GROUP BY category_id
;
SELECT *
FROM (
	SELECT
		category_id
		, COUNT(product_id) AS count_of_product
	FROM product_info
	GROUP BY category_id
) p
WHERE count_of_product >= 5
;

-- WHERE절 서브쿼리 (p.167)
-- 서브쿼리 잘하고 싶음 : 분할 후 합치세요
-- product_info T, 가전제품 카테고리만 출력하고 싶다.
-- 서브쿼리, 메인쿼리 분할해서 처리
-- 서브쿼리 : 가전제품 카테고리만 조회
-- 메인쿼리 : product_info 테이블 조회

-- 가전제품 카테고리 id ==> c01
SELECT * FROM product_info;
SELECT category_id FROM category_info WHERE category_name = '가전제품'

--
category_test = input()
SELECT * FROM product_info WHERE category_id <> (
	SELECT category_id FROM category_info WHERE category_name = '액세서리'
);
SELECT * FROM product_info WHERE category_id = 'c01'


-- p.168
-- product_info T, event_id 컬럼의 e2에 포함된 제품의 정보만 출력
-- 메인쿼리 : product_info T 제품의 정보 출력
-- 서브쿼리 : event_id 컬럼의 e2에 해당하는 제품
SELECT * FROM product_info WHERE product_id IN ('p003', 'p004', 'p005');

SELECT product_id FROM event_info WHERE event_id = 'e2';

-- 위의 두 쿼리 합치기 

-- ERD(Entity-Relationship Diagram)
-- ?

-- 테이블의 결합
-- LEFT JOIN, RIGHT JOIN, OUTER JOIN (FULL JOIN), INNER JOIN
-- LEFT OUTER JOIN, RIGHT OUTER JOIN
-- p.185
SELECT *
FROM product_info pi
LEFT
JOIN category_info ci ON pi.category_id =ci.category_id
;


-- UNION 연산자(p.187): 테이블 아래로 붙이기
-- UNION (중복 값 제거) vs UNION ALL(중복 값 제거하지 않은 채 그대로 출력)
-- JOIN : 아예 다른 것을 붙이는 것
-- UNION : 접점이 되는 id가 있을 때 사용



CREATE TABLE sales_2023
(
  order_id       VARCHAR(10),
  order_date	 DATE,
  order_amount   INT
)

INSERT INTO sales_2023 VALUES ('or0005','2023-05-01',50000)
INSERT INTO sales_2023 VALUES ('or0006','2023-07-31',70000)
INSERT INTO sales_2023 VALUES ('or0007','2023-12-31',120000)

SELECT  * FROM sales_2023

-- 서브쿼리 추가 질문
USE BikeStores;

-- 테이블
SELECT * FROM sales.orders;

-- 문제 : 2017년에 가장 많은 주문을 처리한 직원이 처리한 모든 주문 조회
-- 1. 모든 주문 정보 처리
-- 2. HWERE 서브쿼리 사용해서 2017년 최다 주문 처리 직원 찾기
-- 3. TOP 1과 Groupby 사용
-- 4. 활용함수 : YEAR, COUNT(*)

-- 메인쿼리 : 모든 주문 정보 표시
SELECT * FROM sales.orders WHERE staff.id = 3;

-- 서브쿼리 : 2017년에 가장 많은 주문을 처리한 직원 찾기
-- staff.id 빈번하게 등장한 직원 찾기
SELECT staff_id, count(*) AS 주문건수
FROM sales.orders
WHERE YEAR(order_date) = 2017
GROUP BY staff_id
;

SELECT TOP 1 staff_id
FROM sales.orders
WHERE YEAR(order_date) = 2017
GROUP BY staff_id
ORDER BY count(*) DESC
;

-- 합치기
-- 유관부서 요청사항 : 2017년에 가장 많은 주문을 처리한 직원이 처리한 모든 주문 조회
SELECT * 
FROM sales.orders 
WHERE staff_id = (
	SELECT TOP 1 staff_id
	FROM sales.orders
	WHERE YEAR(order_date) = 2017
	GROUP BY staff_id
	ORDER BY COUNT(*) DESC
);


-- 테이블 2개
SELECT * FROM production.products;
SELECT * FROM sales.order_items;

--- 질문 : 한 번도 주문되지 않은 제품들의 정보를 조회하시오
-- 중복을 제거하는 방법: SELECT DISTINCT

-- 메인쿼리 : products 테이블의 모든 데이터를 조회
SELECT * FROM production.products;

-- 서브쿼리 : 한 번도 주문되지 않은 제품 정보
SELECT * FROM sales.order_items;

SELECT DISTINCT product_id FROM sales.order_items;  -- 주문이 최소 1번 이상은 발생한 product_id

SELECT *
FROM sales.order_items
WHERE product_id NOT IN(
	SELECT DISTINCT product_id FROM sales.order_items
	);






