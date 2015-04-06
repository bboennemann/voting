class FriendRequest
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :user_id,			type: String
  field :requester_id,		type: String

end
