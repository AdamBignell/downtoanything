class AddDefaults < ActiveRecord::Migration

  def change
    change_column_default :challenges, :score, 0
    change_column_default :submissions, :score, 0
    change_column_default :teams, :points, 0
    change_column_default :users, :points, 0
  end

end
