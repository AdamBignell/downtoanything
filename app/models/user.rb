class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:google_oauth2]
	has_many :submissions, :dependent => :destroy
	has_many :challenges, :dependent => :destroy
  belongs_to :team

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
	validates :email, :presence => true,
                    :format => EMAIL_REGEX
end

def User.search(search)
	where("username LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%")
end

def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
   unless user
        user = User.create(name: data["name"],
            email: data["email"],
            password: Devise.friendly_token[0,20]
         )
    end
    user
end