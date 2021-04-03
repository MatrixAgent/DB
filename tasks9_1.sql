-- Практическое задание по теме “Транзакции, переменные, представления”

-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
start transaction;
insert sample.users (id, name) select id, name from shop.users where id=1;
delete from shop.users where id=1;
commit;

-- 2. Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `prod_view` AS
    SELECT 
        `p`.`name` AS `product`, `c`.`name` AS `catalog`
    FROM
        (`products` `p`
        JOIN `catalogs` `c` ON ((`p`.`catalog_id` = `c`.`id`)))

-- 3. по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи за август 2018 года
-- '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в соседнем
-- поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует
drop table if exists digits;
create table digits (d numeric(1)) engine=heap;
insert digits values (0), (1), (2), (3), (4), (5), (6), (7), (8), (9); 
drop table if exists dates;
create temporary table dates (created_at date);
insert dates values
    ('2018-08-01'), ('2018-08-04'), ('2018-08-16'), ('2018-08-17');

select dt, !isnull(created_at) from
    (select cast('2018-08-01' as date) + a.d + b.d*10 as dt
        from digits a, digits b where a. d + b.d*10 < 31) t 
    left join dates on dt=created_at 
    order by dt;
    
drop table digits;
drop table dates;

-- 4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
drop table if exists dates;
create table dates (created_at date);
insert dates values
    ('2018-08-01'), ('2018-08-04'), ('2018-08-16'), ('2018-08-17'),
    ('2018-08-20'), ('2018-08-22');
drop view if exists notdel;
create view notdel as
    select created_at from dates order by created_at desc limit 5;
delete from dates where created_at not in (select * from notdel);
select * from dates;
drop table dates;
drop view notdel;
