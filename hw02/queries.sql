-- 1. max scrobbles
select artist_lastfm from hue__tmp_artists
where scrobbles_lastfm in ( 
    select max(scrobbles_lastfm) from hue__tmp_artists)

-- result:
-- The Beatles

-- 2. most popular tag
SELECT tag_lastfm, count(*) as tagcnt FROM hue__tmp_artists
lateral view explode(split(tags_lastfm,';')) tag_table as tag_lastfm
where tag_lastfm != ''
group by tag_lastfm
order by tagcnt DESC
limit 1

-- result:
--  tag_lastfm | tagcnt 
--  "seen live" | 56245

-- 3. most popular artists in most popular tags
WITH top_tags as  (SELECT tag_lastfm, count(*) as tagcnt FROM hue__tmp_artists
lateral view explode(split(tags_lastfm,';')) tag_table as tag_lastfm
where tag_lastfm != ''
group by tag_lastfm
order by tagcnt DESC
limit 10),
top_artists as (
SELECT tag_lastfm, artist_lastfm, listeners_lastfm FROM hue__tmp_artists
lateral view explode(split(tags_lastfm,';')) tag_table as tag_lastfm
)

Select DISTINCT artist_lastfm, listeners_lastfm FROM top_artists where tag_lastfm in (SELECT tag_lastfm FROM top_tags)
order by listeners_lastfm DESC
limit 10

-- result:
--   artist_lastfm listeners_lastfm 
-- 1 Coldplay 5381567 
-- 2 Radiohead 4732528 
-- 3 Red Hot Chili Peppers 4620835 
-- 4 Rihanna 4558193 
-- 5 Eminem 4517997 
-- 6 The Killers 4428868 
-- 7 Kanye West 4390502 
-- 8 Nirvana 4272894 
-- 9 Muse 4089612 
-- 10 Queen 4023379


-- 4. most popular jazz artists by most popular tags
WITH top_tags as  (SELECT tag_lastfm, count(*) as tagcnt FROM hue__tmp_artists
lateral view explode(split(tags_lastfm,';')) tag_table as tag_ltag_lastfmf
where tag_lastfm != '' and tag_lastfm == 'jazz'
group by tag_lastfm
order by tagcnt DESC
limit 10),
top_artists as (
SELECT tag_lastfm, artist_lastfm, listeners_lastfm FROM hue__tmp_artists
lateral view explode(split(tags_lastfm,';')) tag_table as tag_lastfm
)

Select DISTINCT artist_lastfm, listeners_lastfm FROM top_artists where tag_lastfm in (SELECT tag_lastfm FROM top_tags)
order by listeners_lastfm DESC
limit 10
-- result:
-- artist_lastfm listeners_lastfm 
-- 1 Frank Sinatra 2357629 
-- 2 Norah Jones 2062669 
-- 3 Michael Bublé 1820040 
-- 4 Nina Simone 1797381 
-- 5 Louis Armstrong 1713540 
-- 6 Ray Charles 1671596 
-- 7 Ella Fitzgerald 1626346 
-- 8 Miles Davis 1518952 
-- 9 Nat King Cole 1495324 
-- 10 Dean Martin 1271988