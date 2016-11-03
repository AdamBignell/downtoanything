class Challenge < ActiveRecord::Base
end

class User < ActiveRecord::Base
	has_many :challenges, :dependent => :delete_all
end