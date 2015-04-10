class User
  include Mongoid::Document
  include Mongoid::Paperclip

  #has_many :votings, dependent: :destroy

  has_many :friend_requests, class_name: 'FriendRequest', inverse_of: :user, dependent: :destroy
  has_many :requested_friends, class_name: 'FriendRequest', inverse_of: :requester, dependent: :destroy

  validates_presence_of :first_name, message: ": Please tell us your first name."
  validates_presence_of :last_name, message: ": Please tell us your last name."

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#, :confirmable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  # custom user fields
  field :first_name,  type: String
  field :last_name,   type: String
  field :about,       type: String
  field :sex,         type: String, default: "N"
  field :dob,         type: Date
  field :friends,      type: Array, :default => []
  field :interests,      type: Array, :default => []

  has_mongoid_attached_file :user_image,
    :storage        => :s3,
    :s3_host_name   => 's3.amazonaws.com',
    :path           => '/' + Rails.env.to_s + '/user_image/:id/:style.:extension',
    :s3_credentials => Rails.configuration.x.s3.credentials,
    :styles         => Rails.configuration.x.user_image.sizes,
    :default_url    => '/placeholder.jpg'

  validates_attachment :user_image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  private

  def full_name
    first_name + ' ' + last_name   
  end
end
