class Challenge < ActiveRecord::Base
	belongs_to :user
	has_many :submissions
end

def Challenge.search(search)
	where("name LIKE ?", "%#{search}%")
end
