class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :username
      t.integer :points
      t.string :team

      t.timestamps null: false
    end
  end
end
