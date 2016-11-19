class CreateUserInteractions < ActiveRecord::Migration
  def change
    create_table :user_interactions do |t|
      t.integer :user_id
      t.integer :submission_id
      t.string :interaction
      t.timestamps null: false
    end
    add_index :user_interactions, ["user_id", "submission_id"]
  end
end
