-- 현재 데이터 베이스 확인
SELECT DB_NAME(); 

-- 데이터베이스 > 테이블(pandas 데이터프레임)
-- 데이터베이스 안에 있는 것
---- 테이블 외에도, view, 프로시저, 트리거 등 포함
-- SQL, SQEL : E -English
-- 문법이 영어 문법과 매우 흡사함
-- 표준 SQL, 99% 비슷, 1% 다름 ==> 데이터타입할 때 차이가 좀 있음(DB 종류마다)



-- 데이터 확인    -- 함수는 대문자, 변수 및 컬럼은 소문자로 작성하면 가독성 좋음
USE lily_book;
SELECT * FROM staff;
SELECT * FROM lily_book.dbo.staff;


USE BikeStores;
SELECT * FROM production.brands;

-- 데이터분석의 모든 것 (교재 p.36)
-- SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY
-- FROM	A pandas dataframe SELECT column
-- p.42 SELECT 절과 FROM 절
USE lily_book;
SELECT employee_id, employee_name, birth_date FROM staff;


-- 추천
SELECT 
	ep_id                    -- 사원ID
	,ep_name,				 -- 사원명
	birth_date
FROM satff
; -- 해당 쿼리 코드 작성 완료

SELECT * FROM staff;                          -- 좋은 쿼리 작성 방법은 아니다.
SELECT employee_name, employee_id FROM staff; -- 컬럼 순서 변경 가능

-- 컬럼 별칭
-- 컬럼명 지정할 때는, 영어 약어로 지정 ==> 데이터 정의서 관리
-- ALIAS (AS) : 별칭
SELECT employee_id, birth_date
FROM staff
;


SELECT employee_id, birth_date AS '생년월일'  -- 작은 따옴표, 큰따옴표 둘다 사용가능, 대신 한글 사이 띄우는거 불가능(db마다 확인해봐야함)
FROM staff
;

-- DISTINCT 중복값 제거 (p.49)
SELECT * FROM staff;

SELECT DISTINCT gender FROM staff;
SELECT gender FROM staff;

SELECT employee_name, gender, position FROM staff;
SELECT DISTINCT position, employee_name, gender FROM staff;   -- 고유값(이름 등) 이 있다면 중복값 제거가 안됨
SELECT DISTINCT position, gender FROM staff;

-- 문자열 함수 : 다른 DBMS와 문법 유사, 블로그에 정리
SELECT * FROM apparel_product_info;

-- LEFT 함수 확인
SELECT product_id, LEFT(product_id, 2) AS 약어     -- 컬럼 반복적으로 사용 가능
FROM apparel_product_info; 

-- SUBSTRING 문자열 중간에 N번째 자리부터 N개만 출력해줘
-- SUBSTRING(컬럼명, 숫자(N start), 숫자(N end))
-- 파이썬, 다른 프로그래밍 언어는 인덱스가 0번째부터 시작
-- MS-SQL은 인덱스가 0번째부터 하니깐..?
-- MS-SQL은 인덱스가 1번째부터 시작!!
SELECT product_id, SUBSTRING(product_id, 0) AS 약어     
FROM apparel_product_info; 

-- CONCAT 문자열과 문자열 이어서 출력
SELECT CONCAT(category1, '>', category2, '=', '옷', price) AS 테스트
FROM apparel_product_info;

-- REPLACE : 문자열에서 특정 문자 변경
-- p.58
--
SELECT product_id, REPLACE(product_id, 'F','A') AS 결과
FROM apparel_product_info;

--ISNULL 중요함
