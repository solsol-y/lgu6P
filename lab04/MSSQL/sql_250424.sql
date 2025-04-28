-- HAVING��
CREATE TABLE sales_ch5
(
  order_id		VARCHAR(5),
  order_date	DATE,
  city			VARCHAR(5),
  customer_id	VARCHAR(5),
  sales_amount	INT
)

INSERT INTO sales_ch5 VALUES('1','2023-01-01','����','a001',5000)
INSERT INTO sales_ch5 VALUES('2','2023-04-30','����','a001',10000)
INSERT INTO sales_ch5 VALUES('3','2023-05-10','�λ�','a001',10000)
INSERT INTO sales_ch5 VALUES('4','2023-05-10','�λ�','a002',5000)
INSERT INTO sales_ch5 VALUES('5','2023-06-30','�λ�','a003',5000)

SELECT  * FROM sales_ch5

-- HAVING vs WHERE : ���͸�
-- WHERE : ���� �����͸� �������� ���͸�
-- HAVING : �׷�ȭ ����� ���� ���ĸ� �������� ���͸�
-- ������ ���� ���ϰ�, �� ���� 20,000�� �ʰ��ϴ� ���� ���ϰ� ����
SELECT 
	customer_id                 -- �ߺ��Ǵ� ���� �ټ� �����ϴ°�?
	, SUM(sales_amount) AS ����
FROM sales_ch5
GROUP BY customer_id
HAVING SUM(sales_amount) > 20000
;

-- WHERE ���Ұ�
-- WHERE �������� �����Լ�(SUM, AVG ��)�� ���� ����� �� ����
-- WHERE�� �׷��� ����� �� �ܰ迡�� �۵�

/* -- MS-SQL, ORACLE ���� ��� ������ ������ ��

SELECT CASE WHEN ==> �׷�
	, ��ġ�ʵ�
FROM ���̺�
GROUP BY 1  -- ���ڸ� �Է��ϸ� �ν� ���� 
*/

-- ORDER BY
SELECT 
	customer_id                 -- �ߺ��Ǵ� ���� �ټ� �����ϴ°�?
	, SUM(sales_amount) AS ����
FROM sales_ch5
GROUP BY customer_id
ORDER BY ���� DESC             -- DESC ��������, ����Ʈ�� ��������, ASC ��������
;



/*
-- DB�� �����͸� ó���ϴ� ����
-- FROM ==> SELECT  (X)
FROM ==> WHERE ==>GROUP BY - HAVING ==> SELECT ==> ORDER BY
*/

-- ��������(p.158)

/***********************************************************
�� ������ 7.2.1
�� product_info : ��ǰ�� ���� ����
�� ��� : CREATE���� INSERT INTO�� �������ٱ��� �巡�� �� ����(����ŰF5)�����ּ���.
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
INSERT INTO product_info VALUES ('p001','A��Ʈ�� 14inch','c01',1500000,'������','2022-10-02')
INSERT INTO product_info VALUES ('p002','B��Ʈ�� 16inch','c01',2000000,'��������','2022-11-30')
INSERT INTO product_info VALUES ('p003','C��Ʈ�� 16inch','c01',3000000,'������','2023-03-11')
INSERT INTO product_info VALUES ('p004','D��Ź��','c01',1500000,'������','2021-08-08')
INSERT INTO product_info VALUES ('p005','E������','c01',1800000,'������','2022-08-09')
INSERT INTO product_info VALUES ('p006','�ڵ������̽�','c02',21000,'������','2023-04-03')
INSERT INTO product_info VALUES ('p007','��Ʈ�� ������ȣ�ʸ�','c02',15400,'������','2023-04-03')

-- SELECT  * FROM product_info



/***********************************************************
�� ������ 7.3.1
�� category_info : ��ǰ ī�װ��� ���� ����
�� ��� : CREATE���� INSERT INTO�� �������ٱ��� �巡�� �� ����(����ŰF5)�����ּ���.
************************************************************/

CREATE TABLE category_info
(
  category_id   VARCHAR(10),
  category_name VARCHAR(10)
)

INSERT INTO category_info VALUES ('c01','������ǰ')
INSERT INTO category_info VALUES ('c02','�׼�����')

-- SELECT  * FROM category_info



/***********************************************************
�� ������ 7.4.1
�� event_info : �̺�Ʈ ��ǰ�� ���� ����
�� ��� : CREATE���� INSERT INTO�� �������ٱ��� �巡�� �� ����(����ŰF5)�����ּ���.
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
-- ������ Ȯ��
SELECT * FROM product_info;
SELECT * FROM category_info;
SELECT * FROM event_info;


-- p.161
-- ��ǰ ������ �ִ� product_info ���̺�
-- ��ǰ ī�װ��� �ִ� category_info ���̺�
-- �̺�Ʈ ��ǰ�� ���� ���� event_info ���̺�

-- ���� �ٸ� ���̺� ==> ���̺� ���� (�Ϲ����� ���)
-- �������� vs ���̺� ���� (�����Ͼ�, �ΰ��� ���� ��)
-- �����ȹ ���ؼ� , �� ������ ������ �� �� �� �־�� �Ѵ�. (�����Ͼ� �����)

SELECT 
	product_id
	, product_name
	, category_id
	, (SELECT category_name FROM category_info WHERE category_id = p.category_id)
FROM product_info p;  -- �Ϲ������� ���̺� ���� ���̺��� �̸��� ALIAS ó��

SELECT * FROM category_info ;

SELECT 	product_id
	, product_name
FROM product_info p
Join category_info c
	on p.category_id = c.category_id;



-- FROM�� ��������
-- data1 = data.����
-- data2 = data1.����
-- SELECT FROM (SELECT FROM (SELECT FROM))
-- product_info ���̺�, ī�װ����� ��ǰ�� ������ 5�� �̻��� ī�װ��� ���
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

-- WHERE�� �������� (p.167)
-- �������� ���ϰ� ���� : ���� �� ��ġ����
-- product_info T, ������ǰ ī�װ��� ����ϰ� �ʹ�.
-- ��������, �������� �����ؼ� ó��
-- �������� : ������ǰ ī�װ��� ��ȸ
-- �������� : product_info ���̺� ��ȸ

-- ������ǰ ī�װ� id ==> c01
SELECT * FROM product_info;
SELECT category_id FROM category_info WHERE category_name = '������ǰ'

--
category_test = input()
SELECT * FROM product_info WHERE category_id <> (
	SELECT category_id FROM category_info WHERE category_name = '�׼�����'
);
SELECT * FROM product_info WHERE category_id = 'c01'


-- p.168
-- product_info T, event_id �÷��� e2�� ���Ե� ��ǰ�� ������ ���
-- �������� : product_info T ��ǰ�� ���� ���
-- �������� : event_id �÷��� e2�� �ش��ϴ� ��ǰ
SELECT * FROM product_info WHERE product_id IN ('p003', 'p004', 'p005');

SELECT product_id FROM event_info WHERE event_id = 'e2';

-- ���� �� ���� ��ġ�� 

-- ERD(Entity-Relationship Diagram)
-- ?

-- ���̺��� ����
-- LEFT JOIN, RIGHT JOIN, OUTER JOIN (FULL JOIN), INNER JOIN
-- LEFT OUTER JOIN, RIGHT OUTER JOIN
-- p.185
SELECT *
FROM product_info pi
LEFT
JOIN category_info ci ON pi.category_id =ci.category_id
;


-- UNION ������(p.187): ���̺� �Ʒ��� ���̱�
-- UNION (�ߺ� �� ����) vs UNION ALL(�ߺ� �� �������� ���� ä �״�� ���)
-- JOIN : �ƿ� �ٸ� ���� ���̴� ��
-- UNION : ������ �Ǵ� id�� ���� �� ���



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

-- �������� �߰� ����
USE BikeStores;

-- ���̺�
SELECT * FROM sales.orders;

-- ���� : 2017�⿡ ���� ���� �ֹ��� ó���� ������ ó���� ��� �ֹ� ��ȸ
-- 1. ��� �ֹ� ���� ó��
-- 2. HWERE �������� ����ؼ� 2017�� �ִ� �ֹ� ó�� ���� ã��
-- 3. TOP 1�� Groupby ���
-- 4. Ȱ���Լ� : YEAR, COUNT(*)

-- �������� : ��� �ֹ� ���� ǥ��
SELECT * FROM sales.orders WHERE staff.id = 3;

-- �������� : 2017�⿡ ���� ���� �ֹ��� ó���� ���� ã��
-- staff.id ����ϰ� ������ ���� ã��
SELECT staff_id, count(*) AS �ֹ��Ǽ�
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

-- ��ġ��
-- �����μ� ��û���� : 2017�⿡ ���� ���� �ֹ��� ó���� ������ ó���� ��� �ֹ� ��ȸ
SELECT * 
FROM sales.orders 
WHERE staff_id = (
	SELECT TOP 1 staff_id
	FROM sales.orders
	WHERE YEAR(order_date) = 2017
	GROUP BY staff_id
	ORDER BY COUNT(*) DESC
);


-- ���̺� 2��
SELECT * FROM production.products;
SELECT * FROM sales.order_items;

--- ���� : �� ���� �ֹ����� ���� ��ǰ���� ������ ��ȸ�Ͻÿ�
-- �ߺ��� �����ϴ� ���: SELECT DISTINCT

-- �������� : products ���̺��� ��� �����͸� ��ȸ
SELECT * FROM production.products;

-- �������� : �� ���� �ֹ����� ���� ��ǰ ����
SELECT * FROM sales.order_items;

SELECT DISTINCT product_id FROM sales.order_items;  -- �ֹ��� �ּ� 1�� �̻��� �߻��� product_id

SELECT *
FROM sales.order_items
WHERE product_id NOT IN(
	SELECT DISTINCT product_id FROM sales.order_items
	);






