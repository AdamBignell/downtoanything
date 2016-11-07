class AddPasswordDigestToUsers < ActiveRecord::Migration
  def up
    remove_column "users",  "password"
    add_column "users", "password_digest", :string
  end

  def down
    remove_column "users", "password_digest"
    add_column "users", "password", :string
  end

end
