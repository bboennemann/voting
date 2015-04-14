class VotingComplaint
  include Mongoid::Document
  include Mongoid::Timestamps

  has_one 		:voting
  belongs_to  	:user

  field :user_id, 	type: String
  field :voting_id,	type: String

  field :reason, 	type: String
  field :comment, 	type: String
  field :email, 	type: String
  field :name, 		type: String

 end