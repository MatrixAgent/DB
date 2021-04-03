-- 2. (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ,
-- имя пользователя и его пароль. Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name.
-- Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.

CREATE VIEW username AS SELECT id, name FROM accounts;

-- Далее хочется написать так, но это не работает
grant select on shop.* to shop_read;
revoke select on shop.accounts from shop_read;

-- Я не знаю как дать доступ на чтение ко всему кроме таблицы accounts
-- кроме как перечислять все объекты:
grant select on shop.users to shop_read;
grant select on shop.username to shop_read;
...

-- подскажите, пожалуйста, можно ли сделать проще?
