-- Chapter 9�� 
-- �ǽ� ������ �Ұ� 
USE lily_book_testdb;

-- ���̺� Ȯ�� 
SELECT * FROM sales;
SELECT * FROM customer;

-- ���̺� �⺻���� Ȯ�� �ϴ� ��ɾ�
EXEC sp_help 'sales';

/***********************************************************
�� ���� Ʈ���� (p.203)
************************************************************/

-- �Ⱓ�� ���� ��Ȳ
-- Ʈ���� : �ð迭 �м��� ����
-- ��� �÷� : invoicedate, �����, �ֹ�����, �ֹ��Ǽ�, �ֹ�����
-- Ȱ�� �Լ� : SUM(), COUNT()
SELECT 
	CONVERT(DATE, invoicedate) AS invoicedate
	, ROUND(SUM(unitprice*quantity), 2) AS �����
	, SUM(quantity) AS �ֹ�����
	, COUNT(DISTINCT invoiceno) AS �ֹ��Ǽ�
	, COUNT(DISTINCT customerid) AS �ֹ�����
FROM sales
GROUP BY CONVERT(DATE, invoicedate)
ORDER BY invoicedate
;


-- ������ ���� ��Ȳ
-- ��� �÷� : country, �����, �ֹ�����, �ֹ��Ǽ�, �ֹ�����
-- Ȱ�� �Լ� : SUM(), COUNT()
SELECT 
	country
	, ROUND(SUM(unitprice*ABS(quantity)), 2) AS �����
	, SUM(quantity) AS �ֹ�����
	, COUNT(DISTINCT invoiceno) AS �ֹ��Ǽ�
	, COUNT(DISTINCT customerid) AS �ֹ�����
FROM sales
GROUP BY country
ORDER BY 1
;

-- ������ x ��ǰ�� ���� ��Ȳ 
-- ��� �÷� : country, stockcode, �����, �ֹ�����, �ֹ��Ǽ�, �ֹ�����
-- Ȱ�� �Լ� : SUM(), COUNT()
SELECT 
	country
	, stockcode
	, ROUND(SUM(unitprice*ABS(quantity)), 2) AS �����
	, SUM(quantity) AS �ֹ�����
	, COUNT(DISTINCT invoiceno) AS �ֹ��Ǽ�
	, COUNT(DISTINCT customerid) AS �ֹ�����
FROM sales
GROUP BY country, stockcode
ORDER BY 2, 1                   -- ���ڴ� �÷� �ε��� ��ȣ
;

-- Ư�� ��ǰ ���� ��Ȳ
-- ��� �÷� : �����, �ֹ�����, �ֹ��Ǽ�, �ֹ�����
-- Ȱ�� �Լ� : SUM(), COUNT()
-- �ڵ�� : 21615
SELECT 
	ROUND(SUM(unitprice*quantity), 2) AS �����
	, SUM(quantity) AS �ֹ�����
	, COUNT(DISTINCT invoiceno) AS �ֹ��Ǽ�
	, COUNT(DISTINCT customerid) AS �ֹ�����
FROM sales
WHERE stockcode = '21615'
;

-- Ư�� ��ǰ�� �Ⱓ�� ���� ��Ȳ 
-- ��� �÷� : invoicedate, �����, �ֹ�����, �ֹ��Ǽ�, �ֹ�����
-- Ȱ�� �Լ� : SUM(), COUNT()
-- �ڵ�� : 21615, 21731
SELECT 
	CONVERT(DATE, invoicedate) AS invoicedate
	, ROUND(SUM(unitprice*quantity), 2) AS �����
	, SUM(quantity) AS �ֹ�����
	, COUNT(DISTINCT invoiceno) AS �ֹ��Ǽ�
	, COUNT(DISTINCT customerid) AS �ֹ�����
FROM sales
WHERE stockcode IN ('21615', '21731')
GROUP BY CONVERT(DATE, invoicedate)
;



/***********************************************************
�� �̺�Ʈ ȿ�� �м� (p.213)
************************************************************/

-- �̺�Ʈ ȿ�� �м� (�ñ⿡ ���� ��)
-- 2011�� 9/10 ~ 2011�� 9/25���� �� 15�ϵ��� ������ �̺�Ʈ�� ���� Ȯ�� 
-- ��� �÷� : �Ⱓ ����, �����, �ֹ�����, �ֹ��Ǽ�, �ֹ����� 
-- Ȱ�� �Լ� : CASE WHEN, SUM(), COUNT()
-- �Ⱓ ���� �÷��� ���� ���� : �̺�Ʈ �Ⱓ, �̺�Ʈ �񱳱Ⱓ(�������Ⱓ)
SELECT 
    CASE 
        WHEN CONVERT(DATE, invoicedate) BETWEEN '2011-09-10' AND '2011-09-25' THEN '�̺�Ʈ �Ⱓ'
        WHEN CONVERT(DATE, invoicedate) BETWEEN '2011-08-10' AND '2011-08-25' THEN '�̺�Ʈ �񱳱Ⱓ'
        ELSE '��Ÿ'
    END AS �Ⱓ����
	, SUM(unitprice*quantity) AS �����
FROM sales
GROUP BY CASE 
        WHEN CONVERT(DATE, invoicedate) BETWEEN '2011-09-10' AND '2011-09-25' THEN '�̺�Ʈ �Ⱓ'
        WHEN CONVERT(DATE, invoicedate) BETWEEN '2011-08-10' AND '2011-08-25' THEN '�̺�Ʈ �񱳱Ⱓ'
        ELSE '��Ÿ'
    END
;


-- �̺�Ʈ ȿ�� �м� (�ñ⿡ ���� ��)
-- 2011�� 9/10 ~ 2011�� 9/25���� Ư�� ��ǰ�� �ǽ��� �̺�Ʈ�� ���� ���� Ȯ��
-- ��� �÷� : �Ⱓ ����, �����, �ֹ�����, �ֹ��Ǽ�, �ֹ����� 
-- Ȱ�� �Լ� : CASE WHEN, SUM(), COUNT()
-- �Ⱓ ���� �÷��� ���� ���� : �̺�Ʈ �Ⱓ, �̺�Ʈ �񱳱Ⱓ(�������Ⱓ)
-- ��ǰ�� : 17012A, 17012C, 17084N
SELECT 
    CASE 
        WHEN CONVERT(DATE, invoicedate) BETWEEN '2011-09-10' AND '2011-09-25' THEN '�̺�Ʈ �Ⱓ'
        WHEN CONVERT(DATE, invoicedate) BETWEEN '2011-08-10' AND '2011-08-25' THEN '�̺�Ʈ �񱳱Ⱓ'
        ELSE '��Ÿ'
    END AS �Ⱓ����
	, SUM(unitprice*quantity) AS �����
	, SUM(quantity) AS �ֹ�����
	, COUNT(DISTINCT invoiceno) AS �ֹ��Ǽ�
	, COUNT(DISTINCT customerid) AS �ֹ�����
FROM sales
WHERE  (CONVERT(DATE, invoicedate) BETWEEN '2011-09-10' AND '2011-09-25' 
		OR CONVERT(DATE, invoicedate) BETWEEN '2011-08-10' AND '2011-08-25') 
		AND stockcode IN ('17012A', '17012C', '17084N')    --  ������ �켱 ����, () > AND > OR 
GROUP BY CASE 
        WHEN CONVERT(DATE, invoicedate) BETWEEN '2011-09-10' AND '2011-09-25' THEN '�̺�Ʈ �Ⱓ'
        WHEN CONVERT(DATE, invoicedate) BETWEEN '2011-08-10' AND '2011-08-25' THEN '�̺�Ʈ �񱳱Ⱓ'
        ELSE '��Ÿ'
    END
;


/***********************************************************
�� CRM �� Ÿ�� ��� (p.217)
************************************************************/

-- Ư�� ��ǰ ���� �� ����
-- ���� : 2010.12.1 - 2010.12.10�ϱ��� Ư�� ��ǰ ������ �� ���� ���
-- ��� �÷� : �� ID, �̸�, ����, �������, ���� ����, ���, ���� ä��
-- HINT : �ζ��� �� ��������, LEFT JOIN Ȱ��
-- Ȱ���Լ� : CONCAT()
-- �ڵ�� : 21730, 21615

-- Ư�� ��ǰ�� ������ �� ������ ����ϰ� ����
SELECT * FROM sales;
SELECT * FROM customer;

-- ��ID : 16565
SELECT * FROM customer WHERE mem_no = '16565';

-- ������ �� ����, �⺻Ű�� �ܷ�Ű�� �׻� ����
-- ������ �Ǵ� ���̺��� �⺻Ű�� �ߺ����� ������ ����� ��
-- SALES �������� customerid �ߺ����� ��� �����ؼ� ��ġ �⺻Ű�� �����ϴ� ���̺� ���·� ����
SELECT DISTINCT customerid
FROM sales
WHERE stockcode IN ('21730', '21615')
	AND CONVERT(DATE, invoicedate) BETWEEN '2010-12-01' AND '2010-12-18'
;

SELECT * 
FROM (
	SELECT DISTINCT customerid
	FROM sales
	WHERE stockcode IN ('21730', '21615')          -- Ư�� ��ǰ�� ������ �ڵ�
		AND CONVERT(DATE, invoicedate) BETWEEN '2010-12-01' AND '2010-12-18'
	) s
LEFT 
JOIN (
	SELECT 
		mem_no
		, CONCAT(last_name, first_name) AS customer_name
		, gd
		, birth_dt
		, entr_dt
		, grade 
		, sign_up_ch
	FROM customer	
) c
ON s.customerid = c.mem_no
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


-- �̱��� �� ���� Ȯ��
-- ���� : ��ü ����� ���� �� �߿��� ���� �̷��� ���� ���� ���� �̷��� �ִ� �� ���� ���� 
-- ��� �÷� : non_purchaser, mem_no, last_name, first_name, invoiceno, stockcode, invoicedate, unitprice, customerid
-- HINT : LEFT JOIN
-- Ȱ���Լ� : CASE WHEN, IS NULL, 

-- ��ü ������ �̱��� ���� ��� 
-- ��� �÷� : non_purchaser, total_customer
-- HINT : LEFT JOIN
-- Ȱ�� �Լ� : COUNT(), IS NULL

-- CUSTOMER LEFT JOIN SALES
SELECT 
	COUNT(DISTINCT CASE WHEN s.customerid IS NULL THEN c.mem_no END) AS non_purchaser
	, COUNT(DISTINCT mem_no) AS total_customer
FROM customer c 
LEFT JOIN sales s ON c.mem_no = s.customerid
;


/***********************************************************
�� �� ��ǰ ���� ���� (p.227)
************************************************************/

-- ���� ��� ��ǥ Ȱ���ϱ� 
-- ���� �����ǥ ���� : ATV, AMV, Avg.Frq, Avg.Units
-- ���� : sales �������� ���� �����ǥ, ATV, AMV, Avg.Frq, Avg.Units �˰� ����
-- ��� �÷� : �����, �ֹ�����, �ֹ��Ǽ�, �ֹ�����, ATV, AMV, Avg.Frq, Avg.Units
-- Ȱ���Լ� : SUM(), COUNT()

SELECT 
	ROUND(SUM(unitprice * quantity) / COUNT(DISTINCT invoiceno), 2) AS ATV -- �ֹ��Ǽ�
	, ROUND(SUM(unitprice * quantity) / COUNT(DISTINCT customerid), 2) AS AMV -- �ֹ�����
	, COUNT(DISTINCT invoiceno) * 1.00 / COUNT(DISTINCT customerid) * 1.00 AS AvgFrq
FROM sales;

-- ���� : ���� �� ���� ���� �����ǥ, ATV, AMV, Avg.Frq, Avg.Units �˰� ����
-- ��� �÷� : ����, ��, �����, �ֹ�����, �ֹ��Ǽ�, �ֹ�����, ATV, AMV, Avg.Frq, Avg.Units
-- Ȱ���Լ� : SUM(), COUNT(), YEAR, MONTH
SELECT 
	YEAR(invoicedate) AS ����
	, MONTH(invoicedate) AS ��
	, ROUND(SUM(unitprice * quantity) / COUNT(DISTINCT invoiceno), 2) AS ATV
FROM sales
GROUP BY YEAR(invoicedate), MONTH(invoicedate)
HAVING ROUND(SUM(unitprice * quantity) / COUNT(DISTINCT invoiceno), 2) >= 400
ORDER BY 1, 2
;

-- 
SELECT 
	YEAR(invoicedate) AS ����
	, MONTH(invoicedate) AS ��
	, ROUND(SUM(unitprice * quantity) / COUNT(DISTINCT invoiceno), 2) AS ATV
FROM sales
GROUP BY YEAR(invoicedate), MONTH(invoicedate)
-- HAVING ROUND(SUM(unitprice * quantity) / COUNT(DISTINCT invoiceno), 2) >= 400
ORDER BY 1, 2
;


-- ���� ��� �� : 400 ��ſ� ATV ��� ����־ ���͸�
-- WITH �� �ϴ� ���, �ζ��� �� ����ؼ� �ϴ� ��� 


/***********************************************************
�� �� ��ǰ ���� ���� (p.230)
************************************************************/

-- Ư�� ���� ����Ʈ���� ��ǰ Ȯ��
-- ���� : 2011�⿡ ���� ���� �Ǹŵ� ��ǰ TOP 10�� ���� Ȯ�� 
-- ��� �÷� : stockcode, description, qty
-- Ȱ���Լ� : TOP 10, SUM(), YEAR()
-- 
/* �Ϲ����� SQL ���� ���� 
SELECT FROM GROUP BY ~~ �������� �ǸŰ��� ==> A1
SELECT ROW_NUMBER() FROM (A1) ==> A2 
SELECT ~~ FROM (A2) WHERE RNK <= 10 */

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




-- ������ ����Ʈ���� ��ǰ Ȯ��
-- ���� : �������� ���� ���� �Ǹŵ� ��ǰ ������ ������ ���ϰ� ����
-- ��� �÷� : RNK, country, stockcode, description, qty
-- HINT : �ζ��� �� ��������
-- Ȱ���Լ� : ROW_NUMBER() OVER(PARTITION BY...), SUM()
SELECT 
	ROW_NUMBER() OVER(PARTITION BY country ORDER BY qty DESC) as rnk
	, a.*
FROM (
	SELECT 
		country
		, stockcode 
		, CONVERT(VARCHAR(255), description) AS description
		, SUM(quantity) as qty 
	FROM sales 
	WHERE YEAR(invoicedate) = '2011'
	GROUP BY country, stockcode, CONVERT(VARCHAR(255), description)
) a
ORDER BY 2, 1
;

-- 20�� ���� ���� ����Ʈ���� ��ǰ Ȯ�� 
-- ���� : 20�� ���� ���� ���� ���� ������ TOP 10�� ���� Ȯ�� 
-- ��� �÷� : RNK, stockcode, description, qty
-- HINT : �ζ��� �� ��������, �ζ��� �� �������� �ۼ� ��, LEFT JOIN �ʿ�
-- Ȱ���Լ� : ROW_NUMBER() OVER(PARTITION BY...), SUM(), YEAR()
-- CONVERT(VARCHAR(255), description) AS description 
-- �Ʒ� �ڵ��� ������ : �ǽð� ������Ʈ �Ұ�
-- ������ Ÿ���� �ʿ� (�ڵ�ȭ)
SELECT 
	stockcode
	, CONVERT(VARCHAR(255), description) AS description 
	, SUM(quantity) AS qty
FROM sales s 
LEFT 
JOIN customer c 
  ON s.customerid = c.mem_no
WHERE c.gd = 'F'
	AND 2025-YEAR(c.birth_dt) BETWEEN '20' AND '29'
GROUP BY stockcode, CONVERT(VARCHAR(255), description) 
HAVING SUM(quantity) >= 1000
ORDER BY qty DESC
;

-- ���� ��� Ÿ����
SELECT * 
FROM (
	SELECT 
		ROW_NUMBER() OVER(ORDER BY qty DESC) AS rnk
		, stockcode
		, description
		, qty
	FROM (
		SELECT 
			stockcode
			, CONVERT(VARCHAR(255), description) AS description 
			, SUM(quantity) AS qty
		FROM sales s 
		LEFT 
		JOIN customer c 
		  ON s.customerid = c.mem_no
		WHERE c.gd = 'F'
			AND 2025-YEAR(c.birth_dt) BETWEEN '20' AND '29'
		GROUP BY stockcode, CONVERT(VARCHAR(255), description) 
	) a
) aa
WHERE rnk <= 10
;



/***********************************************************
�� �� ��ǰ ���� ���� (p.238)
************************************************************/

-- Ư�� ��ǰ�� �Բ� ���� ���� ������ ��ǰ Ȯ�� 
-- ���� : Ư�� ��ǰ(stockcode='20725')�� �Բ� ���� ���� ������ TOP 10�� ���� Ȯ��
-- ��� �÷� : stockcode, description, qty 
-- HINT : INNER JOIN
-- Ȱ���Լ� : SUM()
-- Ư�� ��ǰ�� ������ �ŷ� ���� 
SELECT DISTINCT invoiceno
FROM sales 
WHERE stockcode = '20725'
;


-- SELF JOIN 
-- �츮�� �ƴ� JOIN�� ���´� �ΰ��� ���� �ٸ� ���̺�
-- �������� Ȯ���ϰ� ���� �� �ַ� ���
---- �������̺� (�μ���, ���) ���� ���踦 �ľ��� �� �ַ� Ȱ��

-- �Ʒ� �ڵ�
-- �� �ڵ忡��, ��ǰ�� LUNCH�� ���Ե� ��ǰ�� ���� 
SELECT TOP 10
	s.stockcode
	, CONVERT(VARCHAR(255), s.description)
	, SUM(quantity) as qty 
FROM sales s 
INNER 
JOIN (
	SELECT DISTINCT invoiceno 
	FROM sales 
	WHERE stockcode = '20725'
) 
ON s.invoiceno = i.invoiceno
WHERE s.stockcode <> '20725'
	AND CONVERT(VARCHAR(255), s.description) NOT LIKE '%LUNCH%'
GROUP BY s.stockcode, CONVERT(VARCHAR(255), s.description)
ORDER BY qty DESC 

/***********************************************************
�� �� ��ǰ ���� ���� (p.244)
************************************************************/

-- �⺻���� ���� : �� ȸ�簡 ������? 
-- �籸�Ű� �󸶳� ����ϰ� ���� �Ͼ�°�? 
-- �籸���� ������� �ݾ��� ��� �����ϴ°�? 

-- �籸�� ���� ���� Ȯ��
-- ��� 1 : ������ ������ �� ���� ���
-- ���� : ���θ��� �籸�� ���� Ȯ�� 
-- ��� �÷� : repurchaser_count
-- HINT : �ζ��� ��
-- Ȱ�� �Լ� : COUNT()
SELECT 
	customerid
	, COUNT(DISTINCT invoicedate) AS freq
FROM sales 
WHERE customerid <> '' -- ��ȸ���� �ش��ϴ� ���� �����ϴ� ����
GROUP BY customerid 
HAVING COUNT(DISTINCT invoicedate) >= 2
;

-- �� ���� 
SELECT COUNT(customerid) AS �籸�Ű���
	FROM (
	SELECT 
		customerid
		, COUNT(DISTINCT invoicedate) AS freq
	FROM sales 
	WHERE customerid <> '' -- ��ȸ���� �ش��ϴ� ���� �����ϴ� ����
	GROUP BY customerid 
	HAVING COUNT(DISTINCT invoicedate) >= 2
) a
;


-- ��� 2 : ������ ������ �ϼ��� ������ �ű�� ���
-- ���� : ���θ��� �籸�� ���� Ȯ�� 
-- ��� �÷� : repurchaser_count
-- HINT : �ζ��� ��
-- Ȱ�� �Լ� : COUNT(), DENSE_RANK() OVER(PARTITION BY...)


-- ���ټ� �� ��ȣƮ �м�
-- 2010�� ���� �̷��� �ִ� 2011�� ������ Ȯ�� 
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

SELECT COUNT(DISTINCT customerid)
FROM sales 
WHERE customerid <> ''
	AND YEAR(invoicedate) = '2010'
;

SELECT 820 * 1.00 / 948 * 1.00;

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


-- ù ���ſ� �籸�� �Ⱓ�� ���� ��� 
-- DATEDIFF()



-- ����
-- �ַ� �ٷ� �� : �м��� ���� ��ȸ!!
-- ���������� ����!! ���� �ͼ����� ����

-- ������ ���� ����
-- ��������, ������ �Լ�
-- ���̺� ����, �Է�, ������Ʈ, ���� (CRUD, CREATE, READ, UPDATE, DELETE)
-- ERD�� ���� ����
-- Ʈ���� ���� ���� (streamlit) 