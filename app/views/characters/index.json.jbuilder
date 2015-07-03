json.array!(@characters) do |character|
  json.extract! character, :id, :name, :image_url, :game_id, :creator_id, :description
  json.url character_url(character, format: :json)
end
