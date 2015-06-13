json.array!(@reviews) do |review|
  json.extract! review, :id, :score, :content, :user_id, :game_id, :reviewed
  json.url review_url(review, format: :json)
end
