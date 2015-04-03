module ApplicationHelper
	def is_owner? user_id
		if user_signed_in?
			user_id == current_user.id ? false : true
		else
			false
		end
	end

	def highlight_owner? user_id
		is_owner?(user_id) ? 'bg-success' : ''
	end

end
