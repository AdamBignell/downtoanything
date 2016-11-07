class User < ActiveRecord::Base

	has_secure_password

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
	validates :email, :presence => true,
                    :format => EMAIL_REGEX
end

class Challenge < ActiveRecord::Base
	belongs_to :user
end

class Submission < ActiveRecord::Base
	belongs_to :user
end
