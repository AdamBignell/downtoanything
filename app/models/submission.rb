class Submission < ActiveRecord::Base
	has_many :user_interactions, :dependent => :destroy
	has_many :users, :through => :user_interactions
	has_many :comments
	belongs_to :challenge
end
