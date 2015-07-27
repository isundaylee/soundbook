json.extract! @album, :id, :title, :description, :created_at, :updated_at
json.cover_url @album.cover_url
json.songs_url album_songs_url(@album, format: :json)
