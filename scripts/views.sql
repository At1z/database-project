CREATE OR REPLACE VIEW v_top_rated_podcasts AS
SELECT podcast_id, title, avg_rating
FROM Podcasts
ORDER BY avg_rating DESC
LIMIT 10;

CREATE OR REPLACE VIEW v_creator_overview AS
SELECT c.id, c.name, COUNT(a.album_id) AS total_albums
FROM Creators c
LEFT JOIN Albums a ON c.id = a.creator_id
GROUP BY c.id, c.name;

CREATE OR REPLACE VIEW v_top_rated_albums AS
SELECT album_id, title, avg_rating
FROM Albums
ORDER BY avg_rating DESC
LIMIT 10;