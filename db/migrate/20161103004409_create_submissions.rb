class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :user
      t.integer :score
      t.integer :user_id
      t.integer :challenge_id

      t.timestamps null: false
    end
  end
end
