-- 1. Подсчитайте средний возраст пользователей в таблице users.
select round(avg(timestampdiff(year,birthday_at, curdate()))) from users;

-- 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы
-- дни недели текущего года, а не года рождения.

-- В данном решении учтены даты 29 февраля високосных годов
-- В невисокосный год дата 29 февраля переводится в 28 февраля текущего года
select dayname(adddate(birthday_at, interval year(curdate()) - year(birthday_at) year)), count(*) from users group by 1;

-- 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы.
-- value = 0 - не учавствуют в произведении
SELECT round(exp(sum(log(value)))) FROM storehouses_products;
