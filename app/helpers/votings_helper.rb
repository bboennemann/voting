module VotingsHelper
	def voting_type_path voting
		"/#{voting.voting_type}_votings/#{voting.id}"
	end

	def edit_items_path voting
		"/#{voting.voting_type}_votings/#{voting.id}/edit"
	end

	def delete_voting_path voting
		"/votings/#{voting.id}/delete"
	end

	def side_nav_active? link
		link.include?(controller_name) ? 'side-nav-active' : nil
	end

	def context_nav_active? context
		@context == context ? 'context-nav-active' : nil
	end

	def is_owner? owner_id
		if user_signed_in?
			owner_id.to_s == current_user.id.to_s ? true : false
		else
			false
		end
	end

	def highlight_owner? user_id
		is_owner?(user_id) ? 'bg-info' : ''
	end	

	def already_voted? voted_array
		if user_signed_in?
			voted_array.include?(current_user.id.to_s) || voted_array.include?(request.remote_ip.to_s)
		else
			voted_array.include?(request.remote_ip.to_s)
		end
	end
end
