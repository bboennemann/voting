json.array!(@votings) do |voting|
  json.extract! voting, :id
  json.url voting_url(voting, format: :json)
end
