json.array!(@voting_complaints) do |voting_complaint|
  json.extract! voting_complaint, :id
  json.url voting_complaint_url(voting_complaint, format: :json)
end
