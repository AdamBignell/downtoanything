class Challenge < ActiveRecord::Base
end

class User < ActiveRecord::Base
	belongs_to :user
end