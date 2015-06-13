json.array!(@subgenres) do |subgenre|
  json.extract! subgenre, :id, :name
  json.url subgenre_url(subgenre, format: :json)
end
