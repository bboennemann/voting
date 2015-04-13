class VotingRecommendationMailer < ApplicationMailer

	def recommend_voting email_to, from_name, voting_id
		@voting = Voting.find(voting_id)
		@sender = from_name

		mail(to: email_to, subject: "A votogenic recommendation from #{from_name}")

	end
end
