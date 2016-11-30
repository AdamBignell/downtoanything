class CreateUsChalInteractions < ActiveRecord::Migration
  def change
    create_table :us_chal_interactions do |t|
      t.integer :user_id
      t.integer :challenge_id
      t.string :interaction
      t.timestamps null: false
      end
    add_index :us_chal_interactions, ["user_id", "challenge_id"]
  end
end
