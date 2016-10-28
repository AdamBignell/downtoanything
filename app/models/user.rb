class User < ActiveRecord::Base
end

class Challenge < ActiveRecord::Base
	has_one :user
end