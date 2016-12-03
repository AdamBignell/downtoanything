class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :points
      t.integer :members

      t.timestamps null: false
    end
  end
end
