class ActuallyRemoveUserIdFromChallenges < ActiveRecord::Migration
  def up
    remove_column :challenges, :user_id
  end

  def downvote
    add_column :challenges, :user_id, :integer
  end
end
