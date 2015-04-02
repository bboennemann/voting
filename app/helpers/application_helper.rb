module ApplicationHelper
	def is_owner? user_id
		if user_signed_in?
			user_id == current_user.id ? false : true
		else
			false
		end
	end

end
