-- 1. ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.
update users set created_at=NOW(), updated_at=NOW();
-- ���
update users set created_at=NOW() where created_at is null;
update users set updated_at=NOW() where updated_at is null;

-- 2. ������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������
-- ����� ���������� �������� � ������� 20.10.2017 8:10. ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.
ALTER TABLE users
ADD COLUMN f1 DATETIME,
ADD COLUMN f2 DATETIME;

update users set f1=str_to_date(created_at, '%d.%m.%Y %T'), f2=str_to_date(updated_at, '%d.%m.%Y %T');

ALTER TABLE users
DROP COLUMN updated_at,
DROP COLUMN created_at,
RENAME COLUMN f1 TO created_at,
RENAME COLUMN f2 TO updated_at;

-- 3. � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 0, ���� �����
-- ���������� � ���� ����, ���� �� ������ ������� ������. ���������� ������������� ������ ����� �������, ����� ��� ����������
-- � ������� ���������� �������� value. ������ ������� ������ ������ ���������� � �����, ����� ���� �������.

select * from storehouses_products order by value=0, value -- ������ �� ��� ���� value �� ����

-- 4. (�� �������) �� ������� users ���������� ������� �������������, ���������� � ������� � ���. ������ ������ � ���� ������ ���������� �������� (may, august)
select * from users where lower(monthname(birthday_at)) in ('may', 'august')

-- 5. (�� �������) �� ������� catalogs ����������� ������ ��� ������ �������. SELECT * FROM catalogs WHERE id IN (5, 1, 2); ������������ ������ � �������, �������� � ������ IN.
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);
