-- ���� ������ ���̽� Ȯ��
SELECT DB_NAME(); 

-- �����ͺ��̽� > ���̺�(pandas ������������)
-- �����ͺ��̽� �ȿ� �ִ� ��
---- ���̺� �ܿ���, view, ���ν���, Ʈ���� �� ����
-- SQL, SQEL : E -English
-- ������ ���� ������ �ſ� �����
-- ǥ�� SQL, 99% ���, 1% �ٸ� ==> ������Ÿ���� �� ���̰� �� ����(DB ��������)

CREATE TABLE promotions(
	promotion_id INT PRIMARY KEY IDENTITY(1,1),
	promotion_name VARCHAR(225) NOT NULL
);

-- ������ �߰�
-- INSERT ����, �������� �е���, �� �����������ӿ�ũ�� �����ؼ� ó��
INSERT INTO promotions(
	promotion_name	
)
VALUES(
	'2025 Summer Promotion'
);

SELECT * FROM promotions; -- ���� ���忡�� �̷��� ����, ����� ���� ����

-- ������ Ȯ�� 
SELECT * FROM staff;