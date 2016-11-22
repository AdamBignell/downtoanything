class User < ActiveRecord::Base
	has_many :submissions
	has_many :challenges
  	belongs_to :team
	has_secure_password

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
	validates :email, :presence => true,
                    :format => EMAIL_REGEX

  before_save :default_values
  def default_values
    self.team ||= nil
    self.points ||= 0
  end
end
