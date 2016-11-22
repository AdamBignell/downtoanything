class Team < ActiveRecord::Base
	has_many :users
	before_save :default_values
  	def default_values
    	self.points ||= 0
  	end
end