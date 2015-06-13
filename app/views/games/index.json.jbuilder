json.array!(@games) do |game|
  json.extract! game, :id, :title, :poster_url, :price, :genre, :story, :brand_id, :getchu_id, :release_date
  json.url game_url(game, format: :json)
end
