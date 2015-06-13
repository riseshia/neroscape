json.array!(@characters) do |character|
  json.extract! character, :id, :name, :image_url, :game_id, :reator_id, :description
  json.url character_url(character, format: :json)
end
