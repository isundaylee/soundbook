json.array!(@songs) do |song|
  json.extract! song, :id, :title, :album_id, :description
  json.url song_url(song, format: :json)
end
