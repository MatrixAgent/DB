-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"

-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
CREATE DEFINER=`root`@`localhost` FUNCTION `hello`() RETURNS varchar(20) CHARSET utf8mb4
    NO SQL
BEGIN
    declare t varchar(20);
    set t=curtime() + 0;
RETURN case when t>=60000 and t<120000 then 'Доброе утро'
    when t>=120000 and t<180000 then 'Добрый день'
    when t>=180000 then 'Добрый вечер'
    else 'Доброй ночи' end;
END

-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих
-- полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того,
-- чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.
CREATE DEFINER=`root`@`localhost` TRIGGER `products_BEFORE_INSERT` BEFORE INSERT ON `products` FOR EACH ROW BEGIN
    if isnull(new.name) + isnull(new.description) = 2 then
        signal sqlstate '45000'
        set message_text='name and description can''t be both null.';
    end if;        
END

CREATE DEFINER=`root`@`localhost` TRIGGER `products_BEFORE_UPDATE` BEFORE UPDATE ON `products` FOR EACH ROW BEGIN
    if isnull(new.name) + isnull(new.description) = 2 then
        signal sqlstate '45000'
        set message_text='name and description can''t be both null.';
    end if;        
END

-- 3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность
-- в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.
CREATE DEFINER=`root`@`localhost` FUNCTION `FIBONACCI`(n int) RETURNS int
    NO SQL
BEGIN
    declare f1 int default 0;
    declare f2 int default 1;
    declare f3 int default 1;
    if n < 2 then
        return n;
    else
        while n > 2 do
            set f1 = f3;
            set f3 = f3 + f2;
            set f2 = f1;
            set n = n - 1;
        end while;
    end if;
    RETURN f3;
END
