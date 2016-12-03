class ChangeTitleToName < ActiveRecord::Migration
  def change
  	rename_column :submissions, :title, :name
  end
end
