class AddTeamDefaults < ActiveRecord::Migration

  def up
    change_column_default :teams, :points, 0
  end

  def down
    change_column_default :teams, :points, false
  end

end
