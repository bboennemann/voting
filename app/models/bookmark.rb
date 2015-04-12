class Bookmark
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :user_id, type: String
  field :voting_id, type: String
end
