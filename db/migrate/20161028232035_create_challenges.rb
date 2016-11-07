class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :user_id
      t.string :name
      t.integer :score

      t.timestamps null: false
    end
  end
end
