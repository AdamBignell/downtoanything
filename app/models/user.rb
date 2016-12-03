class User < ActiveRecord::Base
  has_merit


	has_many :user_interactions, :dependent => :destroy
	has_many :submissions, :through => :user_interactions, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:google_oauth2]

	has_many :us_chal_interactions, :dependent => :destroy
	has_many :challenges, :through => :us_chal_interactions, :dependent => :destroy
	has_many :comments, :dependent => :destroy
  belongs_to :team

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
	validates :email, :presence => true, :format => EMAIL_REGEX, uniqueness: true
  validates :username, :presence => true, uniqueness: true
  validates_length_of :username, :maximum => 20

  after_initialize :set_defaults, unless: :persisted?
  
  mount_uploader :image, ImageUploader

  def self.search(search)
    where("username LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%")
  end

  def set_defaults
   
  end

  def self.google_from_omniauth(access_token)
      data = access_token
      user = User.where(:email => data['info']["email"]).first

      unless user
        user = User.create(
              email: data['info']['email'],
              password: Devise.friendly_token[0,20],
              provider: data['provider'],
              username: data['info']["email"],
              uid: data['uid']
           )
        user.remote_image_url = data['info']['image']
       end

      # skip confirmation email when using oauth
      user.skip_confirmation!

      return user
  end
end
