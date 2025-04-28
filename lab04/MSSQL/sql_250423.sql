SELECT * FROM production.brands;

-- ����, WHERE ��
-- ���ǰ� ��ġ�ϴ� ������ ��ȸ(���͸�)
-- pandas, ilo, loc, �񱳿����� �� ����  ���

-- p.94
-- ���� ���� ���͸� ��, id, name, gender�� ���
USE lily_book;

-- ��������. "" ����ǥ �ȵ�,' '���� ����ǥ�� ����
SELECT * FROM dbo.customer;
SELECT
		*
FROM dbo.customer
WHERE customer_id = 'c002'
;

-- WHERE�� �ȿ��� �񱳿����� ���ؼ� ���͸�
-- <>, != : �¿찪�� ���� ����
SELECT * FROM sales;

-- sales_amount�� ���� ����ΰ͸� ��ȸ
SELECT * FROM sales WHERE sales_amount > 0;

-- ���ڸ� �Է��� �� �ٻ��ϰ� �Է��غ���
SELECT * FROM sales WHERE sales_amount = 41000

--�����Ͱ� �ƿ� ���� ����, NULL ���·� ���
-- ��ȸ�� �� ��, ��Ȯ�ϰ� �Է����� �ʾƵ� NULL���·� ���

SELECT * FROM customer WHERE customer_id = 'Z002';

-- p. 100, BTWEEN ������,�ڼ� ����
--- 30000�� 40000���� ������ �����ϴ� �� ���
SELECT *
FROM sales
WHERE sales_amount BETWEEN 35000 AND 40000;

SELECT * FROM customer
WHERE customer_id BETWEEN 'c001' AND '003';

SELECT * FROM customer
WHERE last_name BETWEEN '��' AND '��'       -- ���� �־ ����

-- IN ������, �ſ�ſ� ���� ����
-- OR ������ �ݺ��ؼ� ���� �Ⱦ IN �����
SELECT * FROM sales WHERE product_name IN ('�Ź�', 'å'); 

-- Like ������(p.103) : Ű���� �˻� ������(���ǰ� ��ġ�ϴ� ���� ���͸���)
USE BikeStores;

-- lastname�� letter z�� �����ϴ� ��� ���� ���͸�
SELECT * 
FROM sales.customers
WHERE last_name LIKE 'z%'
;
-- lastname�� letter z�� ������ ��� ���� ���͸�
SELECT * 
FROM sales.customers
WHERE last_name LIKE '%z'
;

-- lastname�� letter z�� ���Ե� ��� ���� ���͸�
SELECT * 
FROM sales.customers
WHERE last_name LIKE '%z%'
;

-- IS NULL ������ (�߿���)
-- �����Ͱ� NULL���� �ุ ���͸�
-- ���������� ��ȸ
SELECT *
FROM sales.customers
WHERE phone IS NULL;

-- ��ȸ �ȵ�
SELECT *
FROM sales.customers
WHERE phone = NULL;

-- ��ȸ �ȵ�
SELECT *
FROM sales.customers
WHERE phone = 'NULL';

-- NULL�� �ƴѰ͸� ��ȸ
SELECT *
FROM sales.customers
WHERE phone IS NOT NULL;

-- p.109
-- AND ������ / OR ������
USE lily_book;
SELECT * FROM distribution_center;

-- AND ������
SELECT *
FROM distribution_center
WHERE permission_date > '2022-05-01'
	AND permission_date < '2022-07-31'
	AND status = '������'
;

-- OR ������ (p.113)
-- LIKE �����ڿ� ���� ������ ����
SELECT *
FROM distribution_center
WHERE address LIKE '��⵵ ���ν�%'
	OR address LIKE '�����%'
;

-- ������ �켱���� : () > AND > OR
-- OR �� ���� ó���ϱ� ���ؼ��� ( A OR B ) and C �� �ؾ���

-- ����������
-- IN, NOT IN ���� ����
-- IS NULL, IS NOT NULL ���� ����
SELECT * 
FROM distribution_center
WHERE center_no IN (1,2);

----------------

DROP TABLE sales

CREATE TABLE sales
(
  ��¥        VARCHAR(10),
  ��ǰ��    VARCHAR(10),
  ����        INT,
  �ݾ�        INT
)

INSERT INTO sales VALUES('01��01��','���콺',1,1000)
INSERT INTO sales VALUES('01��01��','���콺',2,2000)
INSERT INTO sales VALUES('01��01��','Ű����',1,10000)
INSERT INTO sales VALUES('03��01��','Ű����',1,10000)

SELECT * FROM sales;

-- �Ϻ��� �Ǹŵ� ������ �ݾ�
SELECT SUM(����) AS ���� FROM sales;

-- ���� ����(p.124)
SELECT ��¥, SUM(����) AS ���� FROM sales;

SELECT ��¥, SUM(����) AS ���� 
FROM sales
GROUP BY ��¥
;

SELECT ��¥, SUM(����) AS ���� 
FROM sales
GROUP BY ��ǰ��
;

SELECT ��¥, ��ǰ��, SUM(����) AS ���� 
FROM sales
GROUP BY ��¥, ��ǰ��
;

SELECT ��¥, ��ǰ��, SUM(����) AS ����, �ݾ�
FROM sales
GROUP BY ��¥, ��ǰ��
;

SELECT ��¥, ��ǰ��, SUM(����) AS ����, SUM(�ݾ�)
FROM sales
GROUP BY ��¥, ��ǰ��
;

-- p.130
-- ������ �ڵ�, �̹� �ߺ����� ������ ����
-- �ֹ���¥, 2023-03-01, 2023-03-05
-- ���� �Ѹ����
/*
SELECT MONTH(order_date), sum(�����)
FROM ���̺�
GROUP BY MONTH(order_date)
;
/*