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
