CREATE TRIGGER update_podcast_avg_rating
AFTER INSERT ON Podcasts_ratings
FOR EACH ROW
EXECUTE PROCEDURE update_avg_rating();

CREATE TRIGGER update_album_avg_rating
AFTER INSERT ON Albums_ratings
FOR EACH ROW
EXECUTE PROCEDURE update_avg_rating();

CREATE TRIGGER update_song_avg_rating
AFTER INSERT ON Songs_ratings
FOR EACH ROW
EXECUTE PROCEDURE update_avg_rating();