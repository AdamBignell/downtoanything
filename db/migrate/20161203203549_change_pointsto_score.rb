class ChangePointstoScore < ActiveRecord::Migration
  def change
  	rename_column :users, :points, :userscore
  end
end
