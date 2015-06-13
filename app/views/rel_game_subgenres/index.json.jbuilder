json.array!(@rel_game_subgenres) do |rel_game_subgenre|
  json.extract! rel_game_subgenre, :id, :game_id, :subgenre_id
  json.url rel_game_subgenre_url(rel_game_subgenre, format: :json)
end
