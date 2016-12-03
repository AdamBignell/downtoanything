class AddPassAndDescToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :description, :string
    add_column :teams, :password, :string
  end
end
