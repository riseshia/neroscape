json.array!(@brands) do |brand|
  json.extract! brand, :id, :name, :homepage_url, :getchu_id
  json.url brand_url(brand, format: :json)
end
