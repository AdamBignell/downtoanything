class AddUrlToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :url, :string
  end
end
