class ChangeBodyToBodytext < ActiveRecord::Migration
  def change
  	rename_column :comments, :body, :bodytext
  end
end
