-- 1. ѕодсчитайте средний возраст пользователей в таблице users.
select round(avg(timestampdiff(year,birthday_at, curdate()))) from users;

-- 2. ѕодсчитайте количество дней рождени€, которые приход€тс€ на каждый из дней недели. —ледует учесть, что необходимы
-- дни недели текущего года, а не года рождени€.

-- ¬ данном решении учтены даты 29 феврал€ високосных годов
-- ¬ невисокосный год дата 29 феврал€ переводитс€ в 28 феврал€ текущего года
select dayname(adddate(birthday_at, interval year(curdate()) - year(birthday_at) year)), count(*) from users group by 1;

-- 3. (по желанию) ѕодсчитайте произведение чисел в столбце таблицы.
-- value = 0 - не учавствуют в произведении
SELECT round(exp(sum(log(value)))) FROM storehouses_products;


