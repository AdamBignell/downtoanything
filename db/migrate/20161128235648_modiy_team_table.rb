class ModiyTeamTable < ActiveRecord::Migration
  def change
    remove_column('teams', 'members')
    add_column('users','team_id', 'integer');
  end
end
