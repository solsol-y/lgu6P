-- MySQL 급여 관리 시스템 트리거 

SET SQL_SAFE_UPDATES = 0; -- 수정 삭제 가능

-- 1. DB 생성 및 초기화
DROP DATABASE IF EXISTS trigger_demo;
CREATE SCHEMA `trigger_demo` ;
USE trigger_demo;

-- 2. 테이블 생성 
-- 2.1 직원 테이블 생성
CREATE TABLE employees(
    id INT AUTO_INCREMENT PRIMARY KEY				-- 직원 ID, 자동 증가, 기본 키 
    , name VARCHAR(100) NOT NULL					-- 직원 이름, 최대 100자 필수 입력 
    , salary DECIMAL(10, 2) NOT NULL				-- 급ㅇ, 소수점 2자리까지 지원하는 10자리 숫자, 필수 입력 
    , department VARCHAR(50) NOT NULL				-- 부서 이름, 최대 50자, 필수 입력 
    , created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- 생성 시간, 기본값은 현재시간
)
;

-- 2.2 급여 변경 이력(salary_log) 테이블 생성
-- 외래키 참조를 해서 테이블 생성
CREATE TABLE salary_logs (
	id INT AUTO_INCREMENT PRIMARY KEY		-- 로그 ID, 자동 증가, 기본 키 
    , employee_id INT						-- 직원 ID(employees 테이블 ID 참조)
    , old_salary DECIMAL(10, 2)				-- 변경 전 급여
    , new_salary DECIMAL(10, 2)				-- 변경 후 급여
    , change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP		-- 금여 변경 시각, 기본값은 현재 시간 
    , FOREIGN KEY (employee_id) REFRENCES employees(id) ON DELETE CASCADE		-- 중요 : employee_id는 employees 테이블의 id를 참조하며, 직원 삭제 시 연쇄 삭제
)
;


-- 여기서는 관계형을 안 만듬? 이유
-- employees 테이블의 복제본 느낌
-- 2.3 삭제된 직원 기록 테이블 생성
DROP TABLE employee_deletion_logs;
CREATE TABLE employee_deletion_logs (
	id INT AUTO_INCREMENT PRIMARY KEY	-- 로그 ID, 자동 증가, 기본 키, 
    , employee_id INT				-- 삭제된 직원의 ID
    , employee_name VARCHAR(100)	-- 삭제된 직원의 이름 
    , salary DECIMAL(10, 2)			-- 삭제되기 직전 직원 급여
    , department VARCHAR(50)        -- 삭제되기 전 직원의 부서명
    , deldted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- 삭제시간, 기본값은 현재 시간 
)
;


-- 3. 트리거 생성
-- 3.1 급여 변경 트리고
/*
- BEFORE UPDATE : employees  테이블에서 수정이 일어나기 발동
- 조건문의 의미 : 급여(salary)가 변경되었을 때만 작동
- 급여가 변경된 경우, salary_logs 테이블에 직원의 ID, 이전 급여, 새로운 급여를 기록
*/

/*

DELIMITER //		-- 트리거 안에 세미콜론(;)이 있음 
CREATE TRIGGER 트리거이름
BEFORE UPDATE ON 테이블명 
 FOR EACH ROW		-- 업데이트되는 각 행(row)마다 실행 
 BEGIN 
 # 코드 
 
 END //
*/

DELIMITER //		-- 구분자(DELIMITER)를 //로 변경 (트리거 안에 세미콜론(;)이 있기 때문)
CREATE TRIGGER befor_salary_update
BEFORE UPDATE ON employees
 FOR EACH ROW		-- 업데이트되는 각 행(row)마다 실행 
 BEGIN 
	-- 급여가 변경된 경우에만 동작
    IF NEW.salary != OLD.salary THEN
		-- 변경 전 급여(OLS.salary)와 변경 후 급여(NEW_salary_log)를 salary_logs 테이블 
        INSERT INTO salary_logs (employee_id, old_salary, new_salary)
        
        -- employees 테이블
        VALUES (OLD.id, OLD.salary, NEW.salary);
	END IF ;
 
 END //

-- 구분자(DELIMITER)를 기본값(;)으로 복원
DELIMITER ;

-- 트리거 목록 확인 
SHOW TRIGGERS;

-- 트리거 삭제
-- DROP TRIGGER IF EXISTS before_employee_delete;


-- 4. 데이터 추가 
INSERT INTO employees (name, salary, department) VALUES
    ('홍길동', 50000.00, 'Engineering'),
    ('김철수', 45000.00, 'Marketing'),
    ('이영희', 55000.00, 'Sales');

-- 5. 데이터 조회 
SELECT * FROM employees;

SELECT * FROM salary_logs;
SELECT * FROM employee_deletion_logs;

-- 6. 데이터 수정 
-- 급여 인상 
UPDATE employees
SET salary = salary * 1.1
WHERE department = 'Engineering'
;

-- 부서 이동  
UPDATE employees
SET department = 'Sales'
WHERE name = '김철수'
;

-- 데이터 삭제 예제
-- 직원 삭제 
DELETE FROM employees
WHERE name = '이영희'
;










































