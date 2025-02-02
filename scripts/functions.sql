CREATE OR REPLACE FUNCTION update_avg_rating() 
RETURNS TRIGGER AS $$
BEGIN
  IF TG_TABLE_NAME = 'podcasts_ratings' THEN
    UPDATE Podcasts
    SET avg_rating = (
      SELECT AVG(rating)
      FROM Podcasts_ratings
      WHERE podcast_id = NEW.podcast_id
    )
    WHERE podcast_id = NEW.podcast_id;
  ELSIF TG_TABLE_NAME = 'albums_ratings' THEN
    UPDATE Albums
    SET avg_rating = (
      SELECT AVG(rating)
      FROM Albums_ratings
      WHERE album_id = NEW.album_id
    )
    WHERE album_id = NEW.album_id;
  ELSIF TG_TABLE_NAME = 'songs_ratings' THEN
    UPDATE Songs
    SET avg_rating = (
      SELECT AVG(rating)
      FROM Songs_ratings
      WHERE song_id = NEW.song_id
    )
    WHERE song_id = NEW.song_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;