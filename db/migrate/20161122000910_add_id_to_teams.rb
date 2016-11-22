class AddTeamIdToTeams < ActiveRecord::Migration
  def change
  	remove_column "teams",  "team_id"
    add_column :teams, :id, :integer
  end
end
