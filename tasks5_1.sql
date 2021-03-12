-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
update users set created_at=NOW(), updated_at=NOW();
-- или
update users set created_at=NOW() where created_at is null;
update users set updated_at=NOW() where updated_at is null;

-- 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое
-- время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
ALTER TABLE users
ADD COLUMN f1 DATETIME,
ADD COLUMN f2 DATETIME;

update users set f1=str_to_date(created_at, '%d.%m.%Y %T'), f2=str_to_date(updated_at, '%d.%m.%Y %T');

ALTER TABLE users
DROP COLUMN updated_at,
DROP COLUMN created_at,
RENAME COLUMN f1 TO created_at,
RENAME COLUMN f2 TO updated_at;

-- 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар
-- закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились
-- в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех записей.

select * from storehouses_products order by value=0, value -- ошибки на имя поля value не дает

-- 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august)
select * from users where lower(monthname(birthday_at)) in ('may', 'august')

-- 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);
