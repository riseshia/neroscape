json.array!(@appearances) do |appearance|
  json.extract! appearance, :id, :creator_id, :game_id, :role_id
  json.url appearance_url(appearance, format: :json)
end
