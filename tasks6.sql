-- 1. Проанализировать запросы, которые выполнялись на занятии, определить возможные корректировки и/или улучшения (JOIN пока не применять).
Нет замечаний.

-- 2. Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
-- Для пользователя id=11
select from_user_id, count(*) from message
    where from_user_id in (select if(from_user_id=11, to_user_id, from_user_id) from friend_request
        where 11 in (from_user_id, to_user_id) and status=1)
    group by from_user_id order by 2 desc limit 1

-- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

-- Вариант 1
-- Так не работает почему-то. Неправильный результат выдает. Объясните почему?
select
	sum((select count(*) from `like` where
		case when media_id is not null then (select user_id from media where id=like.media_id)
			 when post_id is not null then (select user_id from post where id=like.post_id)
			 else (select user_id from message where id=like.message_id)
		end = p.user_id))
    from `profile` p order by birthday desc limit 10

-- Вариант 2
select sum(n) from
	(select (select count(*) from `like` where
		case when media_id is not null then (select user_id from media where id=like.media_id)
			 when post_id is not null then (select user_id from post where id=like.post_id)
			 else (select user_id from message where id=like.message_id)
		end = p.user_id) n
	from `profile` p order by birthday desc limit 10) t

-- Вариант 3. Думаю, он лучше по скорости, чем вариант 2. Как вы считаете?
select count(*) from `like` where
	case when media_id is not null then (select user_id from media where id=like.media_id)
		 when post_id is not null then (select user_id from post where id=like.post_id)
		 else (select user_id from message where id=like.message_id)
	end in (select user_id from (select user_id from `profile` order by birthday desc limit 10) t)

-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?
select (select gender from `profile` p where p.user_id=l.user_id) gender, count(*) likes
from `like` l group by 1 order by 2 desc limit 1

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
select user_id, concat(firstname, ' ', lastname) `name`,
	(select count(*) from friend_request where from_user_id=p.user_id)
    + (select count(*) from friend_request where to_user_id=p.user_id and status!=0)
    + (select count(*) from `like` l where l.user_id=p.user_id)
    + (select count(*) from media m where m.user_id=p.user_id
		and !exists(select 1 from message ms where ms.from_user_id=p.user_id and ms.media_id=m.id)
        and !exists(select 1 from post ps where ps.user_id=p.user_id and ps.media_id=m.id))
	+ (select count(*) from message m where m.from_user_id=p.user_id)
    + (select count(*) from post ps where ps.user_id=p.user_id)
from `profile` p order by 3 limit 10
