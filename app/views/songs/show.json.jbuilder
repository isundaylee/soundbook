json.extract! @song, :id, :title, :album_id, :created_at, :updated_at, :description
json.song @song.song_url
