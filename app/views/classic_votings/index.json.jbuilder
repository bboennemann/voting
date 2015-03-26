json.array!(@classic_votings) do |classic_voting|
  json.extract! classic_voting, :id
  json.url classic_voting_url(classic_voting, format: :json)
end
