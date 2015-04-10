class VotingRecommendationMailer < ApplicationMailer

	def recommend_voting(user_id, voting_id, email_to, name_to)
		@user = User.find(user_id)
		@voting = Voting.find(voting_id)

		mail(to: email_to, subject: "A votogenic recommendation from #{@user.full_name}")

	end
end
