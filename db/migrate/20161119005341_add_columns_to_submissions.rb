class AddColumnsToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :embed, :string
    add_column :submissions, :description, :text
    add_column :submissions, :title, :string
    add_column :submissions, :duration, :float
    add_column :submissions, :thumbnail, :string
  end
end
