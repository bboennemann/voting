class ImageItem
  include Mongoid::Document
  include Mongoid::Paperclip

  belongs_to :voting

  field :voting_id, type: String
  field :hits, 		type: Integer
  field :score, 	type: Integer

  has_mongoid_attached_file :image_file,
    :storage        => :s3,
    :s3_credentials => Rails.configuration.x.s3.credentials,
    :path           => Rails.env + '/images/' + ':id/:style.:extension',
    :url            => 'http://s3.amazonaws.com/' + Rails.env + '/images/' + ':id/:style.:extension',
    :styles         => Rails.configuration.x.image.sizes


end
