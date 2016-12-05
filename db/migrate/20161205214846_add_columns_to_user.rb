class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :birthdate, :date
    add_column :users, :location, :string
    add_column :users, :bio, :string
  end
end
