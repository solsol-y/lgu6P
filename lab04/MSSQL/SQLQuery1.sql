-- 현재 데이터 베이스 확인
SELECT DB_NAME(); 

-- 데이터베이스 > 테이블(pandas 데이터프레임)
-- 데이터베이스 안에 있는 것
---- 테이블 외에도, view, 프로시저, 트리거 등 포함
-- SQL, SQEL : E -English
-- 문법이 영어 문법과 매우 흡사함
-- 표준 SQL, 99% 비슷, 1% 다름 ==> 데이터타입할 때 차이가 좀 있음(DB 종류마다)

CREATE TABLE promotions(
	promotion_id INT PRIMARY KEY IDENTITY(1,1),
	promotion_name VARCHAR(225) NOT NULL
);

-- 데이터 추가
-- INSERT 구문, 웹개발자 분들은, 각 웹개발프레임워크와 연동해서 처리
INSERT INTO promotions(
	promotion_name	
)
VALUES(
	'2025 Summer Promotion'
);

SELECT * FROM promotions; -- 실제 현장에서 이렇게 쓰면, 사수가 갈굴 예정

-- 데이터 확인 
SELECT * FROM staff;