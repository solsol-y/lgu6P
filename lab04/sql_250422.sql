-- ���� ������ ���̽� Ȯ��
SELECT DB_NAME(); 

-- �����ͺ��̽� > ���̺�(pandas ������������)
-- �����ͺ��̽� �ȿ� �ִ� ��
---- ���̺� �ܿ���, view, ���ν���, Ʈ���� �� ����
-- SQL, SQEL : E -English
-- ������ ���� ������ �ſ� �����
-- ǥ�� SQL, 99% ���, 1% �ٸ� ==> ������Ÿ���� �� ���̰� �� ����(DB ��������)



-- ������ Ȯ��    -- �Լ��� �빮��, ���� �� �÷��� �ҹ��ڷ� �ۼ��ϸ� ������ ����
USE lily_book;
SELECT * FROM staff;
SELECT * FROM lily_book.dbo.staff;


USE BikeStores;
SELECT * FROM production.brands;

-- �����ͺм��� ��� �� (���� p.36)
-- SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY
-- FROM	A pandas dataframe SELECT column
-- p.42 SELECT ���� FROM ��
USE lily_book;
SELECT employee_id, employee_name, birth_date FROM staff;


-- ��õ
SELECT 
	ep_id                    -- ���ID
	,ep_name,				 -- �����
	birth_date
FROM satff
; -- �ش� ���� �ڵ� �ۼ� �Ϸ�

SELECT * FROM staff;                          -- ���� ���� �ۼ� ����� �ƴϴ�.
SELECT employee_name, employee_id FROM staff; -- �÷� ���� ���� ����

-- �÷� ��Ī
-- �÷��� ������ ����, ���� ���� ���� ==> ������ ���Ǽ� ����
-- ALIAS (AS) : ��Ī
SELECT employee_id, birth_date
FROM staff
;


SELECT employee_id, birth_date AS '�������'  -- ���� ����ǥ, ū����ǥ �Ѵ� ��밡��, ��� �ѱ� ���� ���°� �Ұ���(db���� Ȯ���غ�����)
FROM staff
;

-- DISTINCT �ߺ��� ���� (p.49)
SELECT * FROM staff;

SELECT DISTINCT gender FROM staff;
SELECT gender FROM staff;

SELECT employee_name, gender, position FROM staff;
SELECT DISTINCT position, employee_name, gender FROM staff;   -- ������(�̸� ��) �� �ִٸ� �ߺ��� ���Ű� �ȵ�
SELECT DISTINCT position, gender FROM staff;

-- ���ڿ� �Լ� : �ٸ� DBMS�� ���� ����, ��α׿� ����
SELECT * FROM apparel_product_info;

-- LEFT �Լ� Ȯ��
SELECT product_id, LEFT(product_id, 2) AS ���     -- �÷� �ݺ������� ��� ����
FROM apparel_product_info; 

-- SUBSTRING ���ڿ� �߰��� N��° �ڸ����� N���� �������
-- SUBSTRING(�÷���, ����(N start), ����(N end))
-- ���̽�, �ٸ� ���α׷��� ���� �ε����� 0��°���� ����
-- MS-SQL�� �ε����� 0��°���� �ϴϱ�..?
-- MS-SQL�� �ε����� 1��°���� ����!!
SELECT product_id, SUBSTRING(product_id, 0) AS ���     
FROM apparel_product_info; 

-- CONCAT ���ڿ��� ���ڿ� �̾ ���
SELECT CONCAT(category1, '>', category2, '=', '��', price) AS �׽�Ʈ
FROM apparel_product_info;

-- REPLACE : ���ڿ����� Ư�� ���� ����
-- p.58
--
SELECT product_id, REPLACE(product_id, 'F','A') AS ���
FROM apparel_product_info;

--ISNULL �߿���
-- WHERE���� �Բ� ���� �� ���� Ȱ��Ǵ� ���
-- �����ͻ� ����ġ�� ���� �� ��, �� �ʿ��� �Լ�
SELECT * FROM apparel_product_info;

--- �����Լ� (p.61) : ABS, CEILING, FLOOR, ROUND< POWER, SQRT
-- �ٸ� DBMS, MYSQL, Oracle,
SELECT ROUND(CAST (748.58 AS DECIMAL (6,2)), -3);

-- SIGN : ���, ����, 0 ����
SELECT SIGN(-125), SIGN(0), SIGN(564);

-- CEILING : Ư�� ���ڸ� �ø�ó��
SELECT * FROM sales;
SELECT
	sales_amount_usd
	, CEILING(sales_amount_usd) AS ���
FROM sales;

-- ��¥�Լ� : ���Ĺ��� ������ ����
-- GETDATE : ���Ĺ���
-- DATEADD : ���Ĺ���
-- DATEDIFF(p.255) : �籸���� ���� �� �� ����.
SELECT 
	order_date
	, DATEADD(YEAR, -1, order_date) AS ���1
	, DATEADD(YEAR, +2, order_date) AS ���2
	, DATEADD(DAY, +40, order_date) AS ���2
FROM sales;

-- DATEDIFF (p.72)
SELECT
	order_date
	, DATEDIFF(MONTH, order_date, '2025-04-22') �Լ�������1
	, DATEDIFF(DAY, order_date, '2025-04-22') �Լ�������1 
FROM sales
;

SELECT DATEDIFF(DAY, '1997-02-26', '2025-04-22');

-- �����Լ� (p.74), ������ �Լ�(mysql �� �ڼ��� �ٷ� ����) ==> ��¦ ������.
-- RANK : 
SELECT * FROM student_math_score;
SELECT
	�л�
	, ��������
	, RANK() OVER(ORDER BY �������� DESC) AS rank���
	, DENSE_RANK() OVER(ORDER BY �������� DESC) AS dense_rank���
	, ROW_NUMBER() OVER(ORDER BY �������� DESC) AS row_number���
FROM student_math_score
;

-- PARTITION BY
-- OVER(ORDER BY) : ��ü �߿��� �� ��
-- OVER(PARTITION BY class ORDER BY) : �� ���� ������ �� �ݿ��� �� ��?)
SELECT
	�л�
	, Class
	, ��������
	, DENSE_RANK() OVER(ORDER BY �������� DESC) AS �������
	, DENSE_RANK() OVER(PARTITION BY Class ORDER BY �������� DESC) AS �ݵ��
FROM student_math_score
;

-- CASE��(p.79) : ���ǹ� (IF�� ��� ���)
-- SELECT�� �ۼ� ��, ��ȸ��
-- PL/SQL �� ��쿡��, IF�� ��� ����

-- ���� 0���� �۴ٸ� 'ȯ�Ұŷ�', 0���� ũ�ٸ� '����ŷ�'�� �з�
-- �����ϴ� ���
1)
SELECT * FROM sales;
2)
SELECT 
	sales_amount
FROM sales;
3)
SELECT
	sales_amount
	, CASE WHEN sales_amount < 0 THEN 'ȯ�Ұŷ�'
		   WHEN sales_amount > 0 THEN '����ŷ�'
	END AS ������
FROM sales;

-- p.83 �ǽ��ϸ鼭 ���� ��� ���� ���� ����



--- �����Լ�
