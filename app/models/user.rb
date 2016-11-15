class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
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
