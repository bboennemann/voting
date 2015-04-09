class ImageItem
  include Mongoid::Document
  include Mongoid::Paperclip

  belongs_to :voting
  belongs_to :user

  field :voting_id,   type: String
  field :user_id,     type: String
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

  def to_jq_upload
    {
      "name" => read_attribute(:image_file),
      "size" => image_file.size,
      "url" => image_file.url,
      "thumbnail_url" => image_file.url(:xxs),
      "delete_url" => "/image_items/#{id}",
      "delete_type" => "DELETE" 
    }
  end
end