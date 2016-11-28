class Team < ActiveRecord::Base
	has_many :users

	validates_length_of :name, :maximum => 30
end