class AddDefaults < ActiveRecord::Migration

  def up
    change_column_default :challenges, :score, 0
    change_column_default :submissions, :score, 0
    change_column_default :teams, :points, 0
    change_column_default :users, :points, 0
  end

  def down
    change_column_default :challenges, :score, false
    change_column_default :submissions, :score, false
    change_column_default :teams, :points, false
    change_column_default :users, :points, false
  end

end
