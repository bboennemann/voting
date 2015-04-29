class ImageItem
  include Mongoid::Document
  include Mongoid::Paperclip

  require "open-uri"

  belongs_to :voting
  belongs_to :user

  field :voting_id,   type: String
  field :user_id,     type: String
  field :website_url, type: String
  field :image_url,   type: String
  field :hits,        type: Integer, default: 0
  field :score,       type: Float, default: 0
  field :description, type: String
  field :voters,      type: Array, :default => []
  field :created_at,  type: DateTime
  field :already_voted, type: Boolean, default: false

  has_mongoid_attached_file :image_file,
    :storage        => :s3,
    :s3_host_name   => 's3.amazonaws.com',
    :path           => '/' + Rails.env.to_s + '/image_items/:id/:style.:extension',
    :s3_credentials => Rails.configuration.x.s3.credentials,
    :styles         => Rails.configuration.x.image.sizes

  validates_attachment :image_file, presence: true, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  def update_score result
    self.score = ((self.score * self.hits) + result.to_i) / (self.hits + 1)
  end

  def image_from_url(url)
    self.image_file = open(url)
  end

  # strip out 'confidential information', e.g. before sending as xml or json and prepare values for display
  def prepare_display
    self.score = self.score.round(2)
  end

  def vote (ip, result, user_id)
    unless check_repeat_voting(ip, user_id)  # this ip/user did "not" yet vote for this subject
      update_score(result)
      self.inc(hits: 1)
      remember_ip(ip)
      self.voting.inc(hits: 1)
      self.voting.save
      if !user_id.nil?
        remember_user(user_id)
      end
    end

  end

  # check if this user already voted for this subject based on his UID or IP
  # ip should always be stored, UID should be stored additionally if available
  def check_repeat_voting (ip, user_id)
    if !user_id.nil?
      self.voters.include?(user_id)
    else
      self.voters.include?(ip) # IP should allways be stored
    end
  end

  def remember_ip (ip)
    self.voters.shift if self.voters.length >= 100 # TBD length value needs to be configurable
    self.voters.push(ip)
  end
  
  def remember_user (user_id)
    self.voters.shift if self.voters.length >= 100 # TBD length value needs to be configurable
    self.voters.push(user_id)
  end

end
