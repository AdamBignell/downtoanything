class Team < ActiveRecord::Base
	has_many :users

	def members
		users.count
	end
end
