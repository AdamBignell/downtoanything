class User < ActiveRecord::Base
	has_many :submissions, :dependent => :destroy
	has_many :challenges, :dependent => :destroy
  belongs_to :team
	has_secure_password

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
	validates :email, :presence => true,
                    :format => EMAIL_REGEX
end
