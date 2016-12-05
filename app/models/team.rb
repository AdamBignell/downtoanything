class Team < ActiveRecord::Base
	has_many :users

	def points
		users.sum(:userscore)
	end

	attr_accessor :password

	validates :password, :confirmation => true
	validates :users, length: { maximum: 10, message: "Team is full" }
end