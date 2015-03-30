class Voting
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :image_items, dependent: :destroy

  belongs_to :user


  validates_presence_of :title, message: ": Your voting needs a title!"
  validates_presence_of :user_id, message: ": You need to be logged in to create a voting!"
  validates_presence_of :description, message: ": Your voting needs a short description!"
  
  #TODO: reconsider indexing. search by searchable, audience, hits? etc... probably better for solr..
  index({user_id: 1, searchable: 1}, {background: true})

  field :user_id, 		:type => String		# owner
  field	:online_from,	:type => Date, :default => Date.current().to_time
  field :online_to, 	:type => Date, :default => (Date.current() + Rails.configuration.x.voting.default_expiration).to_time 		# expriration date 
  field :title, 		:type => String 
  field :description, 	:type => String
  field :contribution, 	:type => Boolean, :default => true	# contribution possible, y/n
  field :searchable, 	:type => Boolean, :default => true	# appears in search results
  field :audience, 		:type => String, :default => 'everyone'  	# e.g. everyone, friends only, invited only, loged in users only
  field :active, 		:type => Boolean, :default => false 	# can be tmp disabled by owner
  field :hits, 			:type => Integer, default: 0	# de-normalized / redundant for faster access
  field	:voting_type,	:type => String		# e.g. classic, flip, etc.
  field :item_type, 	:type => String  	# e.g. picture, video, text, sound, website, etc
  field :items, 		:type => Array, :default => []		# array of subject IDs. should actually be 'has many', but can be different subject types. maybe multiple optional has many references?

  
  protected

end
