class UserInteraction < ActiveRecord::Base
  belongs_to :user
  belongs_to :submission

  INTERACTION_TYPES = ['created', 'liked', 'disliked', 'neutral']

  validates_inclusion_of :interaction, :in => INTERACTION_TYPES, :message => "must be one of: #{INTERACTION_TYPES.join(', ')}"
end
