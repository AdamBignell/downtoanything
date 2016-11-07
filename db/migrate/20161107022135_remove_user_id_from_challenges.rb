class RemoveUserIdFromChallenges < ActiveRecord::Migration
  def change
    remove_column :challenges, :user_id, :string
  end
end
