-- 1. ����������� ������� ������� ������������� � ������� users.
select round(avg(timestampdiff(year,birthday_at, curdate()))) from users;

-- 2. ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. ������� ������, ��� ����������
-- ��� ������ �������� ����, � �� ���� ��������.

-- � ������ ������� ������ ���� 29 ������� ���������� �����
-- � ������������ ��� ���� 29 ������� ����������� � 28 ������� �������� ����
select dayname(adddate(birthday_at, interval year(curdate()) - year(birthday_at) year)), count(*) from users group by 1;

-- 3. (�� �������) ����������� ������������ ����� � ������� �������.
-- value = 0 - �� ���������� � ������������
SELECT round(exp(sum(log(value)))) FROM storehouses_products;


