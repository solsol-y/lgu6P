USE testdb;

/*---------------------
------ CH01 기본키 ------
----------------------*/

-- 테이블 생성 코드
CREATE TABLE products(
	id            INT           PRIMARY KEY
    , name        VARCHAR(255)  NOT NULL
);

-- 테이블 삭제 
-- DROP TABLE products;

-- 조회 ==> 결과 : None
SELECT * FROM products;

-- 데이터 추가 : Insert Data 
INSERT INTO products (id, name)
VALUES 
	(1, '노트북'), 
    (2, '모바일폰')
;

SELECT * FROM products;

INSERT INTO products (id, name)
VALUES 
	(4, 'PC')
;

SELECT * FROM products;

-- AUTO_INCREMENT 옵션 추가 
DROP TABLE products;
CREATE TABLE products(
	id INT AUTO_INCREMENT PRIMARY KEY
    , name        VARCHAR(255)  NOT NULL
);

-- 데이터 입력 방식 문법이 달라짐
INSERT INTO products (name)
VALUES 
	('노트북'), 
    ('모바일폰')
;

SELECT * FROM products;

-- 두개의 테이블 생성
-- 기본키를 하나만 생성하는 것이 아닌, 다중 필드를 기본키로 설정 
-- 시나리오 : 고객 테이블, 제품선호도테이블
CREATE TABLE customers(
	id INT AUTO_INCREMENT PRIMARY KEY
    , name        VARCHAR(255)  NOT NULL
)
;

-- favor
CREATE TABLE favor(
	customer_id INT
    , product_id INT
    , favor_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    , PRIMARY KEY(customer_id, product_id)
)
;

-- 기본키를 추가할 것
-- ALTER 명령어
USE testdb;

DROP TABLE tags;
CREATE TABLE tags(
	id INT 
    , name VARCHAR(25) NOT NULL
)
;

ALTER TABLE tags
ADD PRIMARY KEY(id)
;

DESC tags; -- Key : PRI

-- Key 값 제거 
ALTER TABLE tags
DROP PRIMARY KEY
;

DESC tags; -- Key : None


/*---------------------
------ CH02 외래키 ------
----------------------*/

-- 관계형 : 부모와 자식간의 관계 설정
-- 부모 테이블 생성 : departments 
CREATE TABLE departments (
	department_id  INT AUTO_INCREMENT PRIMARY KEY   -- 부서ID, 기본키
    ,  departments_name VARCHAR(100) NOT NULL        -- 부서명, 필수 입력
)
; 

-- 자식 테이블 생성 : employees
CREATE TABLE employees (
	employee_id INT AUTO_INCREMENT PRIMARY KEY -- 직원 ID, 기본키
    , employee_name VARCHAR(255) NOT NULL      -- 직원명, 필수 입력
    , department_id INT                        -- 부서 ID 
    
    -- 외래 키 설정 
    , FOREIGN KEY (department_id)
		REFERENCES departments(department_id) 
        ON DELETE SET NULL  -- 부서 삭제 시, 직원의 department_id를 null로 변경
        ON UPDATE CASCADE   -- 부서 ID 변경 시, employee 테이블에도 변경 반영
)
;

INSERT INTO departments (departments_name) VALUES ('HR');
INSERT INTO departments (departments_name) VALUES ('IT');
INSERT INTO departments (departments_name) VALUES ('Sales');

INSERT INTO employees (employee_name, department_id) 
VALUES ('Alice', 1), ('Bob', 2), ('Charlie', 3);


SELECT * FROM departments;
SELECT * FROM employees;

-- 부서 삭제 (row), 부서테이블에서
DELETE FROM departments WHERE department_id = 2;

-- 직원 테이블에 영향을 가서, employee_id 2의 부서는 null
SELECT * FROM departments;
SELECT * FROM employees;


/*---------------------
------ CH03 제약조건 ------
----------------------*/

-- UNIQUE 제약조건
-- 특정 컬럼이 중복되지 않도록 보장하는 제약 조건

-- 테이블 생성 : users 
CREATE TABLE users(
	id INT AUTO_INCREMENT PRIMARY KEY
    , username VARCHAR(50) NOT NULL      -- 사용자 이름 필수
    , email VARCHAR(100) UNIQUE          -- NULL 값 허용, 중복 금지
)	
;

-- 정상 입력
INSERT INTO users (username, email) VALUES('evan', 'evan@example.com');
INSERT INTO users (username, email) VALUES('eva', NULL);
INSERT INTO users (username, email) VALUES('yuna'); -- NULL 값이라도 표시해라

INSERT INTO users (username, email) VALUES('yuna', 'evan@example.com');

-- 
-- phone, name 둘 다 같을 때에만 추가 입력 불가
CREATE TABLE users2(
	id INT AUTO_INCREMENT PRIMARY KEY
    , username VARCHAR(50) NOT NULL      -- 사용자 이름 필수
    , email VARCHAR(100)
    , phone VARCHAR(20)
    , UNIQUE(email, phone)
)	
;

INSERT INTO users2 (username, email, phone) 
VALUES('yuna', 'evan@example.com', '010-7207-2163');

INSERT INTO users2 (username, email, phone) 
VALUES('yuna', 'evan@example.com', '011-7207-2163');


-- 
SELECT * FROM users2;


/*---------------------
------ CH04 수정 ------
----------------------*/
-- ALTER TABLE, 테이블의 구조를 변경
-- UPDATE : 테이블 안의 기존 데이터를 수정(update) 할 때 사용하는 명령어
-- 특정 행(row)이나 여러 행을 동시에 변경

-- employees 테이블 예시
-- id, name, salary, department 
-- 3개 정도 데이터 추가

DROP TABLE employees;

CREATE TABLE employees(
	id SMALLINT
    , name TINYTEXT
    , salary FLOAT
    , department CHAR(30)
)
;

INSERT INTO employees (id, name, salary, department)
VALUES
(2, 'evan1', 6000.0, 'IT')
, (3, 'evan2', 7000.0, 'BANK')
;

SELECT * FROM employees;

-- UPDATE ~ SET ~ WHERE 
SET SQL_SAFE_UPDATES = 0;

UPDATE employees 
SET salary = 10000
WHERE name = 'evan1'
;

SELECT * FROM employees;


-- 하고자 하는 시나리오
-- 특정 부서의 급여만 인상 (WHERE 필수)

-- WHERE을 안 쓰면, 전 직원 급여 인상
UPDATE employees
SET salary = salary * 1.1
;

SELECT * FROM employees;

UPDATE employees
SET salary = salary * 1.1
WHERE department = 'IT'
;

SELECT * FROM employees;

-- 여러 컬럼 동시 수정
UPDATE employees
SET salary = 100000, department = 'Marketing'
WHERE name = 'evan2'
;

-- 여러 행 동시 수정 
UPDATE employees
SET salary = CASE 
	WHEN id = 1 THEN 5000
    WHEN id = 2 THEN 6000
    WHEN id = 3 THEN 7000
END
WHERE id IN(1, 2, 3)
;

SELECT * FROM employees;


-- 서브쿼리
USE classicmodels;
SELECT * FROM customers;
SELECT * FROM orders;


-- 첫번째 문제 : 주문을 한건도 하지 않은 customerName을 조회하세요
-- HINT : WHERE 절 서브쿼리 이용
-- 메인쿼리 : customerName을 조회하는 것
-- 서브쿼리 : 주문을 한건도 하지 않은 사람

-- NOT IN 연산자 
SELECT customerNumber, customerName FROM customers;
SELECT DISTINCT customerNumber FROM orders; -- 주문을 한건이라도 한 사람

-- 주문을 안한 사람을 조회하면 됨 
SELECT 
	customerNumber, customerName 
FROM 
	customers 
WHERE customerNumber NOT IN (
	SELECT DISTINCT customerNumber FROM orders -- 주문을 한 사람
)
;

-- 주문별 주문 항목 수 통계 구하기
-- orderNumber 주문 항목 수 통계 구하기
--  MAX, MIN, AVG
--   18   1    9
-- FROM 인라인 뷰
SELECT * FROM orderdetails;
SELECT COUNT(*) FROM orderdetails;

-- 주문번호당 주문 건수
SELECT 
	MAX(CNT) AS 최대건수
    , MIN(CNT) AS 최소건수
    , FLOOR(AVG(CNT)) AS 평균건수
FROM (
	SELECT 
		orderNumber, COUNT(orderNumber) AS CNT
	FROM 
		orderdetails
	GROUP BY orderNumber
) A
;




































