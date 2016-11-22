class Challenge < ActiveRecord::Base
	has_many :us_chal_interactions, :dependent => :destroy
	has_many :users, :through => :us_chal_interactions
	has_many :submissions, :dependent => :destroy # if a challenge is deleted, all submissions under that challenge should be deleted also
	validates_length_of :name, :maximum => 50
	validates_length_of :description, :maximum => 500
end

def Challenge.search(search)
	where("name LIKE ?", "%#{search}%")
end
