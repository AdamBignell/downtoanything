class Submission < ActiveRecord::Base
	has_many :user_interactions
	has_many :users, :through => :user_interactions
	has_many :comments
	belongs_to :challenge
	belongs_to :user
end
