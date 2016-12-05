class UsChalInteraction < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge

  INTERACTION_TYPES = ['created', 'liked', 'disliked', 'neutral']

  validates :user_id, :challenge_id, :interaction, :presence => true
  validates_inclusion_of :interaction, :in => INTERACTION_TYPES, :message => "must be one of: #{INTERACTION_TYPES.join(', ')}"

end
