-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
-- Вариант 1
select distinct u.id, name from users u join orders o on u.id=o.user_id;
-- Вариант 2
select id, name from users u where exists(select 1 from orders o where u.id=o.user_id);

-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару
select p.name, c.name from products p left join catalogs c on p.catalog_id=c.id

-- 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
-- Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.
select id, b.name `from`, c.name `to` from flights a
	left join cities b on a.`from`=b.label
    left join cities c on a.`to`=c.label
