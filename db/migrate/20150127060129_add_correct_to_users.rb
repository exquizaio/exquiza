class AddCorrectToUsers < ActiveRecord::Migration
  def change
    add_column :users, :correct, :boolean
  end
end
