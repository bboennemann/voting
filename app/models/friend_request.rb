class FriendRequest
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :user_id,			type: String
  field :friend_id,			type: String

end
