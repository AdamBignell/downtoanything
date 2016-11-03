class User < ActiveRecord::Base
end

class Challenge < ActiveRecord::Base
	belongs_to :user
end

class Submission < ActiveRecord::Base
	belongs_to :user
end