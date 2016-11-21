class Team < ActiveRecord::Base
	has_many :user

	validates_length_of :name, :maximum => 30
end