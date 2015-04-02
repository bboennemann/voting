module VotingsHelper
	def voting_path voting
		"/#{voting.voting_type}_votings/#{voting.id}"
	end

	def edit_items_path voting
		"/#{voting.voting_type}_votings/#{voting.id}/edit"
	end
end
