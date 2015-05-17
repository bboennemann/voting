json.array!(@grid_votings) do |grid_voting|
  json.extract! grid_voting, :id
  json.url grid_voting_url(grid_voting, format: :json)
end
