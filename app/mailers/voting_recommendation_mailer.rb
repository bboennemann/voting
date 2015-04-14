class VotingRecommendationMailer < ApplicationMailer

	def recommend_voting to_email, name_to, name_from, voting_id

		@voting = Voting.find(voting_id)
		@receiver_name = name_to
		@sender = name_from

		puts @sender
		puts @receiver_name	

		mail(to: to_email, subject: determine_subject)
	end

	def determine_subject
		"#{@sender} recommends #{@voting.title}"
	end

end
