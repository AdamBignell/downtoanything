class AddPasswordconfirmationForTeams < ActiveRecord::Migration
  def change
  	add_column :teams, :passwordconfirmation, :string
  end
end
