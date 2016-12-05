class Team < ActiveRecord::Base
	has_many :users

	attr_accessor :password

	validates :password, :confirmation => true
	validates :users, length: { minimum: 1, maximum: 10, message: "Team is full" }
end
