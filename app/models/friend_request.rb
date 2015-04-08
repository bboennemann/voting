class FriendRequest
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user, class_name: 'User', inverse_of: :friend_requests
  belongs_to :requester, class_name: 'User', inverse_of: :requested_friends

  field :user_id,			type: String
  field :requester_id,			type: String

end
