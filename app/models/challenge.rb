class Challenge < ActiveRecord::Base
	belongs_to :user
	has_many :submissions, :dependent => :destroy # if a challenge is deleted, all submissions under that challenge should be deleted also
end

def Challenge.search(search)
	where("name LIKE ?", "%#{search}%")
end
