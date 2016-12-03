class Team < ActiveRecord::Base
	has_many :users

	attr_accessor :password

	validates :password, :confirmation => true
end
