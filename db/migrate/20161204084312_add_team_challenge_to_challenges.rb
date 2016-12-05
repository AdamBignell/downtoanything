class AddTeamChallengeToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :team, :boolean
  end
end
