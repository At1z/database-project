CREATE TYPE creator_type AS ENUM ('Artist', 'Podcaster');

CREATE TABLE Creators (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  bio TEXT,
  photo_url VARCHAR(255),
  monthly_listeners INT,
  type_creator creator_type NOT NULL
);

CREATE TABLE Podcasts (
  podcast_id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  avg_rating FLOAT CHECK (avg_rating >= 1 AND avg_rating <= 5),
  creator_id INT REFERENCES Creators(id) ON DELETE CASCADE,
  cover_url VARCHAR(255)
);

CREATE TYPE album_type AS ENUM ('Album', 'EP');

CREATE TABLE Albums (
  album_id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  release_date TIMESTAMP DEFAULT NOW(),
  type_album album_type NOT NULL,
  creator_id INT REFERENCES Creators(id) ON DELETE CASCADE,
  cover_url VARCHAR(255),
  avg_rating FLOAT CHECK (avg_rating >= 1 AND avg_rating <= 5)
);

CREATE TABLE Songs (
  song_id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  album_id INT REFERENCES Albums(album_id) ON DELETE CASCADE,
  creator_id INT REFERENCES Creators(id) ON DELETE CASCADE,
  likes INT DEFAULT 0,
  music_video_url VARCHAR(255),
  audio_track_url VARCHAR(255),
  duration INT,
  avg_rating FLOAT CHECK (avg_rating >= 1 AND avg_rating <= 5)
);

CREATE TABLE Podcasts_episodes (
  episode_id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  release_date TIMESTAMP DEFAULT NOW(),
  podcast_id INT REFERENCES Podcasts(podcast_id) ON DELETE CASCADE,
  cover_url VARCHAR(255)
);

CREATE TYPE subscription_type AS ENUM ('Free', 'Premium', 'HiFi');

CREATE TABLE Users (
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  type_subscription subscription_type NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE Playlists(
  playlist_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  user_id INT REFERENCES Users(user_id) ON DELETE CASCADE,
  created_at TIMESTAMP DEFAULT NOW(),
  likes INT DEFAULT 0,
  is_private BOOLEAN,
  duration INT
);

CREATE TABLE Playlists_songs (   
  playlist_songs_id SERIAL PRIMARY KEY,   
  song_id INT REFERENCES Songs(song_id) ON DELETE CASCADE, 
  playlist_id INT REFERENCES Playlists(playlist_id) ON DELETE CASCADE,   
  added_at TIMESTAMP DEFAULT NOW() 
);

CREATE TABLE Podcasts_ratings (
  podcast_ratings_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES Users(user_id),
  podcast_id INT REFERENCES Podcasts(podcast_id),
  rating FLOAT CHECK (rating >= 1 AND rating <= 5),
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE Albums_ratings (  
  album_ratings_id SERIAL PRIMARY KEY, 
  user_id INT REFERENCES Users(user_id),
  album_id INT REFERENCES Albums(album_id), 
  rating FLOAT CHECK (rating >= 1 AND rating <= 5),
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE Songs_ratings (  
  song_ratings_id SERIAL PRIMARY KEY,  
  user_id INT REFERENCES Users(user_id),
  song_id INT REFERENCES Songs(song_id),  
  rating FLOAT CHECK (rating >= 1 AND rating <= 5),
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TYPE action_type AS ENUM ('INSERT', 'UPDATE', 'DELETE');

CREATE TABLE Audit_Log(
  audit_log_id SERIAL PRIMARY KEY,
  table_name VARCHAR(255),
  record_id INT,
  type_action action_type NOT NULL,
  old_value TEXT,
  new_value TEXT,
  user_id INT REFERENCES Users(user_id),
  modified_at TIMESTAMP DEFAULT NOW()
);

