class ImageItem
  include Mongoid::Document
  include Mongoid::Paperclip

  require "open-uri"

  belongs_to :voting
  belongs_to :user

  field :voting_id,   type: String
  field :user_id,     type: String
  field :website_url, type: String
  field :image_url,    type: String
  field :hits,        type: Integer, default: 0
  field :score,       type: Integer, default: 0
  field :description, type: String
  field :created_at,  type: DateTime

  has_mongoid_attached_file :image_file,
    :storage        => :s3,
    :s3_host_name   => 's3.amazonaws.com',
    :path           => '/' + Rails.env.to_s + '/image_items/:id/:style.:extension',
    :s3_credentials => Rails.configuration.x.s3.credentials,
    :styles         => Rails.configuration.x.image.sizes

  validates_attachment :image_file, presence: true, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  def image_from_url(url)
    self.image_file = open(url)
  end

end
