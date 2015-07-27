json.array!(@albums) do |album|
  json.extract! album, :id, :title, :description
  json.url album_url(album, format: :json)
  json.cover_url album.cover_url
end
