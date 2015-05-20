class VotingRecommendationMailer < ApplicationMailer

	def recommend_voting to_email, name_to, name_from, voting_id

		@voting = Voting.find(voting_id)
		@receiver_name = name_to
		@sender = name_from
		@voting_url = url_for controller: "/#{@voting.voting_type}_votings", id: @voting.id.to_s, action: :show 
		if @voting.voting_type == 'classic'
			@voting_url += "?autostart=true"
		end

		mail(to: to_email, subject: determine_subject)
	end

	def determine_subject
		"#{@sender} recommends #{@voting.title}"
	end

end
