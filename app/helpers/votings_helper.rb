module VotingsHelper
	def voting_path voting
		"/#{voting.voting_type}_votings/#{voting.id}"
	end

	def edit_items_path voting
		"/#{voting.voting_type}_votings/#{voting.id}/edit"
	end

	def delete_voting_path voting
		"/votings/#{voting.id}/delete"
	end

	def side_nav_active? link
		controller_name.include?(link) ? 'side-nav-active' : nil
	end

	def context_nav_active? context
		@context == context ? 'context-nav-active' : nil
	end
end
