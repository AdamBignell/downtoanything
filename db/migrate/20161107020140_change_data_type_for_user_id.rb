class ChangeDataTypeForUserId < ActiveRecord::Migration
  def self.up
    change_table :challenges do |t|
      t.change :user_id, :string
    end
  end
  def self.down
    change_table :challenges do |t|
      t.change :user_id, :integer
    end
  end
end
