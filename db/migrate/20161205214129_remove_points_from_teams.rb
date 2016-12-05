class RemovePointsFromTeams < ActiveRecord::Migration
  def change
    remove_column('teams', 'points')
  end
end
