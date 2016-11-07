class Submission < ActiveRecord::Base
end

class User < ActiveRecord::Base
	has_many :submissions, :dependent => :delete_all
end

class Challenge < ActiveRecord::Base
	has_many :submissions, :dependent => :delete_all
end